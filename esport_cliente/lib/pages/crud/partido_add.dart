import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class PartidoCrear extends StatefulWidget {
  final int campeonatoId;

  const PartidoCrear({Key? key, required this.campeonatoId}) : super(key: key);

  @override
  _PartidoCrearState createState() => _PartidoCrearState();
}

class _PartidoCrearState extends State<PartidoCrear> {
  final TextEditingController paisController = TextEditingController();
  final TextEditingController ciudadController = TextEditingController();
  final TextEditingController sedeController = TextEditingController();
  final TextEditingController resultadoController = TextEditingController();
  DateTime _fechaSeleccionada = DateTime.now();
  String _equipoSeleccionado1 = '';
  String _equipoSeleccionado2 = '';
  List<String> _equipos =
      []; // Lista de equipos que participan en el campeonato

  void initState() {
    super.initState();
    _cargarEquipos();
  }

  Future<void> enviarDatosPartido() async {
    DateTime fechaSeleccionada = _fechaSeleccionada;
    int equipo1IdSeleccionado = _equipos.indexOf(_equipoSeleccionado1) +
        1; // +1 porque los IDs de los equipos comienzan desde 1
    int equipo2IdSeleccionado = _equipos.indexOf(_equipoSeleccionado2) +
        1; // +1 porque los IDs de los equipos comienzan desde 1

    // Llama a la función para enviar los datos del partido a la API
    HttpService().enviarDatosPartido(
      fecha: fechaSeleccionada,
      pais: paisController
          .text, // Reemplaza esto con el valor ingresado por el usuario en el campo correspondiente
      ciudad: ciudadController
          .text, // Reemplaza esto con el valor ingresado por el usuario en el campo correspondiente
      sede: sedeController
          .text, // Reemplaza esto con el valor ingresado por el usuario en el campo correspondiente
      resultado: resultadoController
          .text, // Reemplaza esto con el valor ingresado por el usuario en el campo correspondiente
      campeonatoId: widget
          .campeonatoId, // Reemplaza esto con el valor del campeonato seleccionado por el usuario
      equipo1Id: equipo1IdSeleccionado,
      equipo2Id: equipo2IdSeleccionado,
    );
  }

  Future<void> _cargarEquipos() async {
    try {
      List<dynamic> equipos =
          await HttpService().equiposEnCampeonato(widget.campeonatoId);
      setState(() {
        _equipos = equipos.map((equipo) => equipo['nombre'] as String).toList();
      });
    } catch (e) {
      print('Error al cargar equipos: $e');
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
              DropdownButtonFormField<String>(
                value: _equipoSeleccionado1,
                items: _equipos.map((String equipo) {
                  return DropdownMenuItem<String>(
                    value: equipo,
                    child: Text(equipo),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _equipoSeleccionado1 = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Equipo Local',
                ),
              ),
              DropdownButtonFormField<String>(
                value: _equipoSeleccionado2,
                items: _equipos.map((String equipo) {
                  return DropdownMenuItem<String>(
                    value: equipo,
                    child: Text(equipo),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _equipoSeleccionado2 = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Equipo Visitante',
                ),
              ),
              TextButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(
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
              ElevatedButton(
                onPressed: () {
                  // Enviar los datos del partido a la API
                  enviarDatosPartido();
                },
                child: Text('Crear Partido'),
              ),
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
              )
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
