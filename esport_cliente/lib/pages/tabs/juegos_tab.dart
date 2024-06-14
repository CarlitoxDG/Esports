import 'package:esport_cliente/pages/crud/juego_add.dart';
import 'package:esport_cliente/pages/crud/juego_edit.dart';
import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JuegosTab extends StatefulWidget {
  const JuegosTab({super.key});

  @override
  State<JuegosTab> createState() => _JuegosTabState();
}

class _JuegosTabState extends State<JuegosTab> {
  late Future<List<dynamic>> _futureJuegos;
  
  @override
  void initState() {
    super.initState();
    _futureJuegos = HttpService().listarJuegos();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _futureJuegos,
                builder: (BuildContext context,
                    AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.deepPurple,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List? juegos = snapshot.data;
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(0, 0, 0, 0).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Juegos',
                                style: GoogleFonts.inconsolata(
                                    fontSize: 24, color: Colors.white)),
                            const SizedBox(height: 10),
                            ...juegos
                                    ?.map((juego) => Column(
                                          children: [
                                            ListTile(
                                              title: Text(
                                                juego['nombre'] ?? 'Nombre del Juego',
                                                style: GoogleFonts.inconsolata(
                                                    fontSize: 20, color: Colors.white),
                                              ),
                                              subtitle: Text(
                                                juego['categoria'] ?? 'Categoría',
                                                style: GoogleFonts.inconsolata(
                                                    fontSize: 16, color: Colors.white70),
                                              ),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(Icons.edit, color: Colors.white),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => JuegoEdit(
                                                            nombre: juego['nombre'],
                                                            cat: juego['categoria'],
                                                            onUpdate: _actualizarJuegos,
                                                            juegoId: juego['id'],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(Icons.delete, color: Colors.white),
                                                    onPressed: () async {
                                                      try {
                                                        await HttpService().eliminarJuego(juego['id']);
                                                      } catch (e) {
                                                        // Manejar errores
                                                      }
                                                      _actualizarJuegos();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                          ],
                                        ))
                                    .toList() ??
                                [],
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red, // Color del botón
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JuegoAdd(
                                        onUpdate: _actualizarJuegos,
                                        equipoId: 0, // Cambiar según sea necesario
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Agregar Juego",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _actualizarJuegos() async {
    setState(() {
      _futureJuegos = HttpService().listarJuegos();
    });
  }
}
