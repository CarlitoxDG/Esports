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
  late TextEditingController _nombreController;
  late TextEditingController _paisController;
  late GlobalKey<FormState> _formKey;
  String? _nombreError;
  String? _paisError;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre del participante';
                  }
                  if (value.length < 3) {
                    return 'El nombre debe tener al menos 3 caracteres';
                  }
                  return null;
                },
                onChanged: (_) {
                  setState(() {
                    _nombreError = null;
                  });
                },
              ),
              if (_nombreError != null)
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 4.0),
                  child: Text(
                    _nombreError!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _paisController,
                decoration: const InputDecoration(
                  labelText: 'País',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el país';
                  }
                  return null;
                },
                onChanged: (_) {
                  setState(() {
                    _paisError = null;
                  });
                },
              ),
              if (_paisError != null)
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 4.0),
                  child: Text(
                    _paisError!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
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

      if (response['mensaje'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡atao!')),
        );
        widget.onUpdate();
        Navigator.pop(context);
      } else if (response.containsKey('id')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡bien!')),
        );
        widget.onUpdate();
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${response.entries} ${response['mensaje']}'),
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

