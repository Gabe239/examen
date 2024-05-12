import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:examen/models/proveedor.dart';

class ProviderService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8050';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<Proveedor> providers = [];
  Proveedor? selectedProvider;
  bool isLoading = true;
  bool isEditCreate = true;

  ProviderService() {
    loadProviders();
  }

  Future loadProviders() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_list_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.get(url, headers: {'authorization': basicAuth});

    if (response.statusCode == 200) {
      final dynamic responseData = json.decode(response.body);
      print('Response body: $responseData');
      if (responseData is Map &&
          responseData.containsKey('Proveedores Listado')) {
        final dynamic proveedoresListado = responseData['Proveedores Listado'];
        if (proveedoresListado is List) {
          final List<Proveedor> providersList =
              Proveedor.fromJsonList(proveedoresListado);
          providers = providersList;
          isLoading = false;
          notifyListeners();
        } else {
          print('Invalid data format: Expected a List');
        }
      } else {
        print(
            'Invalid data format: Expected a Map with key "Proveedores Listado"');
      }
    } else {
      print('Failed to load providers: ${response.statusCode}');
    }
  }

  Future editOrCreateProvider(Proveedor provider) async {
    print(provider);

    isEditCreate = true;
    notifyListeners();
    if (provider.id == 0) {
      await createProveedor(provider);
    } else {
      await updateProveedor(provider);
    }
    isEditCreate = false;
    notifyListeners();
  }

  Future<String> updateProveedor(Proveedor provider) async {
  final url = Uri.http(
    _baseUrl,
    'ejemplos/provider_edit_rest/',
  );
  String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
  
  try {
    final response = await http.post(
      url,
      body: json.encode({
        'provider_id': provider.id, // Include provider ID in payload
        'provider_name': provider.name,
        'provider_last_name': provider.lastName,
        'provider_mail': provider.mail,
        'provider_state': provider.state, // Include provider state in payload
      }),
      headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    
    if (response.statusCode == 200) {
      // Update the local list of providers if the update in the database was successful
      final index = providers.indexWhere((element) => element.id == provider.id);
      if (index != -1) {
        providers[index] = provider;
        notifyListeners();
      }
      return 'Proveedor actualizado correctamente';
    } else {
      throw Exception('Error al actualizar el proveedor: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error al actualizar el proveedor: $e');
  }
}

  Future<String> createProveedor(Proveedor provider) async {
  final url = Uri.http(
    _baseUrl,
    'ejemplos/provider_add_rest/',
  );
  String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
  
  try {
    final response = await http.post(
      url,
      body: json.encode({
        'provider_name': provider.name,
        'provider_last_name': provider.lastName,
        'provider_mail': provider.mail,
        'provider_state': provider.state,
      }),
      headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    
    if (response.statusCode == 200) {

      providers.add(provider);
      notifyListeners();
      return 'Proveedor creado correctamente';
    } else {
      throw Exception('Error al crear el proveedor: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error al crear el proveedor: $e');
  }
}
  Future deleteProvider(Proveedor provider, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_del_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http
        .post(url, body: json.encode({'provider_id': provider.id}), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    this.providers.clear();
    await loadProviders();
    return '';
  }
}
