import 'package:chat_flutter/globals/environment.dart';
import 'package:chat_flutter/models/mensajes_response.dart';
import 'package:chat_flutter/models/usuario.dart';
import 'package:chat_flutter/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  
  Usuario usuarioDestino;  

  Future<List<Mensaje>> obtenerMensajes(String usuarioID) async{
     try {
      Uri url = Uri.parse('${Environments.apiUrl}/mensajes/$usuarioID');
      final res = await http.get(url,headers:{
        'Content-Type' :'application/json',
        'x-token': await AuthService.getToken()
      });
      final mensajesResponse = mensajesResponseFromJson(res.body);
      return mensajesResponse.mensajes;
    } 
    catch (e) {
      print(e);
      return [];
    }
  }


}