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
  final HttpService apiService = HttpService();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nombreController;
  late TextEditingController _catController;

  String _errNombre = "";
  String _errCategoria = "";

  @override
  void initState() {
    super.initState();
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del Juego',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              Text(_errNombre, style: TextStyle(color: Colors.red)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _catController,
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              Text(_errCategoria, style: TextStyle(color: Colors.red)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _submitForm();
                  }
                },
                child: const Text('Guardar Juego'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    try {
      final response = await HttpService().postNuevoJuego(
        _nombreController.text,
        _catController.text,
      );

      if (response['message'] != null) {
        // Hay errores de validación
        var errores = response['errors'];
        setState(() {
          _errNombre = errores['nombre'] != null ? errores['nombre'][0] : '';
          _errCategoria =
              errores['categoria'] != null ? errores['categoria'][0] : '';
        });
      } else if (response.containsKey('id')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Operación exitosa')),
        );
        widget.onUpdate();
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${response.entries} ${response['message']}'),
          ),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al guardar el juego')),
      );
    }
  }
}
