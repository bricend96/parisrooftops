import 'dart:convert';
import 'package:parisrooftops/component/textfield.dart';
import 'package:parisrooftops/model/loading.dart';
import 'package:parisrooftops/model/userModel.dart';
import 'package:parisrooftops/screen/home.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:parisrooftops/screen/inscription.dart';
import 'package:flutter/material.dart';

class Connection extends StatefulWidget {
  Connection({Key ?key}) : super(key: key);

  @override
  _ConnectionState createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  String connectionStatus=" ";
  // ignore: unused_field
  bool _loading = false, _connected = false;
  final key = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerMotdepasse = TextEditingController();

  void login(String email, String motdepasse) async {
    setState(() {
      connectionStatus = "";
      _loading = true;
    });
    final responce = await http.post(
        Uri.parse("https://parisrooftops.000webhostapp.com/booking/login.php"),
        body: {"email": email, "motdepasse": motdepasse});
    if (responce.statusCode == 200) {
      
      var data = jsonDecode(responce.body);
      var result = data['result'];
      int success = result[1];
      await FlutterSession().set("id", result[2]);
      await FlutterSession().set("nom", result[3]);
      await FlutterSession().set("prenom", result[4]);
      await FlutterSession().set("email", email);
      await FlutterSession().set("dateinscription", result[6]);


      if (success == 1) {
        setState(() {
          connectionStatus = result[0];
          UserModel.saveUser(UserModel.fromJson(result[7]));
          _connected = true;
          _loading = false;
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Home()));
        });
      } else {
        setState(() {
          connectionStatus = result[0];
          _loading = false;
        });
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  backgroundColor: Colors.purple,
                  title: Text("ERREUR", style: TextStyle(color: Colors.white)),
                  content: Text(connectionStatus,
                      style: TextStyle(color: Colors.white)),
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading ?LoadingData() : Scaffold(
        body: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: Form(
                  key: key,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text("Connexion",
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: 39,
                                    fontWeight: FontWeight.bold))),
                        SizedBox(
                          height: 50,
                        ),
                        textField(
                            Icons.person,
                            "Email",
                            "parisrooftops@gmail.com",
                            "votre email",
                            TextInputType.emailAddress,
                            controllerEmail,
                            "votre email est incorrecte"),
                        SizedBox(height: 10),
                        textField(
                            Icons.person,
                            "Mot de passe",
                            "xxxxxxxxx",
                            "votre mot de passe",
                            TextInputType.text,
                            controllerMotdepasse,
                            "vérifiez votre mot de passe"),
                        SizedBox(height: 20),
                        // ignore: deprecated_member_use
                        RaisedButton(
                            color: Colors.purple,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () {
                              login(controllerEmail.text, controllerMotdepasse.text);
                            },
                            child: Text("Se connecter")),
                        SizedBox(
                          height: 10,
                        ),
                        // ignore: deprecated_member_use
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Inscription()));
                            },
                            child: Text("Pas de compte ?   S'inscrire")),
                        SizedBox(height: 30),
                        Text("ParisRooftops",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 8,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ))));
  }
}
