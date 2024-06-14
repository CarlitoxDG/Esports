import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

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
                await HttpService()
                    .postNuevoParticipante(widget.equipoId,
                        _nombreController.text, _paisController.text)
                    .then((response) {
                  if (response['mensaje'] != null) {
                    ScaffoldMessenger.of(_context).showSnackBar(
                      const SnackBar(content: Text('atao!')),
                    );
                    widget.onUpdate();
                  } else if (response.containsKey('id')) {
                    ScaffoldMessenger.of(_context).showSnackBar(
                      const SnackBar(content: Text('bien')),
                    );
                    widget.onUpdate();
                  } else {
                    ScaffoldMessenger.of(_context).showSnackBar(
                      SnackBar(
                          content: Text(
                              '${response.entries} ${response['mensaje']}')),
                    );
                    widget.onUpdate();
                  }
                }).catchError((e) {
                  print(e);
                  ScaffoldMessenger.of(_context).showSnackBar(const SnackBar(
                    content: Text('Error en los cambios'),
                  ));
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
