import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';

class About extends StatefulWidget {
  About({Key ?key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:AppBar(
         backgroundColor: Colors.purple,
         title:Text("A propos"),
         centerTitle: true,
       ),

       body: SingleChildScrollView(
         child: Container(
           child:Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Padding(
                 padding: const EdgeInsets.only(top:25.0, left: 25),
                 child: Row(
                   children: [
                     CircleAvatar(
                   radius:60,
                   backgroundColor:Colors.purple,
                   child: CircleAvatar(
                     backgroundColor: Colors.white,
                     radius: 57,
                     child: Icon(Feather.info),
                     )
                 ),
                 SizedBox(width: 30,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ParisRooftops", style:TextStyle(fontFamily: "Pacifico", color:Colors.black, fontSize:18)),
                      SizedBox(height:12),
                      Text("Version 1.0", style:TextStyle(color:Colors.grey, fontSize:14))
                    ],
                  ), 
                  
                   ],
                 )
               ),
               SizedBox(height: 45,),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text("Notre mission", style:TextStyle(color:Colors.grey, fontWeight: FontWeight.bold, fontSize:24)),
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text("Start up localisée en France et une des grandes société de son domaine. Nous travaillons chaque jour pour qu'explorer la France soit a la portée de tous."),
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text("Pour mener a bien cette mission et permettre a chacun de vivre des expériences en toute simplicité, la société invistit dans la technologie. Nous proposons ainsi a des millions de personnes , voyageurs et autres des activités inoubliables, des options de loisir et de détente optimales et incroyables. "),
               )
             ],
           )
         ),),
    );
  }
}