import 'package:flutter/material.dart';
import 'package:examen/models/proveedor.dart';
import 'package:examen/services/services.dart';
import 'package:provider/provider.dart';

class ProvidersScreen extends StatelessWidget {
  const ProvidersScreen({Key? key}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context);
    final List<Proveedor> providers = providerService.providers;

    return Scaffold(
      appBar: AppBar(
        title: Text('Módulo de Proveedores'),
      ),
      body: ListView.builder(
        itemCount: providers.length,
        itemBuilder: (context, index) {
          final provider = providers[index];
          return ListTile(
            title: Text(provider.name),
            subtitle: Text(provider.lastName),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProviderDetailScreen(provider),
                ),
              );
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProviderEditScreen(provider),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await providerService.deleteProvider(provider, context);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProviderAddScreen(),
            ),
          );
        },
      ),
    );
  }
}

class ProviderDetailScreen extends StatelessWidget {
  final Proveedor provider; 

  ProviderDetailScreen(this.provider);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del Proveedor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nombre: ${provider.name} ${provider.lastName}'),
            Text('Correo: ${provider.mail}'),
            Text('Estado: ${provider.state}'),
          ],
        ),
      ),
    );
  }
}

class ProviderEditScreen extends StatelessWidget {
  final Proveedor provider;

  ProviderEditScreen(this.provider);

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context);
    TextEditingController nameController = TextEditingController(text: provider.name);
    TextEditingController lastNameController = TextEditingController(text: provider.lastName);
    TextEditingController mailController = TextEditingController(text: provider.mail);
    TextEditingController stateController = TextEditingController(text: provider.state);

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Proveedor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Apellido'),
            ),
            TextFormField(
              controller: mailController,
              decoration: InputDecoration(labelText: 'Correo'),
            ),
            TextFormField(
              controller: stateController,
              decoration: InputDecoration(labelText: 'Estado'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Proveedor updatedProvider = Proveedor(
                  id: provider.id,
                  name: nameController.text,
                  lastName: lastNameController.text,
                  mail: mailController.text,
                  state: stateController.text,
                );
                print(updatedProvider);
                providerService.updateProveedor(updatedProvider);
                Navigator.pop(context);
              },
              child: Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProviderAddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context);
    TextEditingController nameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController mailController = TextEditingController();
    TextEditingController stateController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Proveedor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Apellido'),
            ),
            TextFormField(
              controller: mailController,
              decoration: InputDecoration(labelText: 'Correo'),
            ),
            TextFormField(
              controller: stateController,
              decoration: InputDecoration(labelText: 'Estado'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Proveedor newProvider = Proveedor(
                  id: 0, 
                  name: nameController.text,
                  lastName: lastNameController.text,
                  mail: mailController.text,
                  state: stateController.text,
                );
                print("screen");
                providerService.createProveedor(newProvider);
                Navigator.pop(context);
              },
              child: Text('Agregar Proveedor'),
            ),
          ],
        ),
      ),
    );
  }
}
