import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, String title, String description,
        Function onAccept) =>
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(description),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Não'),
                ),
                TextButton(
                  onPressed: () => {onAccept(), Navigator.pop(context, 'OK')},
                  child: const Text('Sim'),
                ),
              ],
            ));
