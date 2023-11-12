import 'package:flutter/material.dart';

import '../models/student_model.dart';

class EstudiantesFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Estudiantes estudiante;

  EstudiantesFormProvider(this.estudiante);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}