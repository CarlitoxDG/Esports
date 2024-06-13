import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';

class IntegranteEdit extends StatefulWidget {
  final int integranteId;
  final String nombre;
  final String pais;
  final Function onUpdate;

  const IntegranteEdit({
    Key? key,
    required this.integranteId,
    required this.nombre,
    required this.pais,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _IntegranteEditState createState() => _IntegranteEditState();
}

class _IntegranteEditState extends State<IntegranteEdit> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nombreController;
  late TextEditingController paisController;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.nombre);
    paisController = TextEditingController(text: widget.pais);
  }

  @override
  void dispose() {
    nombreController.dispose();
    paisController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Integrante'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nombre del Participante
                TextFormField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del Participante',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre del participante';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                // País
                TextFormField(
                  controller: paisController,
                  decoration: const InputDecoration(
                    labelText: 'País',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el país';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final nuevosDatos = {
                        'nombre': nombreController.text,
                        'pais': paisController.text,
                      };
                      await HttpService()
                          .actualizarParticipante(
                              widget.integranteId, nuevosDatos)
                          .then((response) {
                        if (response.statusCode == 200) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('¡Cambios guardados con éxito!'),
                            ),
                          );
                          // Llama a la función onUpdate para actualizar los integrantes
                          widget.onUpdate();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Error al guardar los cambios'),
                            ),
                          );
                        }
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Error al guardar los cambios'),
                          ),
                        );
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Guardar Cambios'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
