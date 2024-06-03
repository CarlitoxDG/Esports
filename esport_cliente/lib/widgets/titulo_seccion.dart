import 'package:esport_cliente/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TituloSeccion extends StatelessWidget {
  const TituloSeccion({
    super.key,
    required this.titulo,
    required this.subtitulo,
  });

  final String titulo;
  final String subtitulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(30, 10, 0, 5),
      decoration: const BoxDecoration(
        color: Color(kSecondaryColor),
        border:
            Border(bottom: BorderSide(color: Color(kPrimaryColor), width: 7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitulo,
            style: GoogleFonts.afacad(
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    color: Colors.white)),
          ),
          Text(
            titulo,
            style: GoogleFonts.afacad(
              textStyle: const TextStyle(
                  height: 0.8,
                  color: Colors.white,
                  fontSize: 28,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
