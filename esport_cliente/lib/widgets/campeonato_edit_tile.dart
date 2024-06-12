import 'package:esport_cliente/pages/crud/campeonato_edit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CampeonatoTileEdit extends StatelessWidget {
  final int id;
  final String nombre;
  final String
      fechaInicio; //deberia ser DateTime pero hay q probar como interpreta el api despues de hacer un crud por aqui
  final String fechaFin;
  final String reglas;
  final String premios;

  const CampeonatoTileEdit(
      {super.key,
      this.id = 1,
      this.nombre = 'Sin nombre',
      this.fechaInicio = "00/00/0000",
      this.fechaFin = "00/00/0000",
      this.reglas = "qwerty",
      this.premios = "qwertyu"});

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
              Text(
                "$fechaInicio hasta $fechaFin",
                style: GoogleFonts.inconsolata(
                    textStyle: const TextStyle(fontSize: 14, height: 0.8)),
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
                          builder: (context) => const CampeonatoEdit(),
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
