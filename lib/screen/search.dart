import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';

class SearchBox extends StatefulWidget {
  SearchBox({Key ?key}) : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.black)),
        title:
            Text("Lancer une recherche", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                child: Icon(Entypo.hour_glass,size:70, color: Colors.purple)),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 200,
                      height: 40,
                      child:TextField()
                    ),
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                      color: Colors.purple,
                      child:
                          Text("Rechercher", style: TextStyle(color: Colors.white)),
                      onPressed: () {})
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
