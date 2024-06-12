import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';

import '../../widgets/titulo_seccion.dart';

class AgregarCampeonato extends StatefulWidget {
  const AgregarCampeonato({Key? key}) : super(key: key);

  @override
  State<AgregarCampeonato> createState() => _AgregarCampeonatoState();
}

class _AgregarCampeonatoState extends State<AgregarCampeonato> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController fechaInicioController = TextEditingController();
  TextEditingController fechaFinController = TextEditingController();
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
        padding: EdgeInsets.all(8),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              //TITULO
              TituloSeccion(titulo: 'Campeonatos', subtitulo: 'Agregar'),

              //nombre
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                controller: nombreController,
                keyboardType: TextInputType.text,
              ),
              Text(errNombre, style: TextStyle(color: Colors.red)),

              //fecha Inicio
              TextFormField(
                decoration: InputDecoration(labelText: 'Fecha Inicio'),
                controller: fechaInicioController,
                keyboardType: TextInputType.datetime,
              ),
              Text(errFechaFin, style: TextStyle(color: Colors.red)),

              //fecha Fin
              TextFormField(
                decoration: InputDecoration(labelText: 'Fecha Termino'),
                controller: fechaFinController,
                keyboardType: TextInputType.datetime,
              ),
              Text(errFechaFin, style: TextStyle(color: Colors.red)),

              //premios
              TextFormField(
                decoration: InputDecoration(labelText: 'Premios'),
                controller: premiosController,
              ),
              Text(errNombre, style: TextStyle(color: Colors.red)),

              //reglas
              TextFormField(
                decoration: InputDecoration(labelText: 'Reglas'),
                controller: reglasController,
              ),
              Text(errNombre, style: TextStyle(color: Colors.red)),

              //boton
              Container(
                margin: EdgeInsets.only(top: 20),
                child: FilledButton(
                  style: FilledButton.styleFrom(),
                  child: Text('Agregar Campeonato'),
                  onPressed: () async {
                    var respuesta = await HttpService().AgregarCampeonato(
                      nombreController.text,
                      fechaInicioController.text,
                      fechaInicioController.text,
                      reglasController.text,
                      premiosController.text,
                    );

                    if (respuesta.containsKey('message')) {
                      //hay errores de validación
                      var errores = respuesta['errors'] ?? {};
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
