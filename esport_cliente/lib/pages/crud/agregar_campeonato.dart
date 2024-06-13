import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import '../../widgets/titulo_seccion.dart';

class AgregarCampeonato extends StatefulWidget {
  const AgregarCampeonato({Key? key}) : super(key: key);

  @override
  State<AgregarCampeonato> createState() => _AgregarCampeonatoState();
}

class _AgregarCampeonatoState extends State<AgregarCampeonato> {
  TextEditingController nombreController = TextEditingController();
  DateTime fechaInicioController = DateTime.now();
  DateTime fechaFinController = DateTime.now();
  TextEditingController reglasController = TextEditingController();
  TextEditingController premiosController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String errNombre = "";
  String errFechaInicio = "";
  String errFechaFin = "";
  String errReglas = "";
  String errPremios = "";

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
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  hintText: 'Ingrese el nombre del campeonato',
                ),
                controller: nombreController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 8),
              Text(errNombre, style: TextStyle(color: Colors.red)),
              SizedBox(height: 16),
              _buildDateFields(),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Premios',
                  hintText: 'Descripción de los premios del campeonato',
                ),
                controller: premiosController,
              ),
              SizedBox(height: 8),
              Text(errPremios, style: TextStyle(color: Colors.red)),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Reglas',
                  hintText: 'Descripción de las reglas del campeonato',
                ),
                controller: reglasController,
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

  Widget _buildDateFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            _showDatePicker(true);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            minimumSize: Size(double.infinity, 48),
          ),
          child: Text("Elegir fecha de inicio"),
        ),
        SizedBox(height: 8),
        Text(errFechaInicio, style: TextStyle(color: Colors.red)),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            _showDatePicker(false);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            minimumSize: Size(double.infinity, 48),
          ),
          child: Text("Elegir fecha de fin"),
        ),
        SizedBox(height: 8),
        Text(errFechaFin, style: TextStyle(color: Colors.red)),
      ],
    );
  }

  void _showDatePicker(bool isStartDate) {
    DatePicker.showDatePicker(context, showTitleActions: true,
        onChanged: (date) {
      setState(() {
        if (isStartDate) {
          fechaInicioController = date;
        } else {
          fechaFinController = date;
        }
      });
    });
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
    if (formKey.currentState!.validate()) {
      var respuesta = await HttpService().AgregarCampeonato(
        nombreController.text,
        fechaInicioController.toString().substring(0, 10),
        fechaFinController.toString().substring(0, 10),
        reglasController.text,
        premiosController.text,
      );

      if (respuesta['message'] != null) {
        //hay errores de validación
        var errores = respuesta['errors'];
        setState(() {
          // errNombre = errores['nombre'][0] ?? '';
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
    ;
  }
}
