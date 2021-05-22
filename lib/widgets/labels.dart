
import 'package:flutter/material.dart';
class Labels extends StatelessWidget {

  final Widget pageRoute;
  final String titulo;
  final String subTitulo;

  const Labels({
    Key key, 
    @required this.pageRoute, 
    @required this.titulo, 
    @required this.subTitulo
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(this.titulo,style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300)),
          SizedBox(height: 10),
          GestureDetector(
            child: Text(this.subTitulo, style: TextStyle(color: Colors.blue[600],fontSize: 18,fontWeight: FontWeight.bold)),
            onTap: (){
              Navigator.pushReplacement(context, _crearRuta());
              // Navigator.pushReplacementNamed(context, 'registrar');
            },
          )
        ],
      ),
    );
  }

  Route<Object> _crearRuta() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => pageRoute,
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

}