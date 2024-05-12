import 'package:flutter/material.dart';
import 'package:examen/models/categoria.dart';
import 'package:examen/services/category_service.dart';

class CategoriaScreen extends StatefulWidget {
  const CategoriaScreen({Key? key}) : super(key: key);

  @override
  _CategoriaScreenState createState() => _CategoriaScreenState();
}

class _CategoriaScreenState extends State<CategoriaScreen> {
  final CategoriaService categoriaService = CategoriaService();
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    categoriaService.loadCategorias().then((_) {
      setState(() {}); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Módulo de Categorias'),
        automaticallyImplyLeading: false, 
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, 'home', (route) => false);
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await categoriaService.loadCategorias();
          setState(() {}); 
        },
        child: ListView.builder(
          itemCount: categoriaService.categorias.length,
          itemBuilder: (context, index) {
            Categoria categoria = categoriaService.categorias[index];
            return ListTile(
              title: Text(categoria.name),
              subtitle:
                  Text('Estado: ${categoria.state}'), 
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _showEditDialog(categoria);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _showDeleteDialog(categoria);
                    },
                  ),
                ],
              ),
              onLongPress: () {
                _showDeleteDialog(categoria);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

Future<void> _showAddDialog() async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Agregar Categoría'),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'Nombre de la categoría'),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Agregar'),
            onPressed: () async {
              String categoryName = _controller.text.trim();
              if (categoryName.isNotEmpty) {
                Categoria newCategoria = Categoria(
                  id: 0,
                  name: categoryName,
                  state: 'Activa',
                );
                await categoriaService.createCategoria(newCategoria);
                Navigator.of(context).pop();
                setState(() {}); 
              }
            },
          ),
        ],
      );
    },
  );
}

Future<void> _showEditDialog(Categoria categoria) async {
  TextEditingController nameController =
      TextEditingController(text: categoria.name);
  TextEditingController stateController =
      TextEditingController(text: categoria.state);
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Editar Categoría'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Nombre de la categoría'),
            ),
            TextField(
              controller: stateController,
              decoration: InputDecoration(hintText: 'Estado de la categoría'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Guardar'),
            onPressed: () async {
              String newName = nameController.text.trim();
              String newState = stateController.text.trim();
              if (newName.isNotEmpty) {
                Categoria updatedCategoria = Categoria(
                  id: categoria.id,
                  name: newName,
                  state: newState,
                );
                await categoriaService.updateCategoria(updatedCategoria);
                Navigator.of(context).pop();
                setState(() {}); 
              }
            },
          ),
        ],
      );
    },
  );
}

Future<void> _showDeleteDialog(Categoria categoria) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Eliminar Categoría'),
        content:
            Text('¿Estás seguro de que quieres eliminar esta categoría?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Eliminar'),
            onPressed: () async {
              await categoriaService.deleteCategoria(categoria, context);
              Navigator.of(context).pop();
              setState(() {}); 
            },
          ),
        ],
      );
    },
  );
}
}