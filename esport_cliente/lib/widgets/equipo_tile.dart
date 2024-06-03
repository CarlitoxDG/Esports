import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EquipoTile extends StatelessWidget {
  final String nombre;

  EquipoTile({
    this.nombre = 'Sin nombre',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 4, 5, 1),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xDDFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/images/Equipos/' + '$nombre' + '.png'),
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
                    style:
                        GoogleFonts.afacad(textStyle: TextStyle(fontSize: 24)),
                  )
                ],
              ),
            ],
          ),
          Spacer(),
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.groups),
                onPressed: () {
                  // Aquí debes poner la navegación a la siguiente pantalla
                },
              ),
              Text(
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
