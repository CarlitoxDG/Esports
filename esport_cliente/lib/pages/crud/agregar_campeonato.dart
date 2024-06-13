import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import '../../widgets/titulo_seccion.dart';

class AgregarCampeonato extends StatefulWidget {
  const AgregarCampeonato({Key? key}) : super(key: key);

  @override
  State<AgregarCampeonato> createState() => _AgregarCampeonatoState();
}

class _AgregarCampeonatoState extends State<AgregarCampeonato> {
  final HttpService apiService = HttpService();
  final formKey = GlobalKey<FormState>();

  TextEditingController nombreController = TextEditingController();
  TextEditingController fechaInicioController = TextEditingController();
  TextEditingController fechaFinController = TextEditingController();
  TextEditingController reglasController = TextEditingController();
  TextEditingController premiosController = TextEditingController();

  String errNombre = "";
  String errFechaInicio = "";
  String errFechaFin = "";
  String errReglas = "";
  String errPremios = "";

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
        title: Text('Agregar Nuevo Campeonato'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TituloSeccion(titulo: 'Campeonatos', subtitulo: 'Agregar'),
              SizedBox(height: 16),
              TextFormField(
                controller: nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  hintText: 'Ingrese el nombre del campeonato',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              Text(errNombre, style: TextStyle(color: Colors.red)),
              SizedBox(height: 16),
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
              SizedBox(height: 16),
              TextFormField(
                controller: fechaFinController,
                decoration: InputDecoration(
                  labelText: 'Fecha de Fin',
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
              SizedBox(height: 16),
              TextFormField(
                controller: premiosController,
                decoration: InputDecoration(
                  labelText: 'Premios',
                  hintText: 'Descripción de los premios del campeonato',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              Text(errPremios, style: TextStyle(color: Colors.red)),
              SizedBox(height: 16),
              TextFormField(
                controller: reglasController,
                decoration: InputDecoration(
                  labelText: 'Reglas',
                  hintText: 'Descripción de las reglas del campeonato',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              Text(errReglas, style: TextStyle(color: Colors.red)),
              SizedBox(height: 32),
              _buildAgregarButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAgregarButton() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () async {
            await _submitForm();
          },
          child: Text(
            'Agregar Campeonato',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    var respuesta = await HttpService().agregarCampeonato(
      nombreController.text,
      fechaInicioController.text,
      fechaFinController.text,
      reglasController.text,
      premiosController.text,
    );

    if (respuesta['message'] != null) {
      //hay errores de validación
      var errores = respuesta['errors'];
      setState(() {
        errNombre = errores['nombre'] != null ? errores['nombre'][0] : '';
        errFechaInicio =
            errores['fecha_inicio'] != null ? errores['fecha_inicio'][0] : '';
        errFechaFin =
            errores['fecha_fin'] != null ? errores['fecha_fin'][0] : '';
        errReglas = errores['reglas'] != null ? errores['reglas'][0] : '';
        errPremios = errores['premios'] != null ? errores['premios'][0] : '';
      });
      print(errNombre);
    } else {
      //todo ok, volver a la pagina que lista
      Navigator.pop(context);
    }
  }
}
