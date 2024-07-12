  import 'package:flutter/material.dart';

Future<void> showAlert(BuildContext context,String title,String message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content:  SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('確認'),
            onPressed: () async{
              Navigator.of(context).pop();
             
            },
          ),
         
        ],
      );
    },
  );
}
