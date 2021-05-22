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
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        shape: MaterialStateProperty.all<StadiumBorder>(StadiumBorder())
      ),
      onPressed: function,
      child: Container(
        width: double.infinity,
        height: 30,
        child: Center(
          child: Text(texto, style: TextStyle(color: Colors.white, fontSize: 17))
        )
      ),
    );
  }
}