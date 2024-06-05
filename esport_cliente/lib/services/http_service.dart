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

  Future<List<dynamic>> listarJuegos(int equipoId) async {
    final response =
        await http.get(Uri.parse('$apiUrl/equipos/$equipoId/juegos'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los juegos');
    }
  }
}
