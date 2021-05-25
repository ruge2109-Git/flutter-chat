import 'dart:io';

import 'package:chat_flutter/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  bool _estaEscribiendo = false;

  List<ChatMessage> _message = [];

  @override
  void dispose() {

    _textController.dispose();

    for (ChatMessage message in _message) {
      message.controller.dispose();
    }

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('Jonathan', style: TextStyle(color: Colors.black87)),
        leading: Container(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
            child: Text('Jo', style: TextStyle(fontSize: 14)),
            backgroundColor: Colors.blue[200],
            maxRadius: 10,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children:[
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _message.length,
                itemBuilder: (context, index) => _message[index],
                reverse: true,
              )
            ),
            Divider(height: 1),
            Container(
              color: Colors.white,
              height: 50,
              child: _inputChat(),
            )
          ] 
        ),
      ),
    );
  }

  Widget _inputChat(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (texto){
                  if (texto.trim().length >0) {
                    _estaEscribiendo = true;
                  }
                  setState(() {});
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Escribir mensaje'
                ),
                focusNode: _focusNode,
              )
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: 
                Platform.isIOS 
                ? CupertinoButton(
                  child: Text('Enviar'), 
                  onPressed: _estaEscribiendo ?  () => _handleSubmit : null
                )
                : Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.blue[400]),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon(Icons.send), 
                      onPressed: _estaEscribiendo ?  () => _handleSubmit : null
                    ),
                  ),
                )


            )
          ],
        ),
      )
    );
  }

  _handleSubmit(String valor){

    if (valor.length==0) return;

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      texto: valor, 
      uid: '123', 
      controller: AnimationController(vsync: this, duration: Duration(milliseconds: 400))
    );
    newMessage.controller.forward();
    _message.insert(0,newMessage);
    

    setState(() {
      _estaEscribiendo = false;
    });
  }
}