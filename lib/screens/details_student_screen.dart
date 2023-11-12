import 'package:flutter/material.dart';
import 'package:notes_crud_local_app/providers/actual_option_provider.dart';
import 'package:provider/provider.dart';

import 'package:notes_crud_local_app/services/students_service.dart';
import 'package:notes_crud_local_app/providers/students_form_provider.dart';

class DetailsStudentScreen extends StatelessWidget {
  const DetailsStudentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return _DetailsStudent();
    final StudentsService estudianteService = Provider.of(context);

    //provider para enforcarlo al formulario
    return ChangeNotifierProvider(
        create: (_) =>
            EstudiantesFormProvider(estudianteService.selectedStudent),
        child: _DetailsStudent(estudianteService: estudianteService));
  }
}

class _DetailsStudent extends StatelessWidget {
  final StudentsService estudianteService;

  const _DetailsStudent({required this.estudianteService});

  @override
  Widget build(BuildContext context) {
    final EstudiantesFormProvider estudiantesFormProvider =
        Provider.of<EstudiantesFormProvider>(context);

    final estudiante = estudiantesFormProvider.estudiante;
    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context, listen: false);
    return Form(
      key: estudiantesFormProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            initialValue: estudiante.docIdentidad,
            decoration: const InputDecoration(
                hintText: 'Hola Profe x3',
                labelText: 'Documento de identidad',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8)),
          ),
          const SizedBox(height: 30),
          TextFormField(
            //maxLines: 10,
            autocorrect: false,
            initialValue: estudiante.nombre,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Hola Profe x4',
              labelText: 'Nombre Completo',
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            initialValue: estudiante.edad,
            decoration: const InputDecoration(
                hintText: '¿Seras mas viejo que yo?',
                labelText: 'Edad',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8)),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
