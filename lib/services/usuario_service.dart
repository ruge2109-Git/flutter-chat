import 'package:chat_flutter/models/usuarios_response.dart';
import 'package:chat_flutter/globals/environment.dart';
import 'package:chat_flutter/services/auth_service.dart';
import 'package:chat_flutter/models/usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioService {
  
  Future<List<Usuario>> obtenerUsuarios() async{
    try {
      Uri url = Uri.parse('${Environments.apiUrl}/usuarios');
      final res = await http.get(url,headers:{
        'Content-Type' :'application/json',
        'x-token': await AuthService.getToken()
      });
      final usuariosResponse = usuariosResponseFromJson(res.body);
      return usuariosResponse.usuarios;
    } 
    catch (e) {
      print(e);
      return [];
    }
  }

}