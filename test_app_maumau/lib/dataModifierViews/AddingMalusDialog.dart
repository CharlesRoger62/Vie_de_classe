import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app_maumau/data/Data.dart';
import 'package:test_app_maumau/models/Malus.dart';

class AddingMalusDialog extends StatefulWidget {
  @override
  _AddingMalusDialogState createState() => _AddingMalusDialogState();
}

class _AddingMalusDialogState extends State<AddingMalusDialog> {

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController valueController = TextEditingController();

    return AlertDialog(
      title: Text("Ajouter un malus : "),
      content: SizedBox(
        height: 150.0,
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Nom",
              ),
            ),
            TextField(
              controller: valueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Valeur du malus (en absolu) ",
              ),
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              },
            child: Text("Annuler",
              style: TextStyle(
                color: Colors.red,
              ),
            )
        ),
        FlatButton(
            onPressed: () {
              String malusName = nameController.text;
              double malusValue = double.parse('${valueController.text}') * -1;
              Malus newMalus = Malus(malusName,malusValue);
              Data().malusList.add(newMalus);
              Data().sortMalusOrBonusList(true);
              Navigator.of(context).pop();
              },
            child: Text("Valider",
              style: TextStyle(
                  color: Colors.blue
              ),
            )
        )
      ],
    );
  }
}
