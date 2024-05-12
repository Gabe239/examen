import 'package:flutter/material.dart';
import 'package:examen/services/auth_service.dart';
import 'package:examen/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:examen/providers/providers.dart';

class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color here
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 150),
            CardContainer(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Registra una cuenta',
                    style: TextStyle(
                      color: Colors.black, // Text color
                      fontSize: 24, // Adjust font size
                    ),
                  ),
                  const SizedBox(height: 30),
                  ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    child: RegisterForm(),
                  ),
                  const SizedBox(height: 50),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all(StadiumBorder()),
                    ),
                    child: const Text('¿Ya tienes una cuenta?, autentifícate', style: TextStyle(color: Colors.black)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginFormProvider = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: loginFormProvider.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.black), // Text color
              onChanged: (value) => loginFormProvider.email = value,
              validator: (value) {
                return (value != null && value.length >= 4) ? null : 'El usuario no puede estar vacío';
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.black), // Text color
              onChanged: (value) => loginFormProvider.password = value,
              validator: (value) {
                return (value != null && value.length >= 4) ? null : 'La contraseña no puede estar vacía';
              },
            ),
            const SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.black,
              color: Colors.blue,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                child: Text(
                  'Registrar',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              elevation: 0,
              onPressed: loginFormProvider.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final authService = Provider.of<AuthService>(context, listen: false);
                      if (!loginFormProvider.isValidForm()) return;
                      loginFormProvider.isLoading = true;
                      final String? errorMessage = await authService.create_user(loginFormProvider.email, loginFormProvider.password);
                      if (errorMessage == null) {
                        Navigator.pushNamed(context, 'login');
                      } else {
                        print(errorMessage);
                      }
                    },
            )
          ],
        ),
      ),
    );
  }
}
