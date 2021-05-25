import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chat_flutter/models/usuario.dart';


class UsuariosPage extends StatefulWidget {


  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  
  final usuarios = [
    Usuario(uid: '1',nombre: 'Jonathan', email: 'test1@gmail.com',online: true),
    Usuario(uid: '2',nombre: 'Javier', email: 'test2@gmail.com',online: false),
    Usuario(uid: '3',nombre: 'Luis', email: 'test3@gmail.com',online: true),
  ];
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Mi nombre', style: TextStyle(color: Colors.black87)),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black87),
          onPressed: (){},
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(Icons.check_circle, color: Colors.blue[400],),
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
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
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
    );
  }
}