import 'dart:convert';
import 'package:parisrooftops/component/textfield.dart';
import 'package:parisrooftops/model/loading.dart';
import 'package:parisrooftops/model/userModel.dart';
import 'package:parisrooftops/screen/connection.dart';
import 'package:parisrooftops/screen/inscriptionsuccess.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class Inscription extends StatefulWidget {
  Inscription({Key ?key}) : super(key: key);

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  @override
  Widget build(BuildContext context) {
      final key = GlobalKey<FormState>();
    TextEditingController controllerEmail = TextEditingController();
    TextEditingController controllerMotdepasse = TextEditingController();
    TextEditingController controllerNom = TextEditingController();
    TextEditingController controllerPrenom = TextEditingController();
    TextEditingController controllerConfirm = TextEditingController();
    String connectionStatus=" ";
    // ignore: unused_local_variable
    bool _loading = false, _connected = false;

    void register(
      String nom,
      String prenom,
      String email,
      String motdepasse
    ) async {
      setState(() {
        connectionStatus = "";
        _loading = true;
      });

      final responce = await http.post(
        Uri.parse("https://parisrooftops.000webhostapp.com/booking/register.php"),
          body: {
            "nom": nom,
            "prenom": prenom,
            "email": email,
            "motdepasse": motdepasse
            // "dateinscription": DateTime.now().toString()
          });
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
            _loading = false;
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => InscriptionSuccessView()));
          });
        } else {
          setState(() {
            connectionStatus = result[0];
            _loading = false;
            UserModel.saveUser(UserModel.fromJson(result[7]));
          _connected = true;
          });
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: Colors.purple,
                    title:
                        Text("ERREUR", style: TextStyle(color: Colors.white)),
                    content: Text(connectionStatus,
                        style: TextStyle(color: Colors.white)),
                  ));
        }
      }
    }

  
    return _loading ? LoadingData() : WillPopScope(
            onWillPop: () async => false,

      child: Scaffold(
          body: SingleChildScrollView(
              child: Container(
                  child: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              Center(
                  child: Text("Inscription",
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 39,
                          fontWeight: FontWeight.bold))),
              SizedBox(
                height: 50,
              ),
              textField(
                  Icons.person,
                  "Nom",
                  "John",
                  "votre nom",
                  TextInputType.emailAddress,
                  controllerNom,
                  "votre nom est incorrecte"),
              SizedBox(height: 10),
              textField(
                  Icons.person,
                  "Prenom",
                  "Doe",
                  "votre prenom",
                  TextInputType.emailAddress,
                  controllerPrenom,
                  "votre prenom est incorrecte"),
              SizedBox(height: 10),
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
                  "votre mot de passe est incorrecte"),
              SizedBox(height: 10),
              textField(
                  Icons.person,
                  "Confirmez votre mot de passe",
                  "xxxxxxxxx",
                  "confirmez votre mot de passe",
                  TextInputType.text,
                  controllerConfirm,
                  "retapez votre mot de passe"),
              SizedBox(height: 20),
              // ignore: deprecated_member_use
              RaisedButton(
                  color: Colors.purple,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      if (controllerMotdepasse.text == controllerConfirm.text) {
                        register(
                          controllerNom.text,
                          controllerPrenom.text,
                          controllerEmail.text,
                          controllerMotdepasse.text,
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              backgroundColor: Colors.deepPurpleAccent,
                              title: Text("ERREUR DE SAISIE",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              content: Text("Les mots de passe sont différents",
                                  style: TextStyle(color: Colors.white))),
                        );
                      }
                    }
                  },
                  child: Text("S'inscrire")),
              SizedBox(
                height: 10,
              ),
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Connection()));
                  },
                  child: Text("Déja un compte ?   Se connecter")),
              SizedBox(height: 30),
              Text("ParisRooftops",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 8,
                      fontWeight: FontWeight.bold))
            ],
          ),
        ),
      )))),
    );
  }
}
