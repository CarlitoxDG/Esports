import 'package:esport_cliente/pages/tabs/campeonatos_edit_tab.dart';
import 'package:esport_cliente/pages/tabs/equipos_edit_tab.dart';
import 'package:esport_cliente/services/http_service.dart';
import 'package:esport_cliente/widgets/equipo_edit_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModoEditor extends StatefulWidget {
  const ModoEditor({super.key});

  @override
  State<ModoEditor> createState() => _ModoEditorState();
}

class _ModoEditorState extends State<ModoEditor> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Column(
            children: [
              Container(
                color: Colors.red,
                height: 40,
                child: Image.asset(
                  'assets/images/esportsapp_text.png',
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                color: Colors.red,
                height: 30,
                child: Text(
                  "Modo Editor",
                  style: GoogleFonts.inconsolata(
                    textStyle: const TextStyle(fontSize: 22),
                  ),
                ),
              ),
            ],
          ),
          bottom: TabBar(
            labelColor: const Color.fromARGB(255, 255, 255, 255),
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                icon: const Icon(Icons.videogame_asset),
                child: Text("Campeonatos", style: GoogleFonts.inconsolata()),
              ),
              Tab(
                icon: const Icon(Icons.people),
                child: Text('Equipos', style: GoogleFonts.inconsolata()),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCampeonatosTab(),
            _buildEquiposTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildCampeonatosTab() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/fondoequipo1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        CampeonatosEditTab(),
      ],
    );
  }

  Widget _buildEquiposTab() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/fondoequipo1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        FutureBuilder(
          future: HttpService().equipos(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                var equipo = snapshot.data[index];
                return EquipoTileEdit(
                  nombre: equipo['nombre'],
                  equipoId: equipo['id'],
                );
              },
            );
          },
        ),
        EquiposEditTab(),
      ],
    );
  }
}
