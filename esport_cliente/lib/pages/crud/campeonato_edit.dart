import 'package:esport_cliente/pages/crud/partido_add.dart';
import 'package:flutter/material.dart';
import 'package:esport_cliente/services/http_service.dart';

class CampeonatoEdit extends StatefulWidget {
  final int campeonatoId;
  final String nombre;
  final String fechaInicio;
  final String fechaFin;
  final String reglas;
  final String premios;
  final Function onUpdate; 

  const CampeonatoEdit({
    Key? key,
    required this.campeonatoId,
    required this.nombre,
    required this.fechaInicio,
    required this.fechaFin,
    required this.reglas,
    required this.premios,
    required this.onUpdate, 
  }) : super(key: key);

  @override
  _CampeonatoEditState createState() => _CampeonatoEditState();
}

class _CampeonatoEditState extends State<CampeonatoEdit> {
  final HttpService apiService = HttpService();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nombreController;
  late TextEditingController fechaInicioController;
  late TextEditingController fechaFinController;
  late TextEditingController reglasController;
  late TextEditingController premiosController;

  String errNombre = "";
  String errFechaInicio = "";
  String errFechaFin = "";
  String errReglas = "";
  String errPremios = "";

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.nombre);
    fechaInicioController = TextEditingController(text: widget.fechaInicio);
    fechaFinController = TextEditingController(text: widget.fechaFin);
    reglasController = TextEditingController(text: widget.reglas);
    premiosController = TextEditingController(text: widget.premios);
  }

  void _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Campeonato'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              Text(errNombre, style: TextStyle(color: Colors.red)),
              SizedBox(height: 16.0),
              // Fecha de Inicio
              TextFormField(
                controller: fechaInicioController,
                decoration: InputDecoration(
                  labelText: 'Fecha de Inicio',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () =>
                        _selectDate(context, fechaInicioController),
                  ),
                ),
                readOnly: true,
                onTap: () => _selectDate(context, fechaInicioController),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione la fecha de inicio';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              Text(errFechaInicio, style: TextStyle(color: Colors.red)),
              SizedBox(height: 16.0),
              TextFormField(
                controller: fechaFinController,
                decoration: InputDecoration(
                  labelText: 'Fecha de Término',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, fechaFinController),
                  ),
                ),
                readOnly: true,
                onTap: () => _selectDate(context, fechaFinController),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione la fecha de término';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              Text(errFechaFin, style: TextStyle(color: Colors.red)),
              SizedBox(height: 16.0),
              // Reglas
              TextFormField(
                controller: reglasController,
                decoration: InputDecoration(
                  labelText: 'Reglas',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese las reglas';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              Text(errReglas, style: TextStyle(color: Colors.red)),
              SizedBox(height: 16.0),
              // Premios
              TextFormField(
                controller: premiosController,
                decoration: InputDecoration(
                  labelText: 'Premios',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese los premios';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              Text(errPremios, style: TextStyle(color: Colors.red)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      var respuesta = await apiService.editarCampeonato(
                        widget.campeonatoId,
                        nombreController.text,
                        fechaInicioController.text,
                        fechaFinController.text,
                        reglasController.text,
                        premiosController.text,
                      );

                      if (respuesta['message'] != null) {
                        // Hay errores de validación
                        var errores = respuesta['errors'];
                        setState(() {
                          errNombre = errores['nombre'] != null
                              ? errores['nombre'][0]
                              : '';
                          errFechaInicio = errores['fecha_inicio'] != null
                              ? errores['fecha_inicio'][0]
                              : '';
                          errFechaFin = errores['fecha_fin'] != null
                              ? errores['fecha_fin'][0]
                              : '';
                          errReglas = errores['reglas'] != null
                              ? errores['reglas'][0]
                              : '';
                          errPremios = errores['premios'] != null
                              ? errores['premios'][0]
                              : '';
                        });
                      } else if (respuesta.containsKey('id')) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Campeonato actualizado'),
                        ));
                        // Llamar a onUpdate después de actualizar el campeonato
                        widget.onUpdate();
                        Navigator.pop(context, true);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Error al actualizar el campeonato: ${respuesta['message']}'),
                        ));
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Ocurrió un error: $e'),
                      ));
                    }
                  }
                },
                child: Text('Actualizar Campeonato'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PartidoAdd(
                        campeonatoId: widget.campeonatoId,
                        onUpdate: () {
                          setState(() {
                          });
                        },
                      ),
                    ),
                  );
                },
                child: Text('Agregar Partido'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
