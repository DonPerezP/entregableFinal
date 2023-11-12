import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/student_model.dart';

class StudentsService extends ChangeNotifier {
  //Asignamos la url base a un atributo para accceder a él facilmente.

  final String _baseUrl = "studentsapi-9b2f1-default-rtdb.firebaseio.com";

  late Estudiantes selectedStudent;

  List<Estudiantes> estudiantes = [];

  bool isLoading = false;
  bool isSaving = false;

  StudentsService() {
    loadStudents();
  }

  Future<List<Estudiantes>> loadStudents() async {
    isLoading = true;
    notifyListeners();

    estudiantes.clear();

    //Creamos la url a donde vamos a generar la solicitud
    final url = Uri.https(_baseUrl, 'students.json');
    final resp = await http.get(url);

    final Map<String, dynamic> estudiantesMap = json.decode(resp.body);
    print(estudiantesMap);

    estudiantesMap.forEach((key, value) {  

      Estudiantes tempEstudiante = Estudiantes.fromJson(value);
      tempEstudiante.id = key;
      estudiantes.add(tempEstudiante);
    });

    isLoading = false;
    notifyListeners();
    //print("hola ${this.estudiantes}");
    return estudiantes;
  }

  Future createOrUpdate(Estudiantes estudiante) async {
    isSaving = true;

    if (estudiante.id == null) {
      await createStudent(estudiante);
    } else {
      await updateStudent(estudiante);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> createStudent(Estudiantes estudiante) async {
    isSaving = true;
    final url = Uri.https(_baseUrl, 'students.json');
    final resp = await http.post(url, body: estudiante.toJson());

    final decodedData = json.decode(resp.body);

    estudiante.id = decodedData['name'];

    estudiantes.add(estudiante);

    return estudiante.id!;
  }

  Future<String> updateStudent(Estudiantes estudiante) async {
    try {
      final url = Uri.https(_baseUrl, 'students/${estudiante.id}.json');
      final resp = await http.patch(url, body: estudiante.toJson());

      if (resp.statusCode == 200) {
        final index =
            estudiantes.indexWhere((element) => element.id == estudiante.id);

        estudiantes[index] = estudiante;
        return estudiante.id!;
      } else {
        throw Exception('Fallo al actualizar el estudiante');
      }
    } catch (e) {
      print('Error actualizando estudiante: $e');
      throw Exception('Error updating Student');
    }
  }

  Future<String> deleteStudentById(String id) async {
    try {
      final url = Uri.https(_baseUrl, 'students/$id.json');
      final resp = await http.delete(url);

      if (resp.statusCode == 200) {
        loadStudents();
        return id;
      } else {
        throw Exception('Failed al eliminar estudiante');
      }      
    } catch (e) {
      print('Error eliminando estudiante: $e');
      throw Exception('Error deleting estudiante');
    }
  }
}
