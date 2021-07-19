import 'dart:convert';
import 'package:parisrooftops/model/placesModel.dart';
import 'package:parisrooftops/screen/detail.dart';
import 'package:parisrooftops/screen/drawer.dart';
import 'package:parisrooftops/screen/search.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';

class Home extends StatefulWidget {
  Home({Key ?key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}
// ignore: unused_element
var detailpage; bool _isLiked = false; var user;
String _content = "lien de l'image ou du fichier";
  void _shareThisApp(){
    Share.share(_content);
  }

Future<List<Places>> articles() async {
 
  final responce = await http.get(Uri.parse(
      "https://parisrooftops.000webhostapp.com/booking/getArticle.php"));
  final List responseBody = jsonDecode(responce.body);
  detailpage = responseBody;
  return responseBody.map((e) => Places.fromJson(e)).toList();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    articles();
  
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: Drawermain(),
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text("ParisRooftops"),
          centerTitle: false,
          actions:[
            IconButton(
              onPressed:(){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchBox()));
              }, icon:Icon(Feather.search), 
                
              // icon: Icon(Icons.search, color:Colors.white),
            ),
          ]
        ),
        backgroundColor: Color(0xfff2f2f2),
        body: FutureBuilder<List<Places>>(
            future: articles(),
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

                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Card(
                        elevation: 9,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: 152.7,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            "https://parisrooftops.000webhostapp.com/booking/images/${pack.photo}")),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Column(
                                        children: [
                                          Text(pack.nom.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(pack.description.toString(), overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                          Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Detail(id:pack.id)));
                                                  },
                                                  child: Icon(Feather.eye,
                                                      color: Colors.purple)),
                                                 
                                              InkWell(
                                                
                                                  onTap: () {
                                                   
                                                    addFavorite(pack.id);

                                                  },
                                                  child:Icon(Icons.bookmark_add, color:Colors.purple)),
                                              InkWell(
                                                  onTap: () {
                                                    _shareThisApp();
                                                  },
                                                  child: Icon(Feather.share_2,
                                                      color: Colors.purple)),
                                            ],
                                          )
                                        ],
                                      )),
                                )
                              ],
                            )
                          ],
                        )),
                  );
                },
              );
            }),
      ),
    );
  }
 // ignore: missing_return
 addFavorite (var id) async{
    
    var userid = await FlutterSession().get("id");
    userid=userid.toString();
    id=id.toString();
     final responce = await http.post( 
          Uri.parse(
               "https://parisrooftops.000webhostapp.com/booking/addFavorite.php"),
          body: {
            "postid": id,
            "userid": userid,
          });
      if (responce.statusCode == 200) {
                showModalBottomSheet(
            context: context,
            builder: ((builder) => Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius:20,
                      backgroundColor: Colors.purple,
                      child:Icon(Icons.check, color:Colors.white)
                    ),
                    SizedBox(height:10),
                                      Text("Ajouté dans la liste des favoris", style:TextStyle(color:Colors.black, fontWeight:FontWeight.bold,fontSize:18)
                                      
                                      
                                      ),

                  ],
                ),
              ),
            )),
          );

   
      }
  }
 
}
