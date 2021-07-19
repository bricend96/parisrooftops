import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_session/flutter_session.dart';

class Account extends StatefulWidget {
  Account({Key ?key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}
var detailpage;


class _AccountState extends State<Account> {
  @override
  void initState() {
    super.initState();
    // account();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Mon compte"),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        child:Container(
          child:Column(children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top:50.0),
                child: CircleAvatar(
                  radius:58,
                  backgroundColor: Colors.purple,
                  child: CircleAvatar(
                    radius:56,
                    backgroundColor: Colors.white,
                    child: Icon(Entypo.user, color:Colors.grey, size:60)
                  ),
                ),
              ),
            ),
            SizedBox(height:20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Membre depuis le : ", style: TextStyle(color:Colors.grey, fontSize: 15)),
                FutureBuilder(
              future: FlutterSession().get("dateinscription"), 
              builder: (context, snapshot){
              return Text(snapshot.hasData ? snapshot.data.toString() :'Loading...', style: TextStyle(color:Colors.black, fontSize: 15));
            }),
              ],
            ),
          
                      SizedBox(height:40),
            Container(
              color: Colors.white,
              height: 50,
              width: MediaQuery.of(context).size.width/1.2,
              child: Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,

              children: [
              Row(
                children: [
                    Icon(Icons.person, color:Colors.grey),
                SizedBox(width: 20,),
                    Text("Nom : ", style: TextStyle(color:Colors.grey, fontSize: 15)),
                FutureBuilder(
              future: FlutterSession().get("nom"), 
              builder: (context, snapshot){
              return Text(snapshot.hasData? snapshot.data.toString() :'Loading...', style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold, fontSize: 12));
            }),
                ],
              ),
            Row(
              children: [
                Icon(Icons.verified_user)
              ],
            )
              ],
            ),),
            SizedBox(height: 20,),
             Container(
              color: Colors.white,
              height: 50,
              width: MediaQuery.of(context).size.width/1.2,
              child: Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,

              children: [
              Row(
                children: [
                    Icon(Icons.person, color:Colors.grey),
                SizedBox(width: 20,),
                    Text("Prenom : ", style: TextStyle(color:Colors.grey, fontSize: 15)),
                FutureBuilder(
              future: FlutterSession().get("prenom"), 
              builder: (context, snapshot){
              return Text(snapshot.hasData ? snapshot.data.toString() : 'Loading...', style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold, fontSize: 12));
            }),
                ],
              ),
            Row(
              children: [
                Icon(Icons.verified_user)
              ],
            )
              ],
            ),),
            SizedBox(height: 20,),

             Container(
              color: Colors.white,
              height: 50,
              width: MediaQuery.of(context).size.width/1.2,
              child: Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,

              children: [
              Row(
                children: [
                    Icon(Icons.person, color:Colors.grey),
                SizedBox(width: 20,),
                    Text("Email : ", style: TextStyle(color:Colors.grey, fontSize: 15)),
                FutureBuilder(
              future: FlutterSession().get("email"), 
              builder: (context, snapshot){
              return Text(snapshot.hasData? snapshot.data.toString() :'Loading...', style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold, fontSize: 12));
            }),
                ],
              ),
            Row(
              children: [
                Icon(Icons.verified_user)
              ],
            )
              ],
            ),)
             

          ],)
        )
      )
      
    );
  }
}