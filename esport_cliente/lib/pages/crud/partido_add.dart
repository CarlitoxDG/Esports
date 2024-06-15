import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';
import '../../widgets/titulo_seccion.dart';

class PartidoAdd extends StatefulWidget {
  final Function onUpdate;
  final int campeonatoId; 

  const PartidoAdd(
      {Key? key, required this.campeonatoId, required this.onUpdate})
      : super(key: key);

  @override
  State<PartidoAdd> createState() => _PartidoAddState();
}

class _PartidoAddState extends State<PartidoAdd> {
  final HttpService apiService = HttpService();
  final formKey = GlobalKey<FormState>();

  TextEditingController fechaController = TextEditingController();
  TextEditingController paisController = TextEditingController();
  TextEditingController ciudadController = TextEditingController();
  TextEditingController sedeController = TextEditingController();
  TextEditingController resultadoController = TextEditingController();

  int? selectedEquipo1;
  int? selectedEquipo2;
  List<dynamic> equipos = [];

  String errFecha = "";
  String errPais = "";
  String errCiudad = "";
  String errSede = "";
  String errResultado = "";
  String errEquipo1 = "";
  String errEquipo2 = "";

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    var fetchedEquipos =
        await apiService.equiposEnCampeonato(widget.campeonatoId);
    setState(() {
      equipos = fetchedEquipos;
    });
  }

  void _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Nuevo Partido'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TituloSeccion(titulo: 'Partidos', subtitulo: 'Agregar'),
              SizedBox(height: 16),
              TextFormField(
                controller: fechaController,
                decoration: InputDecoration(
                  labelText: 'Fecha del partido',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, fechaController),
                  ),
                ),
                readOnly: true,
                onTap: () => _selectDate(context, fechaController),
              ),
              SizedBox(height: 8),
              Text(errFecha, style: TextStyle(color: Colors.red)),
              SizedBox(height: 16),

              TextFormField(
                controller: paisController,
                decoration: InputDecoration(
                  labelText: 'País',
                  hintText: 'Ingrese el país donde se jugará',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              Text(errPais, style: TextStyle(color: Colors.red)),
              SizedBox(height: 16),

              TextFormField(
                controller: ciudadController,
                decoration: InputDecoration(
                  labelText: 'Ciudad donde se jugará',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              Text(errCiudad, style: TextStyle(color: Colors.red)),
              SizedBox(height: 16),

              TextFormField(
                controller: sedeController,
                decoration: InputDecoration(
                  labelText: 'Sede',
                  hintText: 'Descripción de la sede del campeonato',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              Text(errSede, style: TextStyle(color: Colors.red)),
              SizedBox(height: 16),

              TextFormField(
                controller: resultadoController,
                decoration: InputDecoration(
                  labelText: 'Resultado',
                  hintText: 'Resultado del partido',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              Text(errResultado, style: TextStyle(color: Colors.red)),
              SizedBox(height: 16),

              DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  labelText: 'Equipo 1',
                  border: OutlineInputBorder(),
                ),
                value: selectedEquipo1,
                onChanged: (int? newValue) {
                  setState(() {
                    selectedEquipo1 = newValue;
                  });
                },
                items: equipos.map<DropdownMenuItem<int>>((dynamic value) {
                  return DropdownMenuItem<int>(
                    value: value['id'],
                    child: Text(value['nombre']),
                  );
                }).toList(),
              ),
              SizedBox(height: 8),
              Text(errEquipo1, style: TextStyle(color: Colors.red)),
              SizedBox(height: 16),

              DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  labelText: 'Equipo 2',
                  border: OutlineInputBorder(),
                ),
                value: selectedEquipo2,
                onChanged: (int? newValue) {
                  setState(() {
                    selectedEquipo2 = newValue;
                  });
                },
                items: equipos.map<DropdownMenuItem<int>>((dynamic value) {
                  return DropdownMenuItem<int>(
                    value: value['id'],
                    child: Text(value['nombre']),
                  );
                }).toList(),
              ),
              SizedBox(height: 8),
              Text(errEquipo2, style: TextStyle(color: Colors.red)),
              SizedBox(height: 16),

              SizedBox(height: 32),
              _buildAgregarButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAgregarButton() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () async {
            await _submitForm();
          },
          child: Text(
            'Agregar Partido',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (formKey.currentState!.validate()) {
      String resultado =
          resultadoController.text.isEmpty ? "" : resultadoController.text;

      var respuesta = await apiService.agregarPartido(
        fechaController.text,
        paisController.text,
        ciudadController.text,
        sedeController.text,
        resultado,
        widget.campeonatoId,
        selectedEquipo1!,
        selectedEquipo2!,
      );

      if (respuesta['message'] != null) {
        var errores = respuesta['errors'];
        setState(() {
          errFecha = errores['fecha'] != null ? errores['fecha'][0] : '';
          errPais = errores['pais'] != null ? errores['pais'][0] : '';
          errCiudad = errores['ciudad'] != null ? errores['ciudad'][0] : '';
          errSede = errores['sede'] != null ? errores['sede'][0] : '';
          errResultado =
              errores['resultado'] != null ? errores['resultado'][0] : '';
          errEquipo1 =
              errores['equipo1_id'] != null ? errores['equipo1_id'][0] : '';
          errEquipo2 =
              errores['equipo2_id'] != null ? errores['equipo2_id'][0] : '';
        });
        print('Errores de validación: $errores');
      } else {
        print('Partido agregado exitosamente');
        widget.onUpdate();
        Navigator.pop(context);
      }
    } else {
      print('Formulario no es válido');
    }
  }
}
