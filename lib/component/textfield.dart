import 'package:flutter/material.dart';

Widget textField(
  IconData typeIcon,
  String textLabel,
  String textHint,
  String textHelp,
  TextInputType textInput,
  TextEditingController controller,
  String err,
) {
  // ignore: unused_local_variable
  String fvalue;
  return TextFormField(
    onChanged: (e) {
       fvalue = e;
    },
    validator: (e) => e!.isEmpty ? err : null,
    controller: controller,
    decoration: InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      prefixIcon: Icon(typeIcon, color:Colors.purple),
      labelText: textLabel,
      labelStyle: TextStyle(color:Colors.purple),
      hintText: textHint,
      hintStyle: TextStyle(color: Colors.grey),
      helperText: textHelp,
    ),
    keyboardType: textInput,
  );
}

