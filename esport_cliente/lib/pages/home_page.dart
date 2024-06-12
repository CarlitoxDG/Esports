import 'package:esport_cliente/pages/modo_editor.dart';
import 'package:esport_cliente/pages/tabs/campeonatos_tab.dart';
import 'package:esport_cliente/pages/tabs/equipos_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          // title: Text('Formula 1'),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/esportsapp_text.png',
                height: 40,
                fit: BoxFit.contain,
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ModoEditor()));
                },
                icon: const Icon(Icons.settings))
          ],
          bottom: const TabBar(
            labelColor: Color.fromARGB(255, 255, 255, 255),
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.videogame_asset), text: 'Campeonatos'),
              Tab(icon: Icon(Icons.people), text: 'Equipos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CampeonatosTab(),
            const EquiposTab(),
          ],
        ),
      ),
    );
  }
}
