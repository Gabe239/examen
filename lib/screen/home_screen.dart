import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navegar al módulo de Proveedores
                Navigator.pushReplacementNamed(context, 'proveedor');
              },
              child: Text('Módulo de Proveedores'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Navegar al módulo de Categorías
                Navigator.pushReplacementNamed(context, 'categoria');
              },
              child: Text('Módulo de Categorías'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Navegar al módulo de Productos
                Navigator.pushReplacementNamed(context, 'list');
              },
              child: Text('Módulo de Productos'),
            ),
          ],
        ),
      ),
    );
  }
}
