import 'package:flutter/material.dart';
import 'package:notes_crud_local_app/providers/actual_option_provider.dart';
import 'package:provider/provider.dart';
import 'package:notes_crud_local_app/services/students_service.dart';
import 'package:notes_crud_local_app/providers/students_form_provider.dart';

class CreateStudentScreen extends StatelessWidget {
  const CreateStudentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StudentsService estudianteService = Provider.of(context);

    //provider para enforcarlo al formulario
    return ChangeNotifierProvider(
        create: (_) =>
            EstudiantesFormProvider(estudianteService.selectedStudent),
        child: _CreateForm(estudianteService: estudianteService));
  }
}

class _CreateForm extends StatelessWidget {
  final StudentsService estudianteService;

  const _CreateForm({required this.estudianteService});

  @override
  Widget build(BuildContext context) {
    final EstudiantesFormProvider estudianteFormProvider =
        Provider.of<EstudiantesFormProvider>(context);

    final estudiante = estudianteFormProvider.estudiante;

    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context, listen: false);
    return Form(
      key: estudianteFormProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            initialValue: estudiante.docIdentidad,
            decoration: const InputDecoration(
                hintText: 'Hola Profe',
                labelText: 'Documento de identidad',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8)),
            onChanged: (value) =>
                estudianteFormProvider.estudiante.docIdentidad = value,
            validator: (value) {
              return value != '' ? null : 'El campo no debe estar vacío';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            //maxLines: 10,
            autocorrect: false,
            initialValue: estudiante.nombre,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Hola Profe x2',
              labelText: 'Nombre Completo',
            ),
            onChanged: (value) => estudiante.nombre = value,
            validator: (value) {
              return (value != null) ? null : 'El campo no puede estar vacío';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            initialValue: estudiante.edad,
            decoration: const InputDecoration(
                hintText: 'Que tan viejo eres',
                labelText: 'Edad',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8)),
            onChanged: (value) => estudiante.edad = value,
            validator: (value) {
              return value != '' ? null : 'El campo no debe estar vacío';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            onPressed: estudianteService.isSaving
                ? null
                : () async {
                    //Quitar teclado al terminar
                    FocusScope.of(context).unfocus();

                    if (!estudianteFormProvider.isValidForm()) return;
                    await estudianteService
                        .createOrUpdate(estudianteFormProvider.estudiante);
                    actualOptionProvider.selectedOption = 0;
                  },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  estudianteService.isLoading ? 'Espere' : 'Ingresar',
                  style: const TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
