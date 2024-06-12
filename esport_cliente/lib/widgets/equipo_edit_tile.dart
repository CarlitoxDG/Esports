import 'package:esport_cliente/pages/crud/equipo_edit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EquipoTileEdit extends StatelessWidget {
  final String nombre;
  final int equipoId;
  const EquipoTileEdit({
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '$nombre ',
                    style: GoogleFonts.inconsolata(
                        textStyle: const TextStyle(fontSize: 24)),
                  )
                ],
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EquipoEdit(
                            equipoId: equipoId,
                            nombre: nombre,
                          ),
                        ),
                      );
                    },
                  ),
                  Text(
                    "Editar",
                    style: GoogleFonts.inconsolata(
                        textStyle: const TextStyle(
                      fontSize: 12,
                    )),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      )),
                  Text(
                    "Eliminar",
                    style: GoogleFonts.inconsolata(
                        textStyle:
                            const TextStyle(fontSize: 12, color: Colors.red)),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
