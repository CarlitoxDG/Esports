import 'package:flutter/material.dart';
import 'package:esport_cliente/services/http_service.dart';

class IntegranteAdd extends StatefulWidget {
  final int equipoId;
  final Function onUpdate;

  const IntegranteAdd({
    Key? key,
    required this.onUpdate,
    required this.equipoId,
  }) : super(key: key);

  @override
  State<IntegranteAdd> createState() => _IntegranteAddState();
}

class _IntegranteAddState extends State<IntegranteAdd> {
  final HttpService apiService = HttpService();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nombreController;
  late TextEditingController _paisController;

  String _errNombre = "";
  String _errPais = "";

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController();
    _paisController = TextEditingController();
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
        title: const Text('Crear Integrante'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del Participante',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              Text(_errNombre, style: TextStyle(color: Colors.red)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _paisController,
                decoration: const InputDecoration(
                  labelText: 'País',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              Text(_errPais, style: TextStyle(color: Colors.red)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _submitForm();
                  }
                },
                child: const Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    try {
      final response = await HttpService().postNuevoParticipante(
        widget.equipoId,
        _nombreController.text,
        _paisController.text,
      );

      if (response['message'] != null) {
        // Hay errores de validación
        var errores = response['errors'];
        setState(() {
          _errNombre = errores['nombre'] != null ? errores['nombre'][0] : '';
          _errPais = errores['pais'] != null ? errores['pais'][0] : '';
        });
      } else if (response.containsKey('id')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Actualización exitosa')),
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
        const SnackBar(content: Text('Error en los cambios')),
      );
    }
  }
}
