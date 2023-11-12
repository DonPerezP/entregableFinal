import 'package:flutter/material.dart';
import 'package:notes_crud_local_app/providers/actual_option_provider.dart';
import 'package:provider/provider.dart';

import 'package:notes_crud_local_app/services/students_service.dart';

class ListStudentScreen extends StatelessWidget {
  const ListStudentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ListStudent();
  }
}

class _ListStudent extends StatelessWidget {
  void displayDialog(
      BuildContext context, StudentsService estudianteService, String id) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 5,
            title: const Text('Alerta!'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(10)),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    "¿Quiere eliminar el estudiante definitivamente del registro?"),
                SizedBox(height: 10),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar')),
              TextButton(
                  onPressed: () {
                    estudianteService.deleteStudentById(id); // aca se elimina un estudiante por ID
                    Navigator.pop(context);
                  },
                  child: const Text('Ok')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    StudentsService estudianteService = Provider.of<StudentsService>(context);

    final estudiantes = estudianteService.estudiantes;

    return Stack(
      children: [
        ListView.builder(
          itemCount: estudiantes.length,
          itemBuilder: (_, index) => ListTile(
            leading: const Icon(Icons.note),
            title: Text(estudiantes[index].nombre),
            subtitle: Text(estudiantes[index].id.toString()),
            trailing: PopupMenuButton(
              // icon: Icon(Icons.fire_extinguisher),
              onSelected: (int i) {
                if (i == 0) {
                  estudianteService.selectedStudent = estudiantes[index];
                  //studentProvider.createOrUpdate = "update";
                  //studentProvider.assignDataWithStudent(estudiantes[index]);
                  Provider.of<ActualOptionProvider>(context, listen: false)
                      .selectedOption = 1;
                  return;
                }

                if (i == 2) {
                  estudianteService.selectedStudent = estudiantes[index];
                  //studentProvider.assignDataWithStudent(estudiantes[index]);
                  Provider.of<ActualOptionProvider>(context, listen: false)
                      .selectedOption = 2;
                  return;
                }
                displayDialog(
                    context, estudianteService, estudiantes[index].id!);
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 0, child: Text('Actualizar')),
                const PopupMenuItem(value: 1, child: Text('Eliminar')),
                const PopupMenuItem(value: 2, child: Text('Detalles'))
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 16, // Ajusta la posición vertical
          right: 16, // Ajusta la posición horizontal
          child: FloatingActionButton(
            onPressed: () {
              estudianteService.loadStudents();
            },
            child: Icon(Icons.refresh, color: Colors.black,),
            backgroundColor: Colors.yellow,
          ),
        )
      ],
    );
  }
}
