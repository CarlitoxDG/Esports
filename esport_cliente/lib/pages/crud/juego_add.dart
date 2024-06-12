import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';

class JuegoAdd extends StatefulWidget {
  final int equipoId;
  final Function onUpdate;
  const JuegoAdd({super.key, required this.onUpdate, required this.equipoId});

  @override
  State<JuegoAdd> createState() => _JuegoAddState();
}

class _JuegoAddState extends State<JuegoAdd> {
  late TextEditingController _nombreController;
  late TextEditingController _catController;
  late BuildContext _context;
  @override
  void initState() {
    super.initState();
    _context = context;
    _nombreController = TextEditingController();
    _catController = TextEditingController();
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
              controller: _catController,
              decoration: const InputDecoration(labelText: 'País'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Acción para guardar los cambios
                final nuevosDatosJuego = {
                  'nombre': _nombreController.text,
                  'categoria': _catController.text,
                };
                final datosEquipo = {
                  'equipo_id': widget.equipoId
                }; //falta el id del juego, q resulta ser el id de el juego que se está creando. asi q no cacho
                await HttpService()
                    .postNuevoJuego(nuevosDatosJuego, datosEquipo)
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
