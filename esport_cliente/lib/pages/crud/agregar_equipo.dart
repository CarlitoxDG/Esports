import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';

import '../../widgets/titulo_seccion.dart';

class AgregarEquipo extends StatefulWidget {
  const AgregarEquipo({super.key});

  @override
  State<AgregarEquipo> createState() => _agregarEquipoState();
}

class _agregarEquipoState extends State<AgregarEquipo> {
  TextEditingController nombreController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String errNombre = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Nuevo Equipo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              //TITULO
              TituloSeccion(titulo: 'Equipos', subtitulo: 'Agregar'),

              //nombre
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                controller: nombreController,
                keyboardType: TextInputType.text,
              ),
              Text(errNombre, style: TextStyle(color: Colors.red)),

              //boton
              Container(
                margin: EdgeInsets.only(top: 20),
                child: FilledButton(
                  style: FilledButton.styleFrom(),
                  child: Text('Agregar Equipo'),
                  onPressed: () async {
                    var respuesta = await HttpService().AgregarEquipo(
                      nombreController.text,
                    );

                    if (respuesta['message'] != null) {
                      //hay errores de validación
                      var errores = respuesta['errors'];
                      setState(() {
                        // errNombre = errores['nombre'][0] ?? '';
                        errNombre = errores['nombre'] != null
                            ? errores['nombre'][0]
                            : '';
                      });
                      print(errNombre);
                    } else {
                      //todo ok, volver a la pagina que lista
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
