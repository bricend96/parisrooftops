import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  String? userId;
  String? userName;
  String? userFname;
  String? userEmail;

  UserModel(
      {this.userId,
      this.userName,
      this.userFname,
      this.userEmail,
 });

  static UserModel? sessionUser;
  
  factory UserModel.fromJson(Map<String, dynamic> i) => UserModel(
        userId: i['userId'],
        userName: i['userName'],
        userFname: i['userFname'],
        userEmail: i['userEmail'],
     
      );
  Map<String, dynamic> toMap() => {
        "userId": userId,
        "userName": userName,
        "userFname": userFname,
        "userBorn": userEmail,
      
      };

  static void saveUser(UserModel user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var data = json.encode(user.toMap());
    pref.setString("user", data);
    // ignore: deprecated_member_use
    pref.commit();
  }

  static Future getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var data = pref.getString("user");
    // ignore: unnecessary_null_comparison
    if (data != null) {
      var decode = json.decode(data);
      // ignore: await_only_futures
      var user = await UserModel.fromJson(decode);
      sessionUser = user;
      
    } else {
      sessionUser = null;
    }
  }

 static readData()async{
      SharedPreferences pref = await SharedPreferences.getInstance();

    var data = pref.getString("user");
    // ignore: unnecessary_null_comparison
    if (data != null) {
      var decode = json.decode(data);
      // ignore: await_only_futures
      var user = await UserModel.fromJson(decode);
      sessionUser = user;
    } else {
      sessionUser = null;
    }


  }

  static Future logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString("user", null);

    sessionUser = null;
    // ignore: deprecated_member_use
    pref.commit();
  }
}
