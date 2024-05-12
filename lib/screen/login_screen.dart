import 'package:flutter/material.dart';
import 'package:examen/services/auth_service.dart';
import 'package:examen/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:examen/providers/providers.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                    'Login',
                    style: TextStyle(
                      color: Colors.black, // Text color in dark mode
                      fontSize: 24, // Adjust font size
                    ),
                  ),
                  const SizedBox(height: 30),
                  ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    child: LoginForm(),
                  ),
                  const SizedBox(height: 50),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, 'add_user'),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all(StadiumBorder()),
                    ),
                    child: Text(
                      'No tienes una cuenta aún?, presiona acá para crearla',
                      style: TextStyle(color: Colors.black), // Text color in dark mode
                    ),
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

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

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
              style: TextStyle(color: Colors.black), // Text color in dark mode
              decoration: InputDecoration(
                hintText: 'Enter your email',
                labelText: 'Email',
                hintStyle: TextStyle(color: Colors.grey), // Hint text color in dark mode
                labelStyle: TextStyle(color: Colors.black), // Label text color in dark mode
              ),
              onChanged: (value) => loginFormProvider.email = value,
              validator: (value) {
                return (value != null && value.length >= 4) ? null : 'Email cannot be empty';
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.black), // Text color in dark mode
              decoration: InputDecoration(
                hintText: 'Enter your password',
                labelText: 'Password',
                hintStyle: TextStyle(color: Colors.grey), // Hint text color in dark mode
                labelStyle: TextStyle(color: Colors.black), // Label text color in dark mode
              ),
              onChanged: (value) => loginFormProvider.password = value,
              validator: (value) {
                return (value != null && value.length >= 4) ? null : 'Password cannot be empty';
              },
            ),
            const SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.grey,
              color: Colors.blue,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.black), // Text color in dark mode
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
                      final String? errorMessage = await authService.login(loginFormProvider.email, loginFormProvider.password);
                      if (errorMessage == null) {
                        Navigator.pushNamed(context, 'home');
                      } else {
                        print(errorMessage);
                      }
                      loginFormProvider.isLoading = false;
                    },
            )
          ],
        ),
      ),
    );
  }
}
