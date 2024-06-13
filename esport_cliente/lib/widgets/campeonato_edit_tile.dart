import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CampeonatoTileEdit extends StatefulWidget {
  final int campeonatoId;
  final String nombre;
  final String fechaInicio;
  final String fechaFin;
  final String reglas;
  final String premios;

<<<<<<< HEAD
  const CampeonatoTileEdit(
      {super.key,
      this.campeonatoId = 1,
      this.nombre = 'Sin nombre',
      this.fechaInicio = "00/00/0000",
      this.fechaFin = "00/00/0000",
      this.reglas = "qwerty",
      this.premios = "qwertyu"});
=======
  const CampeonatoTileEdit({
    super.key,
    this.id = 1,
    this.nombre = 'Sin nombre',
    this.fechaInicio = "00/00/0000",
    this.fechaFin = "00/00/0000",
    this.reglas = "qwerty",
    this.premios = "qwertyu",
  });
>>>>>>> 51a875ec66910d375e5c506e5710f80f6303c3f9

  @override
  State<CampeonatoTileEdit> createState() => _CampeonatoTileEditState();
}

class _CampeonatoTileEditState extends State<CampeonatoTileEdit> {
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.nombre}',
                  style: GoogleFonts.inconsolata(
                    textStyle: const TextStyle(fontSize: 24),
                  ),
                ),
                Text(
                  "${widget.fechaInicio} hasta ${widget.fechaFin}",
                  style: GoogleFonts.inconsolata(
                    textStyle: const TextStyle(fontSize: 14, height: 0.8),
                  ),
                ),
              ],
            ),
          ),
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
                          builder: (context) => CampeonatoTileEdit(
                            campeonatoId: widget.campeonatoId,
                            nombre: widget.nombre,
                            fechaInicio: widget.fechaInicio,
                            fechaFin: widget.fechaFin,
                            reglas: widget.reglas,
                            premios: widget.premios,
                          ),
                        ),
                      );
                    },
                  ),
                  Text(
                    "Editar",
                    style: GoogleFonts.inconsolata(
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
<<<<<<< HEAD
                      onPressed: () async {
                        print('BORRAR: ${this.widget.campeonatoId}');
                        await HttpService()
                            .eliminarCampeonato(this.widget.campeonatoId)
                            .then((borradoOK) {
                          if (borradoOK) {
                            print('campeonato borrado');
                            setState(() {});
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      )),
=======
                    onPressed: () async {
                      print('BORRAR: ${widget.id}');
                      await HttpService()
                          .eliminarCampeonato(widget.id)
                          .then((borradoOK) {
                        if (borradoOK) {
                          print('campeonato borrado');
                          setState(() {});
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                  ),
>>>>>>> 51a875ec66910d375e5c506e5710f80f6303c3f9
                  Text(
                    "Eliminar",
                    style: GoogleFonts.inconsolata(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

