import 'package:chat_flutter/helpers/transicion_rutas.dart';
import 'package:chat_flutter/pages/chat_page.dart';
import 'package:chat_flutter/pages/login_page.dart';
import 'package:chat_flutter/services/auth_service.dart';
import 'package:chat_flutter/services/chat_service.dart';
import 'package:chat_flutter/services/socket_service.dart';
import 'package:chat_flutter/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chat_flutter/models/usuario.dart';


class UsuariosPage extends StatefulWidget {


  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  
  final usuarioService = UsuarioService();
  List<Usuario> usuarios = [];
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    this._cargarUsuarios();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(authService.usuario.nombre, style: TextStyle(color: Colors.black87)),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black87),
          onPressed: (){
            AuthService.deleteToken();
            socketService.desconectar();
            Navigator.pushReplacement(context, crearRuta(LoginPage()));
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: (socketService.serverStatus == ServerStatus.Online) 
            ? Icon(Icons.check_circle, color:  Colors.blue[400])
            : Icon(Icons.offline_bolt, color:  Colors.red)
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue[400],
        ),
        child: _ListViewUsuarios(usuarios: usuarios),
      )
    );
  }

  void _cargarUsuarios() async {
    this.usuarios = await usuarioService.obtenerUsuarios();
    setState(() {});
    _refreshController.refreshCompleted();
  }
}

class _ListViewUsuarios extends StatelessWidget {
  const _ListViewUsuarios({
    Key key,
    @required this.usuarios,
  }) : super(key: key);

  final List<Usuario> usuarios;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => _UsuarioListTile(usuario: usuarios[index]), 
      separatorBuilder: (context, index) => Divider(), 
      itemCount: usuarios.length
    );
  }
}

class _UsuarioListTile extends StatelessWidget {
  
  final Usuario usuario;

  const _UsuarioListTile({Key key, @required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0,2)),
        backgroundColor: Colors.blue[200],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green[300] : Colors.red,
          borderRadius: BorderRadius.circular(100)
        ),
      ),
      onTap: (){
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioDestino = usuario;
        Navigator.push(context, crearRuta(ChatPage()));
      },
    );
  }
}