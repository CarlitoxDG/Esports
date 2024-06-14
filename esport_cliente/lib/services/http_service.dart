import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  final String apiUrl = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> campeonatos() async {
    return listarDatos('campeonatos');
  }

  Future<List<dynamic>> equipos() async {
    return listarDatos('equipos');
  }

  Future<List<dynamic>> participantes() async {
    return listarDatos('participantes');
  }

  Future<List<dynamic>> listarDatos(String coleccion) async {
    var respuesta = await http.get(Uri.parse('$apiUrl/$coleccion'));
    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    }
    //print(respuesta.statusCode);
    return [];
  }

  Future<List<dynamic>> listarParticipantes(int equipoId) async {
    final response =
        await http.get(Uri.parse('$apiUrl/equipos/$equipoId/participantes'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los integrantes');
    }
  }

  Future<List<dynamic>> listarJuegos() async {
    final response = await http.get(Uri.parse('$apiUrl/juegos'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los juegos');
    }
  }

  Future<List<dynamic>> listarJuegosPorEquipo(int equipoId) async {
    final response =
        await http.get(Uri.parse('$apiUrl/equipos/$equipoId/juegos'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los juegos');
    }
  }

  Future<List<dynamic>> equiposEnCampeonato(int campeonatoId) async {
    final response =
        await http.get(Uri.parse('$apiUrl/campeonatos/$campeonatoId/equipos'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los equipos del campeonato');
    }
  }

  Future<List<dynamic>> partidosPorCampeonato(int idCampeonato) async {
    final response =
        await http.get(Uri.parse('$apiUrl/campeonatos/$idCampeonato/partidos'));

    if (response.statusCode == 200) {
      List<dynamic> partidos = json.decode(response.body);

      // Itera sobre los partidos para obtener los nombres de los equipos
      for (var partido in partidos) {
        // Obtiene los nombres de los equipos correspondientes a partir de sus IDs
        var equipo1Id = partido['equipo1_id'];
        var equipo2Id = partido['equipo2_id'];

        // Realiza solicitudes adicionales para obtener los nombres de los equipos
        var equipo1 = await obtenerNombreEquipo(equipo1Id);
        var equipo2 = await obtenerNombreEquipo(equipo2Id);

        // Agrega los nombres de los equipos al objeto de partido
        partido['equipo1_nombre'] = equipo1['nombre'];
        partido['equipo2_nombre'] = equipo2['nombre'];
      }

      return partidos;
    } else {
      throw Exception('Error al cargar los partidos');
    }
  }

// Método para obtener el nombre de un equipo a partir de su ID
  Future<dynamic> obtenerNombreEquipo(int equipoId) async {
    final response = await http.get(Uri.parse('$apiUrl/equipos/$equipoId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener el nombre del equipo');
    }
  }

  Future<dynamic> actualizarParticipante(
      int id, Map<String, dynamic> datos) async {
    final response = await http.put(
      Uri.parse('$apiUrl/participantes/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(datos),
    );
    return response;
  }

  Future<dynamic> actualizarJuego(int id, Map<String, dynamic> datos) async {
    final response = await http.put(
      Uri.parse('$apiUrl/juegos/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(datos),
    );
    return response;
  }

  Future<dynamic> postNuevoParticipante(Map<String, dynamic> datos) async {
    final response = await http.post(
      Uri.parse('$apiUrl/participantes'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(datos),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // Si la solicitud se completó correctamente, devolver la respuesta como JSON
      return json.decode(response.body);
    } else {
      // Si la solicitud falló, lanzar una excepción con el mensaje de error
      throw Exception(
          'Error al agregar el participante: ${response.statusCode}');
    }
  }

  Future<LinkedHashMap<String, dynamic>> postNuevoJuego(
      Map<String, dynamic> juego) async {
    var respuesta = await http.post(
      Uri.parse(apiUrl + '/juegos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: json.encode(juego),
    );
    return json.decode(respuesta.body);
  }

  Future<void> eliminarParticipante(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/participantes/$id'));
    if (response.statusCode == 200) {
      print('Participante eliminado correctamente');
    } else {
      throw Exception('Error al eliminar el participante');
    }
  }

  Future<void> eliminarJuego(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/juegos/$id'));
    if (response.statusCode == 200) {
      print('juego eliminado correctamente');
    } else {
      throw Exception('Error al eliminar el juego');
    }
  }

  Future<void> enviarDatosPartido(
      {required DateTime fecha,
      required String pais,
      required String ciudad,
      required String sede,
      required String resultado,
      required int campeonato,
      required int equipo1,
      required int equipo2}) async {
    final url = Uri.parse('$apiUrl/partidos');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'fecha': fecha.toString().substring(0, 10), // Formatea la fecha
        'pais': pais,
        'ciudad': ciudad,
        'sede': sede,
        'resultado': resultado,
        'campeonato': campeonato,
        'equipo1': equipo1,
        'equipo2': equipo2,
      }),
    );

    if (response.statusCode == 201) {
      // Si la solicitud se completó correctamente, puedes manejar la respuesta aquí si es necesario
      print('Datos del partido enviados exitosamente');
    } else {
      // Si la solicitud falla, puedes manejar el error aquí
      throw Exception(
          'Error al enviar los datos del partido: ${response.reasonPhrase}');
    }
  }

  Future<bool> eliminarCampeonato(int campeonatoId) async {
    var respuesta = await http
        .delete(Uri.parse(apiUrl + '/campeonatos/' + campeonatoId.toString()));
    return respuesta.statusCode == 200;
  }

  Future<bool> eliminarEquipo(int equipoId) async {
    var respuesta = await http
        .delete(Uri.parse(apiUrl + '/equipos/' + equipoId.toString()));
    return respuesta.statusCode == 200;
  }

  Future<LinkedHashMap<String, dynamic>> agregarCampeonato(
    String nombre,
    String fecha_inicio,
    String fecha_fin,
    String reglas,
    String premios,
  ) async {
    var url = Uri.parse('$apiUrl/campeonatos');
    var respuesta = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: json.encode(<String, dynamic>{
        'nombre': nombre,
        'fecha_inicio': fecha_inicio,
        'fecha_fin': fecha_fin,
        'reglas': reglas,
        'premios': premios,
      }),
    );
    return json.decode(respuesta.body);
  }

  Future<LinkedHashMap<String, dynamic>> editarCampeonato(
    int campeonatoId,
    String nombre,
    String fecha_inicio,
    String fecha_fin,
    String reglas,
    String premios,
  ) async {
    var respuesta = await http.put(
      Uri.parse(apiUrl + '/campeonatos/' + campeonatoId.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: json.encode(<String, dynamic>{
        'id': campeonatoId,
        'nombre': nombre,
        'fecha_inicio': fecha_inicio,
        'fecha_fin': fecha_fin,
        'reglas': reglas,
        'premios': premios,
      }),
    );
    return json.decode(respuesta.body);
  }

  Future<LinkedHashMap<String, dynamic>> AgregarEquipo(
    String nombre,
  ) async {
    var url = Uri.parse('$apiUrl/equipos');
    var respuesta = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: json.encode(<String, dynamic>{
        'nombre': nombre,
      }),
    );
    return json.decode(respuesta.body);
  }

  Future<LinkedHashMap<String, dynamic>> AgregarPartido(
      String fecha,
      String pais,
      String ciudad,
      String sede,
      String resultado,
      int campeonato,
      int equipo1,
      int equipo2) async {
    var url = Uri.parse('$apiUrl/campeonatos');
    var respuesta = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: json.encode(<String, dynamic>{
        'fecha': fecha,
        'pais': pais,
        'ciudad': ciudad,
        'sede': sede,
        'resultado': resultado,
        'campeonato': campeonato,
        'equipo1_id': equipo1,
        'equipo2_id': equipo2,
      }),
    );
    return json.decode(respuesta.body);
  }
}
