import 'package:flutter/material.dart';
Route<Object> crearRuta(Widget ruta) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ruta,
    transitionDuration: Duration(milliseconds: 500), 
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curve = CurvedAnimation(parent: animation,curve: Curves.easeInOut);
      return SlideTransition(
        position: Tween<Offset>(begin: Offset(1, 0), end: Offset.zero).animate(curve),
        child: child,
      );
    },
  );
}