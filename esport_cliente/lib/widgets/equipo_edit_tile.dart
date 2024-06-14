//import 'package:esport_cliente/pages/crud/equipo_edit.dart';
import 'package:esport_cliente/pages/crud/equipo_edit.dart';
import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EquipoTileEdit extends StatefulWidget {
  final String nombre;
  final int equipoId;
  final Function onUpdate;
  const EquipoTileEdit({
    super.key,
    this.nombre = 'Sin nombre',
    required this.equipoId,
    required this.onUpdate,
  });

  @override
  State<EquipoTileEdit> createState() => _EquipoTileEditState();
}

class _EquipoTileEditState extends State<EquipoTileEdit> {
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
            image: AssetImage('assets/images/Equipos/${widget.nombre}.png'),
            height: 40,
            width: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${widget.nombre} ',
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
                            equipoId: widget.equipoId,
                            nombre: widget.nombre,
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
                      onPressed: () async {
                        try {
                          await HttpService()
                              .eliminarEquipo(this.widget.equipoId);
                        } catch (e) {
                          //erro
                        }
                        widget.onUpdate();
                      },
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
