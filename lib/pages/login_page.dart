import 'package:flutter/material.dart';
import 'package:chat_flutter/helpers/mostrar_alerta.dart';
import 'package:chat_flutter/helpers/transicion_rutas.dart';
import 'package:chat_flutter/pages/registrar_page.dart';
import 'package:chat_flutter/pages/usuarios_page.dart';
import 'package:chat_flutter/services/auth_service.dart';
import 'package:chat_flutter/widgets/boton_azul.dart';
import 'package:chat_flutter/widgets/custom_input.dart';
import 'package:chat_flutter/widgets/labels.dart';
import 'package:chat_flutter/widgets/logo.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(
                  titulo: 'J.R chat',
                ),
                _Form(),
                Labels(
                  titulo: '¿No tienes cuenta?',
                  subTitulo: 'Crea una ahora',
                  pageRoute: RegistrarPage(),
                ),
                Text('Terminos y condiciones', style: TextStyle(fontWeight: FontWeight.w200),)
              ],
            ),
          ),
        ),
      )
   );
  }
}


class _Form extends StatefulWidget {
  
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);


    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail,
            placeholder: 'Correo electrónico',
            inputType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock,
            placeholder: 'Contraseña',
            inputType: TextInputType.text,
            textController: passwordCtrl,
            isPassword: true,
          ),
          BotonAzul(texto: 'Ingresar',function: (!authService.autenticando)
            ? () async{
              FocusScope.of(context).unfocus();
              final login = await authService.login(emailCtrl.text.trim(), passwordCtrl.text);
              if ( login ) {
                Navigator.pushReplacement(context, crearRuta(UsuariosPage()));
              }
              else{
                mostrarAlerta(context, 'Error', "Credenciales incorrectas");
              }
            }
            : null
          )
        ],
       ),
    );
  }

}
