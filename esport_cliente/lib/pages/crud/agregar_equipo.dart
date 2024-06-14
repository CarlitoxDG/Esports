import 'package:flutter/material.dart';
import 'package:esport_cliente/services/http_service.dart';
import '../../widgets/titulo_seccion.dart';

class AgregarEquipo extends StatefulWidget {
  const AgregarEquipo({Key? key}) : super(key: key);

  @override
  State<AgregarEquipo> createState() => _AgregarEquipoState();
}

class _AgregarEquipoState extends State<AgregarEquipo> {
  final HttpService apiService = HttpService();
  final formKey = GlobalKey<FormState>();

  TextEditingController nombreController = TextEditingController();

  String errNombre = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Nuevo Equipo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TituloSeccion(titulo: 'Equipos', subtitulo: 'Agregar'),
              SizedBox(height: 16),
              TextFormField(
                controller: nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  hintText: 'Ingrese el nombre del equipo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el nombre del equipo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              Text(errNombre, style: TextStyle(color: Colors.red)),
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
            'Agregar Equipo',
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
      var respuesta = await HttpService().AgregarEquipo(
        nombreController.text,
      );

      if (respuesta['message'] != null) {
        // hay errores de validación
        var errores = respuesta['errors'];
        setState(() {
          errNombre = errores['nombre'] != null ? errores['nombre'][0] : '';
        });
        print(errNombre);
      } else {
        
        Navigator.pop(context);
      }
    }
  }
}

