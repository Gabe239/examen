import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:examen/models/categoria.dart';

class CategoriaService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8050';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<Categoria> categorias = [];
  Categoria? selectedCategoria;
  bool isLoading = true;
  bool isEditCreate = true;

  CategoriaService() {
    loadCategorias();
  }

  Future loadCategorias() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_list_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    print(response);
    if (response.statusCode == 200) {
      final dynamic responseData = json.decode(response.body);
      print('Response body: $responseData');
      if (responseData is Map &&
          responseData.containsKey('Listado Categorias')) {
        final dynamic categoriasListado = responseData['Listado Categorias'];
        if (categoriasListado is List) {
          final List<Categoria> categoriasList =
              Categoria.fromJsonList(categoriasListado);
          categorias = categoriasList;
          isLoading = false;
          notifyListeners();
        } else {
          print('Invalid data format: Expected a List');
        }
      } else {
        print(
            'Invalid data format: Expected a Map with key "Listado Categorias"');
      }
    } else {
      print('Failed to load categorias: ${response.statusCode}');
    }
  }

  Future<String> updateCategoria(Categoria categoria) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_edit_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'category_id': categoria.id,
          'category_name': categoria.name,
          'category_state':
              categoria.state, // Include category state in payload
        }),
        headers: {
          'authorization': basicAuth,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print(response);

      if (response.statusCode == 200) {
        final decodeResp = json.decode(response.body);
        print(decodeResp);

        final index =
            categorias.indexWhere((element) => element.id == categoria.id);
        categorias[index] = categoria;

        return 'Categoria actualizada correctamente.';
      } else {
        print('Failed to update categoria: ${response.statusCode}');
        return 'Error al actualizar la categoría. Por favor, inténtalo de nuevo más tarde.';
      }
    } catch (e) {
      print('Exception while updating categoria: $e');
      return 'Error al actualizar la categoría. Por favor, inténtalo de nuevo más tarde.';
    }
  }

  Future<String> createCategoria(Categoria categoria) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_add_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'category_name': categoria.name,
          'category_state':
              categoria.state, // Include category state in payload
        }),
        headers: {
          'authorization': basicAuth,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final decodeResp = json.decode(response.body);
        print(decodeResp);

        // Assuming the response contains the ID of the newly created category
        categoria.id = decodeResp['category_id'];
        categorias.add(categoria);

        return 'Categoría creada correctamente.';
      } else {
        print('Failed to create categoria: ${response.statusCode}');
        return 'Error al crear la categoría. Por favor, inténtalo de nuevo más tarde.';
      }
    } catch (e) {
      print('Exception while creating categoria: $e');
      return 'Error al crear la categoría. Por favor, inténtalo de nuevo más tarde.';
    }
  }

  Future deleteCategoria(Categoria categoria, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_del_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http
        .post(url, body: json.encode({'category_id': categoria.id}), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    this.categorias.clear();
    await loadCategorias();
    Navigator.of(context).pushNamed('categoria');
    return '';
  }
}
