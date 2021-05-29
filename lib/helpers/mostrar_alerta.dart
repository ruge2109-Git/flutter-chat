import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

mostrarAlerta(BuildContext context, String titulo, String subTitulo){

  if (Platform.isAndroid) {
    
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(titulo),
        content: Text(subTitulo),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Ok'),
            elevation: 5,
            textColor: Colors.blue,
          )
        ],
      ),
    );
  }

  showCupertinoDialog(
    context: context, 
    builder: (context) => CupertinoAlertDialog(
      title: Text(titulo),
      content: Text(subTitulo),
      actions: [
        CupertinoDialogAction(
          child: Text('Ok'),
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context)
        )
      ],
    ),
  );

}
