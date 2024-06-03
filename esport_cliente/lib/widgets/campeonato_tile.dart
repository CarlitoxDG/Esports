import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CampeonatoTile extends StatelessWidget {
  final String nombre;
  final String
      fecha_inicio; //deberia ser DateTime pero hay q probar como interpreta el api despues de hacer un crud por aqui
  final String fecha_fin;
  //final String reglas;
  // final String premios;

  CampeonatoTile({
    this.nombre = 'Sin nombre',
    this.fecha_inicio = "00/00/0000",
    this.fecha_fin = "00/00/0000",
    //this.reglas = "qwerty",
    //this.premios = "qwertyu"
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 1),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xDDFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //numero
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
          ),
          //nombre
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '$nombre ',
                    style:
                        GoogleFonts.afacad(textStyle: TextStyle(fontSize: 16)),
                  )
                ],
              ),
              Text(
                this.fecha_inicio + " hasta " + this.fecha_fin,
                style: GoogleFonts.afacad(
                    textStyle: TextStyle(fontSize: 11, height: 0.8)),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
