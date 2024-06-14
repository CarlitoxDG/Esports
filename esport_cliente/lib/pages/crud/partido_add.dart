import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class PartidoAdd extends StatefulWidget {
  final int campeonatoId;

  const PartidoAdd({super.key, required this.campeonatoId});

  @override
  _PartidoAddState createState() => _PartidoAddState();
}

class _PartidoAddState extends State<PartidoAdd> {
  final TextEditingController paisController = TextEditingController();
  final TextEditingController ciudadController = TextEditingController();
  final TextEditingController sedeController = TextEditingController();
  final TextEditingController resultadoController = TextEditingController();
  DateTime _fechaSeleccionada = DateTime.now();
  String _equipoSeleccionado1 = 'sel 1';
  String _equipoSeleccionado2 = 'sel 2';
  List<String> _equipos = [];

  void initState() {
    super.initState();
    _cargarEquipos();
  }

  Future<void> enviarDatosPartido() async {
    DateTime fechaSeleccionada = _fechaSeleccionada;
    int equipo1IdSeleccionado = _equipos.indexOf(_equipoSeleccionado1) + 1;
    int equipo2IdSeleccionado = _equipos.indexOf(_equipoSeleccionado2) + 1;

    // Llama a la función para enviar los datos del partido a la API
    HttpService().enviarDatosPartido(
      fecha: fechaSeleccionada,
      pais: paisController.text,
      ciudad: ciudadController.text,
      sede: sedeController.text,
      resultado: resultadoController.text,
      campeonato: widget.campeonatoId,
      equipo1: equipo1IdSeleccionado,
      equipo2: equipo2IdSeleccionado,
    );
  }

  Future<void> _cargarEquipos() async {
    try {
      List<dynamic> equipos =
          await HttpService().equiposEnCampeonato(widget.campeonatoId);
      setState(() {
        _equipos =
            equipos.map((equipo) => equipo['nombre'].toString()).toList();
      });
    } catch (e) {
      print('Error al cargar equipos: $e');
    }
  }

  Widget _buildEquipoDropdown(String value, ValueChanged<String> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _equipos
          .map((equipo) => Column(
                children: [
                  ListTile(
                    title: Text(
                      equipo,
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: Image.asset(
                      'assets/images/Equipos/$equipo.png',
                      height: 40,
                      width: 40,
                    ),
                    onTap: () {
                      onChanged(equipo);

                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 10),
                ],
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Partido'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Seleccionar Equipos'),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildEquipoDropdown(_equipoSeleccionado1,
                                (String newValue) {
                              setState(() {
                                _equipoSeleccionado1 = newValue;
                              });
                            }),
                            SizedBox(height: 20),
                            _buildEquipoDropdown(_equipoSeleccionado2,
                                (String newValue) {
                              setState(() {
                                _equipoSeleccionado2 = newValue;
                              });
                            }),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text('Seleccionar Equipos'),
            ),
            OutlinedButton(
              onPressed: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  onChanged: (date) {
                    setState(() {
                      _fechaSeleccionada = date;
                    });
                  },
                  currentTime: DateTime.now(),
                  locale: LocaleType.es,
                );
              },
              child: Text(
                'Seleccionar Fecha: $_fechaSeleccionada',
              ),
            ),
            // Agregar más campos para otros datos del partido (por ejemplo, resultado, sede, etc.)
            TextFormField(
              controller: paisController,
            ),
            TextFormField(
              controller: ciudadController,
            ),
            TextFormField(
              controller: sedeController,
            ),
            TextFormField(
              controller: resultadoController,
            ),
            ElevatedButton(
              onPressed: () {
                // Enviar los datos del partido a la API
                enviarDatosPartido();
                Navigator.pop(context);
              },
              child: Text('Crear Partido'),
            ),
          ],
        ),
      ),
    );
  }
}
