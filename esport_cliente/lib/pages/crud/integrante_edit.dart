import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';

class IntegranteEdit extends StatefulWidget {
  final int integranteId;
  final String nombre;
  final String pais;
  final Function onUpdate;
  const IntegranteEdit(
      {super.key,
      required this.integranteId,
      required this.nombre,
      required this.pais,
      required this.onUpdate});

  @override
  State<IntegranteEdit> createState() => _IntegranteEditState();
}

class _IntegranteEditState extends State<IntegranteEdit> {
  late TextEditingController _nombreController;
  late TextEditingController _paisController;
  late BuildContext _context;
  @override
  void initState() {
    super.initState();
    _context = context;
    _nombreController = TextEditingController(text: widget.nombre);
    _paisController = TextEditingController(text: widget.pais);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _paisController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Integrante'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nombreController,
              decoration:
                  const InputDecoration(labelText: 'Nombre del Participante'),
            ),
            TextFormField(
              controller: _paisController,
              decoration: const InputDecoration(labelText: 'País'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Acción para guardar los cambios
                final nuevosDatos = {
                  'nombre': _nombreController.text,
                  'pais': _paisController.text,
                };
                await HttpService()
                    .actualizarParticipante(widget.integranteId, nuevosDatos)
                    .then((response) {
                  if (response.statusCode == 200) {
                    ScaffoldMessenger.of(_context).showSnackBar(
                      const SnackBar(
                          content: Text('¡Cambios guardados con éxito!')),
                    );
                    // Llama a la función onUpdate para actualizar los integrantes
                    widget.onUpdate();
                  } else {
                    ScaffoldMessenger.of(_context).showSnackBar(
                      const SnackBar(
                          content: Text('Error al guardar los cambios')),
                    );
                  }
                }).catchError((error) {
                  ScaffoldMessenger.of(_context).showSnackBar(
                    const SnackBar(
                        content: Text('Error al guardar los cambios')),
                  );
                });
                Navigator.pop(context);
              },
              child: const Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}