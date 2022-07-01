import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

class UnderMaintence extends StatefulWidget {
  const UnderMaintence({Key? key}) : super(key: key);

  @override
  State<UnderMaintence> createState() => _UnderMaintenceState();
}

class _UnderMaintenceState extends State<UnderMaintence> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final Uri _urlGithub = Uri.parse("https://github.com/ogiovane");
    final Uri _urlInstagram = Uri.parse("https://www.instagram.com/giovanecs/");
    final Uri _urlLinkedIn =
        Uri.parse("https://www.linkedin.com/in/giovanecarlesso/");
    final Uri _urlWhatsApp = Uri.parse(
        "https://api.whatsapp.com/send?phone=5527999262523&text=Ol%C3%A1%2C%20Giovane!");

    void _abrirPagina(_url) async {
      if (!await launchUrl(
        _url,
        mode: LaunchMode.externalApplication,
      )) {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Em desenvolvimento'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.construction,
                color: Colors.grey,
                size: 200,
              ),
              // Text("\nFuncionalidade ainda não implementada!",
              //     style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
              Text("\nUsuário logado = ${user.email!}",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
                label: Text('Desconectar usuário'),
              ),

              Text('\n Desenvolvido por:',
                  style: TextStyle(fontWeight: FontWeight.w300)),
              Text('Giovane C. Sesquim',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: () {
                    _abrirPagina(_urlGithub);
                  },
                  child: const Text('GitHub'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                  ),
                  onPressed: () {
                    _abrirPagina(_urlInstagram);
                  },
                  child: const Text('Instagram'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                  ),
                  onPressed: () {
                    _abrirPagina(_urlLinkedIn);
                  },
                  child: const Text('LinkedIn'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: () {
                    _abrirPagina(_urlWhatsApp);
                  },
                  child: const Text('WhatsApp'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
