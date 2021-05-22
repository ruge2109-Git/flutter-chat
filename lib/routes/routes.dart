import 'package:flutter/material.dart';
import 'package:chat_flutter/pages/chat_page.dart';
import 'package:chat_flutter/pages/loading_page.dart';
import 'package:chat_flutter/pages/login_page.dart';
import 'package:chat_flutter/pages/registrar_page.dart';
import 'package:chat_flutter/pages/usuarios_page.dart';

final Map<String,Widget Function(BuildContext)> appRoutes = {
  'usuarios': (_ ) => UsuariosPage(),
  'chat': (_ ) => ChatPage(),
  'login': (_ ) => LoginPage(),
  'registrar': (_ ) => RegistrarPage(),
  'spinner': (_ ) => LoadingPage(),
};