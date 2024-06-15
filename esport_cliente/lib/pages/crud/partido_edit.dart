import 'package:flutter/material.dart';
import 'package:esport_cliente/services/http_service.dart';

class PartidoEdit extends StatefulWidget {
  final int partidoId;
  final String fecha;
  final String pais;
  final String ciudad;
  final String sede;
  final String resultado;
  final int campeonatoId;
  final int equipo1Id;
  final int equipo2Id;
  final Function onUpdate; // Agregar onUpdate como parte de los parámetros

  const PartidoEdit({
    Key? key,
    required this.partidoId,
    required this.fecha,
    required this.pais,
    required this.ciudad,
    required this.sede,
    required this.resultado,
    required this.campeonatoId,
    required this.equipo1Id,
    required this.equipo2Id,
    required this.onUpdate, // Marcar como requerido
  }) : super(key: key);

  @override
  _PartidoEditState createState() => _PartidoEditState();
}

class _PartidoEditState extends State<PartidoEdit> {
  final HttpService apiService = HttpService();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController fechaController;
  late TextEditingController paisController;
  late TextEditingController ciudadController;
  late TextEditingController sedeController;
  late TextEditingController resultadoController;

  String errFecha = "";
  String errPais = "";
  String errCiudad = "";
  String errSede = "";
  String errResultado = "";

  @override
  void initState() {
    super.initState();
    fechaController = TextEditingController(text: widget.fecha);
    paisController = TextEditingController(text: widget.pais);
    ciudadController = TextEditingController(text: widget.ciudad);
    sedeController = TextEditingController(text: widget.sede);
    resultadoController = TextEditingController(text: widget.resultado);
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
        title: Text('Editar Partido'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Fecha
              TextFormField(
                controller: fechaController,
                decoration: InputDecoration(
                  labelText: 'Fecha',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, fechaController),
                  ),
                ),
                readOnly: true,
                onTap: () => _selectDate(context, fechaController),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione la fecha';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              Text(errFecha, style: TextStyle(color: Colors.red)),
              SizedBox(height: 16.0),
              // País
              TextFormField(
                controller: paisController,
                decoration: InputDecoration(
                  labelText: 'País',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              Text(errPais, style: TextStyle(color: Colors.red)),
              SizedBox(height: 16.0),
              // Ciudad
              TextFormField(
                controller: ciudadController,
                decoration: InputDecoration(
                  labelText: 'Ciudad',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              Text(errCiudad, style: TextStyle(color: Colors.red)),
              SizedBox(height: 16.0),
              // Sede
              TextFormField(
                controller: sedeController,
                decoration: InputDecoration(
                  labelText: 'Sede',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              Text(errSede, style: TextStyle(color: Colors.red)),
              SizedBox(height: 16.0),
              // Resultado
              TextFormField(
                controller: resultadoController,
                decoration: InputDecoration(
                  labelText: 'Resultado',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el resultado';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              Text(errResultado, style: TextStyle(color: Colors.red)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      var respuesta = await apiService.editarPartido(
                        widget.partidoId,
                        fechaController.text,
                        paisController.text,
                        ciudadController.text,
                        sedeController.text,
                        resultadoController.text,
                        widget.campeonatoId,
                        widget.equipo1Id,
                        widget.equipo2Id,
                      );

                      if (respuesta['message'] != null) {
                        var errores = respuesta['errors'];
                        setState(() {
                          errFecha = errores['fecha'] != null
                              ? errores['fecha'][0]
                              : '';
                          errPais =
                              errores['pais'] != null ? errores['pais'][0] : '';
                          errCiudad = errores['ciudad'] != null
                              ? errores['ciudad'][0]
                              : '';
                          errSede =
                              errores['sede'] != null ? errores['sede'][0] : '';
                          errResultado = errores['resultado'] != null
                              ? errores['resultado'][0]
                              : '';
                        });
                      } else if (respuesta.containsKey('id')) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Partido actualizado'),
                        ));
                        widget.onUpdate();
                        Navigator.pop(context, true);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Error al actualizar el partido: ${respuesta['message']}'),
                        ));
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Ocurrió un error: $e'),
                      ));
                    }
                  }
                },
                child: Text('Actualizar Partido'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
