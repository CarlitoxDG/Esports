import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';

class IntegranteAdd extends StatefulWidget {
  final int equipoId;
  final Function onUpdate;
  const IntegranteAdd(
      {super.key, required this.onUpdate, required this.equipoId});

  @override
  State<IntegranteAdd> createState() => _IntegranteAddState();
}

class _IntegranteAddState extends State<IntegranteAdd> {
  late TextEditingController _nombreController;
  late TextEditingController _paisController;
  late BuildContext _context;
  @override
  void initState() {
    super.initState();
    _context = context;
    _nombreController = TextEditingController();
    _paisController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Integrante'),
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
                  'equipo_id': widget.equipoId
                };
                await HttpService()
                    .postNuevoParticipante(nuevosDatos)
                    .then((response) {
                  if (response.statusCode == 201 ||
                      response.statusCode == 200) {
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
                    widget.onUpdate();
                  }
                }).catchError((error) {
                  ScaffoldMessenger.of(_context).showSnackBar(
                    const SnackBar(
                        content: Text('Error al guardar los cambioss')),
                  );
                  widget.onUpdate();
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
