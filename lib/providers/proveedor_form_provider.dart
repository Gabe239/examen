import 'package:flutter/material.dart';
import 'package:examen/models/proveedor.dart';

class ProviderFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Proveedor provider;

  ProviderFormProvider(this.provider);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
