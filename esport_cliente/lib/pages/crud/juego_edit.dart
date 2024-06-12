import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';

class JuegoEdit extends StatefulWidget {
  final Function onUpdate;
  final int juegoId;
  final String nombre;
  final String cat;
  const JuegoEdit(
      {super.key,
      required this.nombre,
      required this.cat,
      required this.onUpdate,
      required this.juegoId});

  @override
  State<JuegoEdit> createState() => _JuegoEditState();
}

class _JuegoEditState extends State<JuegoEdit> {
  late TextEditingController _nombreController;
  late TextEditingController _catController;
  late BuildContext _context;
  @override
  void initState() {
    super.initState();
    _context = context;
    _nombreController = TextEditingController(text: widget.nombre);
    _catController = TextEditingController(text: widget.cat);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _catController.dispose();
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
              controller: _catController,
              decoration: const InputDecoration(labelText: 'País'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Acción para guardar los cambios
                final nuevosDatos = {
                  'nombre': _nombreController.text,
                  'categoria': _catController.text,
                };
                await HttpService()
                    .actualizarJuego(widget.juegoId, nuevosDatos)
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
