import 'package:flutter/material.dart';
class CustomInput extends StatelessWidget {

  final IconData icon;
  final TextInputType inputType;
  final String placeholder;
  final TextEditingController textController;
  final bool isPassword;

  const CustomInput({
    Key key, 
    @required this.icon, 
    this.inputType = TextInputType.text, 
    @required this.placeholder, 
    @required this.textController, 
    this.isPassword = false
  }) : super(key: key);

  // const CustomInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.only(top: 5,left: 5,bottom: 5,right: 20),
      margin: EdgeInsets.only(bottom:20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), offset: Offset(0,5), blurRadius: 5)
        ]
      ),
      child: TextField(
        controller: textController,
        autocorrect: false,
        keyboardType: inputType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: placeholder,
        ),
        obscureText: isPassword,
      )
    );
  }
}