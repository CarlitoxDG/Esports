import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';

class JuegoAdd extends StatefulWidget {
  final int equipoId;
  final Function onUpdate;

  const JuegoAdd({Key? key, required this.onUpdate, required this.equipoId});

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
    _nombreController.dispose();
    _catController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Juego'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre del Juego'),
            ),
            TextFormField(
              controller: _catController,
              decoration: const InputDecoration(labelText: 'Categoría'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red, // Letras blancas
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(double.infinity, 48),
              ),
              onPressed: () async {
                final nuevosDatosJuego = {
                  'nombre': _nombreController.text,
                  'categoria': _catController.text,
                  'equipo_id': widget.equipoId,
                };

                await HttpService()
                    .postNuevoJuego(nuevosDatosJuego)
                    .then((response) {
                  if (response['status'] == 201 || response['status'] == 200) {
                    ScaffoldMessenger.of(_context).showSnackBar(
                      const SnackBar(
                          content: Text('¡Juego guardado con éxito!')),
                    );
                    widget.onUpdate();
                  } else {
                    ScaffoldMessenger.of(_context).showSnackBar(
                      const SnackBar(
                          content: Text('¡Juego guardado con éxito!')),
                    );
                  }
                }).catchError((error) {
                  ScaffoldMessenger.of(_context).showSnackBar(
                    const SnackBar(content: Text('Error al guardar el juego')),
                  );
                });
                widget.onUpdate();
                Navigator.pop(context);
              },
              child: const Text('Guardar Juego'),
            ),
          ],
        ),
      ),
    );
  }
}
