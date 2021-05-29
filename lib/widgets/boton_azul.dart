import 'package:flutter/material.dart';
class BotonAzul extends StatelessWidget {

  final Function function;
  final String texto;

  const BotonAzul({Key key, @required this.function,@required this.texto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(2),
        backgroundColor: (function != null)? MaterialStateProperty.all<Color>(Colors.blue): MaterialStateProperty.all<Color>(Colors.blueGrey[400]),
        shape: MaterialStateProperty.all<StadiumBorder>(StadiumBorder())
      ),
      onPressed: function,
      child: Container(
        width: double.infinity,
        height: 30,
        child: Center(
          child: Text(texto, style: TextStyle(color: (function!=null) ? Colors.white: Colors.black54, fontSize: 17))
        )
      ),
    );
  }
}