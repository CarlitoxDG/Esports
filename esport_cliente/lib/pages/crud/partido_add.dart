import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class PartidoAdd extends StatefulWidget {
  final int campeonatoId;

  const PartidoAdd({super.key, required this.campeonatoId});

  @override
  _PartidoCrearState createState() => _PartidoCrearState();
}

class _PartidoCrearState extends State<PartidoAdd> {
  final TextEditingController paisController = TextEditingController();
  final TextEditingController ciudadController = TextEditingController();
  final TextEditingController sedeController = TextEditingController();
  final TextEditingController resultadoController = TextEditingController();
  DateTime _fechaSeleccionada = DateTime.now();
  String? _equipoSeleccionado1;
  String? _equipoSeleccionado2;
  List<String> _equipos = [];

  @override
  void initState() {
    super.initState();
    _cargarEquipos();
  }

  Future<void> enviarDatosPartido() async {
    if (_equipoSeleccionado1 == null || _equipoSeleccionado2 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor selecciona ambos equipos')),
      );
      return;
    }

    int equipo1IdSeleccionado = _equipos.indexOf(_equipoSeleccionado1!) + 1;
    int equipo2IdSeleccionado = _equipos.indexOf(_equipoSeleccionado2!) + 1;

    final response = await HttpService().enviarDatosPartido(
      fecha: _fechaSeleccionada,
      pais: paisController.text,
      ciudad: ciudadController.text,
      sede: sedeController.text,
      resultado: resultadoController.text,
      campeonato: widget.campeonatoId,
      equipo1: equipo1IdSeleccionado,
      equipo2: equipo2IdSeleccionado,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('¡Partido creado con éxito!')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al crear el partido')),
      );
    }
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
            DropdownButton<String>(
              value: _equipoSeleccionado1,
              hint: Text('Selecciona el equipo 1'),
              onChanged: (String? newValue) {
                setState(() {
                  _equipoSeleccionado1 = newValue!;
                });
              },
              items: _equipos.map((String equipo) {
                return DropdownMenuItem<String>(
                  value: equipo,
                  child: Text(equipo),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: _equipoSeleccionado2,
              hint: Text('Selecciona el equipo 2'),
              onChanged: (String? newValue) {
                setState(() {
                  _equipoSeleccionado2 = newValue!;
                });
              },
              items: _equipos.map((String equipo) {
                return DropdownMenuItem<String>(
                  value: equipo,
                  child: Text(equipo),
                );
              }).toList(),
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
                'Seleccionar Fecha: ${_fechaSeleccionada.toLocal()}',
              ),
            ),
            TextFormField(
              controller: paisController,
              decoration: InputDecoration(labelText: 'País'),
            ),
            TextFormField(
              controller: ciudadController,
              decoration: InputDecoration(labelText: 'Ciudad'),
            ),
            TextFormField(
              controller: sedeController,
              decoration: InputDecoration(labelText: 'Sede'),
            ),
            TextFormField(
              controller: resultadoController,
              decoration: InputDecoration(labelText: 'Resultado'),
            ),
            ElevatedButton(
              onPressed: enviarDatosPartido,
              child: Text('Crear Partido'),
            ),
          ],
        ),
      ),
    );
  }
}
