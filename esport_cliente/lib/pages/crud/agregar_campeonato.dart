import 'package:flutter/material.dart';
import 'package:esport_cliente/services/http_service.dart';

class AgregarCampeonato extends StatefulWidget {
  final Function onUpdate; // Agregar onUpdate como parte de los parámetros

  const AgregarCampeonato({Key? key, required this.onUpdate}) : super(key: key);

  @override
  _AgregarCampeonatoState createState() => _AgregarCampeonatoState();
}

class _AgregarCampeonatoState extends State<AgregarCampeonato> {
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
    nombreController = TextEditingController();
    fechaInicioController = TextEditingController();
    fechaFinController = TextEditingController();
    reglasController = TextEditingController();
    premiosController = TextEditingController();
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
        title: Text('Agregar Campeonato')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Nombre
              TextFormField(
                controller: nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
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
              ),
              SizedBox(height: 8),
              Text(errFechaInicio, style: TextStyle(color: Colors.red)),
              SizedBox(height: 16.0),
              // Fecha de Término
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
              ),
              SizedBox(height: 8),
              Text(errPremios, style: TextStyle(color: Colors.red)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      var respuesta = await apiService.agregarCampeonato(
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
                          content: Text('Campeonato agregado'),
                        ));
                        widget.onUpdate();
                        Navigator.pop(context, true);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Error al agregar el campeonato: ${respuesta['message']}'),
                        ));
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Ocurrió un error: $e'),
                      ));
                    }
                  }
                },
                child: Text('Agregar Campeonato'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
