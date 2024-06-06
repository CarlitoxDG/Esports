import 'package:esport_cliente/pages/detalles_equipo_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EquipoTile extends StatelessWidget {
  final String nombre;
  final int equipoId;
  const EquipoTile({
    super.key,
    this.nombre = 'Sin nombre',
    required this.equipoId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 4, 5, 1),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xDDFFFFFF),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/images/Equipos/$nombre.png'),
            height: 40,
            width: 40,
          ),
/*           //numero
          Container(
            width: 35,
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(255, 73, 17, 178)),
              borderRadius: BorderRadius.all(Radius.circular(3)),
              color: Color(0xBB16171F),
            ),
          ), */
          //nombre
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '$nombre ',
                    style: GoogleFonts.afacad(
                        textStyle: const TextStyle(fontSize: 24)),
                  )
                ],
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.groups),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetallesEquipo(
                                nombre: nombre,
                                equipoId: equipoId,
                              )));
                },
              ),
              const Text(
                "Ver Equipo",
                style: TextStyle(fontSize: 12, height: 0.1),
              ),
            ],
          )
        ],
      ),
    );
  }
}
