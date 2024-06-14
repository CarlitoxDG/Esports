import 'package:flutter/material.dart';
import 'package:esport_cliente/pages/crud/campeonato_edit.dart';
import 'package:esport_cliente/services/http_service.dart';
import 'package:google_fonts/google_fonts.dart';

class CampeonatoTileEdit extends StatefulWidget {
  final int id;
  final String nombre;
  final String fechaInicio;
  final String fechaFin;
  final String reglas;
  final String premios;
  final Function onUpdate; 

  const CampeonatoTileEdit({
    Key? key,
    required this.id,
    required this.nombre,
    required this.fechaInicio,
    required this.fechaFin,
    required this.reglas,
    required this.premios,
    required this.onUpdate, 
  }) : super(key: key);

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
                          builder: (context) => CampeonatoEdit(
                            campeonatoId: widget.id,
                            nombre: widget.nombre,
                            fechaInicio: widget.fechaInicio,
                            fechaFin: widget.fechaFin,
                            reglas: widget.reglas,
                            premios: widget.premios,
                            onUpdate: widget.onUpdate, 
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
                    onPressed: () async {
                      print('BORRAR: ${widget.id}');
                      await HttpService()
                          .eliminarCampeonato(widget.id)
                          .then((borradoOK) {
                        if (borradoOK) {
                          print('campeonato borrado');
                          widget.onUpdate();
                          setState(() {});
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                  ),
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


