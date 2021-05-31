import 'package:chat_flutter/services/auth_service.dart';
import 'package:chat_flutter/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: verificarLogin(context),
        builder: (context, snapshot) {
          return  Center(
            child: Text('Cargando...'),
          );
        },
      ),
    );
  }

  Future verificarLogin(BuildContext context) async{
    final authService = Provider.of<AuthService>(context,listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final autenticado = await authService.estaLogueado();
    if (autenticado) {
      socketService.conectar();
      Navigator.pushReplacementNamed(context, 'usuarios');
    }
    else{
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}