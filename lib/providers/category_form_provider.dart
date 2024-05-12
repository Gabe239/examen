import 'package:flutter/material.dart';
import 'package:examen/models/categoria.dart';

class CategoriaFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Categoria categoria;

  CategoriaFormProvider(this.categoria);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void updateCategoria(Categoria newCategoria) {
    categoria = newCategoria;
    notifyListeners();
  }
}