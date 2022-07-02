import 'package:estacionamento/widgets/Utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';
import '../widgets/forgot_password_page.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/brasao.png',
              height: 160,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: emailController,
              cursorColor: Colors.black,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Email'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) => email != null && email.length < 6 ? 'Entre com um email válido' : null,
            ),
            SizedBox(
              height: 4,
            ),
            TextFormField(
              controller: passwordController,
              cursorColor: Colors.black,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (password) => password != null && password.length < 6 ? 'Senha menor que 6 caracteres' : null,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              icon: Icon(
                Icons.lock_open,
                size: 32,
              ),
              label: Text(
                'Entrar',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              onPressed: signIn,
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              child: Text(
                'Esqueceu a senha?',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
              },
            )
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;

    showDialog(
        context: context,
        builder: (context){
          return Center(child: CircularProgressIndicator(),
          );
        }
    );

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }on FirebaseAuthException catch (error){
      print(error);

      Utils.showSnackBar(error.message);
      Navigator.of(context).pop();
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);

  }
}
