import 'package:esport_cliente/pages/detalles_campeonato_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CampeonatoTile extends StatelessWidget {
  final int id;
  final String nombre;
  final String fechaInicio; //deberia ser DateTime pero hay q probar como interpreta el api despues de hacer un crud por aqui
  final String fechaFin;
  final String reglas;
  final String premios;

  const CampeonatoTile(
      {super.key, this.id = 1,
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
                    style:
                        GoogleFonts.afacad(textStyle: const TextStyle(fontSize: 24)),
                  )
                ],
              ),
              Text(
                "$fechaInicio hasta $fechaFin",
                style: GoogleFonts.afacad(
                    textStyle: const TextStyle(fontSize: 14, height: 0.8)),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.view_headline),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalleCampeonato(
                        nombre: nombre,
                        reglas: reglas,
                        premios: premios,
                      ),
                    ),
                  );
                },
              ),
              const Text(
                "Ver Detalles",
                style: TextStyle(fontSize: 12, height: 0.1),
              ),
            ],
          )
        ],
      ),
    );
  }
}
