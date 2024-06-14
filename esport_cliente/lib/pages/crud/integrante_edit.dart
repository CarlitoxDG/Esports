import 'package:flutter/material.dart';
import 'package:esport_cliente/services/http_service.dart';

class IntegranteEdit extends StatefulWidget {
  final int equipoId;
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
    required this.equipoId,
  }) : super(key: key);

  @override
  State<IntegranteEdit> createState() => _IntegranteEditState();
}

class _IntegranteEditState extends State<IntegranteEdit> {
  final HttpService apiService = HttpService();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nombreController;
  late TextEditingController _paisController;

  String _errNombre = "";
  String _errPais = "";

  @override
  void initState() {
    super.initState();
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              const SizedBox(height: 20),
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
      final response = await HttpService().actualizarParticipante(
        widget.integranteId,
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
        const SnackBar(content: Text('Error al guardar los cambios')),
      );
    }
  }
}
