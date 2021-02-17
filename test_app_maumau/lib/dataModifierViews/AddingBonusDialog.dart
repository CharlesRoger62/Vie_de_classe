import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app_maumau/data/Data.dart';
import 'package:test_app_maumau/models/Bonus.dart';

class AddingBonusDialog extends StatefulWidget {
  @override
  _AddingBonusDialogState createState() => _AddingBonusDialogState();
}

class _AddingBonusDialogState extends State<AddingBonusDialog> {

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController valueController = TextEditingController();

    return AlertDialog(
      title: Text("Ajouter un bonus : "),
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
                labelText: "Valeur du bonus ",
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
              String bonusName = nameController.text;
              double bonusValue = double.parse('${valueController.text}');
              Bonus newBonus = Bonus(bonusName,bonusValue);
              Data().bonusList.add(newBonus);
              Data().sortMalusOrBonusList(false);
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
