import 'package:parisrooftops/screen/connection.dart';
import 'package:flutter/material.dart';

class InscriptionSuccessView extends StatefulWidget {
  InscriptionSuccessView({Key ?key}) : super(key: key);

  @override
  _InscriptionSuccessViewState createState() => _InscriptionSuccessViewState();
}

class _InscriptionSuccessViewState extends State<InscriptionSuccessView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async =>false,
      child: Scaffold(
        body: Stack(fit: StackFit.expand, children: <Widget>[
          Container(
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30,),
                
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Text("ParisRoofTops",
                                   textAlign: TextAlign.justify, 
                                   style:TextStyle(
                                     color:Colors.black,
                                     fontSize:25,
                                     fontFamily: 'Pacifico'
                                     )),
                                 ),

                      
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                   // ignore: deprecated_member_use
                   FlatButton(
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                     color:Theme.of(context).iconTheme.color,
                     onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Connection()));}, 
                   child: Text("Cliquez ici pour vous connecter", style:TextStyle(                                     color:Colors.white,
)))
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}