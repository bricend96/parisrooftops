import 'package:parisrooftops/model/userModel.dart';
import 'package:parisrooftops/screen/connection.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:share/share.dart';
import 'package:parisrooftops/screen/about.dart';
import 'package:parisrooftops/screen/account.dart';
import 'package:parisrooftops/screen/activitymain.dart';
import 'package:parisrooftops/screen/favorite.dart';

class Drawermain extends StatefulWidget {
  Drawermain({Key ?key}) : super(key: key);

  @override
  _DrawermainState createState() => _DrawermainState();
}

class _DrawermainState extends State<Drawermain> {
  String _content = "Telecharge gratuitement l'application ParisRooftops sur playStore: lelien@google.com";
  void _shareThisApp(){
    Share.share(_content);
  }
    isDeconnected() async {
    // ignore: await_only_futures
    await UserModel.logOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Connection()));
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
       child: SingleChildScrollView(
         child: Container(
           child: Column(
             children: [
               Container(
                 color: Colors.purple,
                 height: MediaQuery.of(context).size.height/4,
                 width: MediaQuery.of(context).size.width,
                 child: Center(
                   child:CircleAvatar(
                     radius: 55,
                     backgroundColor:Colors.white,
                     child: Text("ParisRooftops", style:TextStyle(fontFamily:"Pacifico", color:Colors.black)),
                   )
                 ),
               ),
               SizedBox(height: 20,),
             ListTile(
               leading: Icon(Feather.user),
               title:Text("Mon compte"),
               subtitle: Text("vous pouvez consulter vos informations personnelles ici"),
               onTap:(){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Account()));
               } ,
             ),
             SizedBox(height: 10,),
             Divider(),
              ListTile(
               leading: Icon(Feather.activity),
               title:Text("Activité"),
               subtitle: Text("retrouvez la liste de tous les différentes activités disponibles"),
               onTap:(){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Activitymain()));
               } ,
             ),
              SizedBox(height: 10,),
             Divider(),
              ListTile(
               leading: Icon(Icons.bookmark_border),
               title:Text("Favoris"),
               subtitle: Text("consultez la liste de tous vos bookmarks"),
               onTap:(){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Favorite()));
               } ,
             ),
              SizedBox(height: 10,),
             Divider(),
              ListTile(
               leading: Icon(Feather.info),
               title:Text("A propos"),
               subtitle: Text("petite description sur ce notre organisation"),
               onTap:(){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>About()));
               } ,
             ),
              SizedBox(height: 10,),
             Divider(),
              ListTile(
               leading: Icon(Feather.share_2),
               title:Text("Partage"),
               subtitle: Text("partagez notre application sur les réseaux sociaux"),
               onTap:(){
                 _shareThisApp();
               } ,
             ),
               SizedBox(height: 10,),
             Divider(),
              ListTile(
               leading: Icon(Feather.trash_2, color:Colors.red),
               title:Text("Deconnexion", style:TextStyle(color:Colors.red)),
               subtitle: Text("souhaitez vous vraiment nous quitter ? "),
               onTap:(){
                 isDeconnected();
               } ,
             ),
                            SizedBox(height: 10,),

             ],
           ),
         ),
       ),
    );
  }
  
}