import 'package:chat_flutter/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChatMessage extends StatelessWidget {

  final String texto;
  final String uid;
  final AnimationController controller;

  const ChatMessage({
    Key key, 
    @required this.texto, 
    @required this.uid, 
    @required this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return FadeTransition(
      opacity: controller,
      child: SizeTransition(
          sizeFactor: CurvedAnimation(parent: controller, curve: Curves.easeOut),
          child: Container(
          child: uid == authService.usuario.uid ? _myMessage() : _notMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage(){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 5, left: 50, right: 5),
        child: Text(texto, style: TextStyle(color: Colors.white)),
        decoration: BoxDecoration(
          color: Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(20)
        ),

      )
    );
  }

  Widget _notMyMessage(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 5, left: 5, right: 50),
        child: Text(texto, style: TextStyle(color: Colors.black87)),
        decoration: BoxDecoration(
          color: Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20)
        ),

      )
    );
  }
}