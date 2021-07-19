//Fichier de chargement des données lors des requettes http via le serveur

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingData extends StatelessWidget {
  const LoadingData({Key ?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.white,
      child: Center(
        child: SpinKitDoubleBounce(
          duration:Duration(milliseconds:2000),
          color:Colors.purple,
          size:75,
          ),
      ),
    );
  }
}