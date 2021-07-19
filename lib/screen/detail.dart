import 'dart:convert';
import 'package:parisrooftops/model/loading.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {
  Detail({Key ?key, this.id}) : super(key: key);
  final id;
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  var detailpage;
  var data = [];
  bool _load = true;
  String nom=" ", description=" ", evenement=" ", lieu=" ", contact=" ", photo=" ";
  @override
  void initState() {
    super.initState();
    var index = widget.id;
    articles(index);
  }

  void articles(String id) async {
    final responce = await http.post(
        Uri.parse(
            "https://parisrooftops.000webhostapp.com/booking/getArticleId.php"),
        body: {
          "id": id,
        });
    if (responce.statusCode == 200) {
      final List responseBody = jsonDecode(responce.body);
      data = responseBody;
      nom = data[0]['nom'];
      description = data[0]['description'];
      lieu = data[0]['lieu'];
      contact = data[0]['contact'];
      evenement = data[0]['evenement'];
      photo = data[0]['photo'];
      setState(() {
        _load = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _load
        ? LoadingData()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.purple,
              centerTitle: true,
              title: Text(
                "Détail",
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                // ignore: unnecessary_brace_in_string_interps
                                "https://parisrooftops.000webhostapp.com/booking/images/${photo}"))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      nom,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(description),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Evenement a venir : ",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          SizedBox(height: 15),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Icon(Feather.alert_octagon, color: Colors.purple),
                                SizedBox(width: 20),
                                Text(evenement)
                              ],
                            ),
                          )
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Localisation & Contacts: ",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Icon(Feather.map_pin, color: Colors.purple),
                              SizedBox(
                                width: 20,
                              ),
                              Text(lieu)
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Feather.phone, color: Colors.purple),
                              SizedBox(
                                width: 20,
                              ),
                              Text(contact)
                            ],
                          ),
                        ],
                      )),
                ],
              )),
            ));
  }
}
