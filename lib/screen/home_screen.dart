import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        automaticallyImplyLeading: false, // Hide the back arrow
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ModuleCard(
              title: 'Módulo de Proveedores',
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'proveedor');
              },
            ),
            SizedBox(height: 20.0),
            _ModuleCard(
              title: 'Módulo de Categorías',
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'categoria');
              },
            ),
            SizedBox(height: 20.0),
            _ModuleCard(
              title: 'Módulo de Productos',
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'list');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const _ModuleCard({
    required this.title,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Add elevation for a shadow effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
