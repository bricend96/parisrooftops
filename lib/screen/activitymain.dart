import 'dart:convert';
import 'package:parisrooftops/model/activiteModel.dart';
import 'package:parisrooftops/screen/morepage.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class Activitymain extends StatefulWidget {
  Activitymain({Key ?key}) : super(key: key);

  @override
  _ActivitymainState createState() => _ActivitymainState();
}

Future<List<Activities>> activities() async {
  final responce = await http.get(Uri.parse(
      "https://parisrooftops.000webhostapp.com/booking/getActivite.php"));
  final List responseBody = jsonDecode(responce.body);
  return responseBody.map((e) => Activities.fromJson(e)).toList();
}

class _ActivitymainState extends State<Activitymain> {
  @override
  void initState() {
    super.initState();
    activities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text("Activité"),
          centerTitle: true,
        ),
        body: FutureBuilder<List<Activities>>(
            future: activities(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitPulse(color: Colors.purple, size: 70),
                      Text("Chargement...",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 18))
                    ],
                  ),
                );
              }
              final packs = snapshot.data;
              return ListView.builder(
                  itemCount: packs!.length,
                  itemBuilder: (context, index) {
                    final pack = packs[index];
                    return Container(
                        child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ListTile(
                              leading: CircleAvatar(
                                radius:40,
                                
                                backgroundColor:Colors.transparent,
                                child:ClipOval(
                                  
                                  child: Image.network("https://parisrooftops.000webhostapp.com/booking/images/activite/${pack.photo}" ,height: 80,
                                  
                                   ),
                                )
                              ),
                              title: Text(pack.nom.toString()),
                              subtitle: Text(pack.description.toString(), overflow: TextOverflow.ellipsis,),
                              trailing: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MorePage(categorie: pack.nom)));
                                  },
                                  icon: Icon(Feather.arrow_right))),
                        ),
                        Divider(),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ));
                  });
            }));
  }
}
