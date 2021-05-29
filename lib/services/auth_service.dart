import 'dart:convert';
import 'dart:developer';

import 'package:chat_flutter/globals/environment.dart';
import 'package:chat_flutter/models/login_response.dart';
import 'package:chat_flutter/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {

  Usuario usuario ;
  bool _autenticando = false;
  final _storage = new FlutterSecureStorage();


  bool get autenticando => _autenticando;
  set autenticando (bool newAutenticando) {
    _autenticando = newAutenticando;
    notifyListeners();
  }

  //Get static
  static Future<String> getToken() async{
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async{
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }


  Future<bool> login(String email, String password) async {

    this.autenticando = true;

    final data = {
      'email':email,
      'password':password,
    };

    Uri url = Uri.parse('${Environments.apiUrl}/login');
    final resp = await http.post(url, body: jsonEncode(data), headers: {
      'Content-Type' :'application/json'
    });

    this.autenticando = false;
    if (resp.statusCode != 200) {
      return false;
    }

    final loginResponse = loginResponseFromJson(resp.body);
    this.usuario = loginResponse.usuario;
    _guardarToken(loginResponse.token);
    return true;
  }

  Future registrar(String nombre,String email, String password ) async{
    this.autenticando = true;
    final data = {
      'nombre':nombre,
      'email':email,
      'password':password,
    };
    Uri url = Uri.parse('${Environments.apiUrl}/login/crearUsuario');
    final resp = await http.post(url, body: jsonEncode(data), headers: {
      'Content-Type' :'application/json'
    });
    this.autenticando = false;
    if (resp.statusCode != 200) {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }

    final loginResponse = loginResponseFromJson(resp.body);
    this.usuario = loginResponse.usuario;
    _guardarToken(loginResponse.token);
    return true;
  }

  Future<bool> estaLogueado() async{
    final token = await _storage.read(key: 'token');
    Uri url = Uri.parse('${Environments.apiUrl}/login/renovarToken');
    final resp = await http.get(url, headers: {
      'Content-Type' :'application/json',
      'x-token': token
    });

    if (resp.statusCode != 200) {
      this.logout();
      return false;
    }

    final loginResponse = loginResponseFromJson(resp.body);
    this.usuario = loginResponse.usuario;
    _guardarToken(loginResponse.token);
    return true;
  }

  Future _guardarToken(String token) async{
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async{
    await _storage.delete(key: 'token');
  }

}