import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app_maumau/Student_card.dart';

import 'data/Data.dart';
import 'models/Bonus.dart';
import 'models/Malus.dart';
import 'models/Student.dart';

class AddMalus extends StatefulWidget {
  final Student? student;
  final StudentCardState? parent;
  final bool? isMalus;

  const AddMalus({Key? key, this.student, this.parent, this.isMalus})
      : super(key: key);

  @override
  _AddMalusState createState() => _AddMalusState();
}

class _AddMalusState extends State<AddMalus> {
  List<Malus>? malusList;
  List<Bonus>? bonusList;
  Malus? malusSelected;
  Bonus? bonusSelected;

  @override
  void initState() {
    malusList = Data().malusList;
    bonusList = Data().bonusList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Text(widget.isMalus!
          ? "Ajouter un malus à  ${widget.student!.firstName} ?"
          : "Ajouter un bonus à ${widget.student!.firstName} ?"),
      content: SizedBox(
        width: 800.0,
        height: 300.0,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemExtent: 80.0,
            itemCount: widget.isMalus! ? malusList!.length : bonusList!.length,
            itemBuilder: (context, index) {
              if (widget.isMalus!)
                return malusCard(malusList![index]);
              else
                return bonusCard(bonusList![index]);
            }),
      ),
      actions: <Widget>[
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Annuler",
              style: TextStyle(
                color: Colors.red,
              ),
            )),
        ElevatedButton(
            onPressed: () {
              if (malusSelected != null) {
                widget.parent!.applyMalusToStudent(malusSelected!);
                Navigator.of(context).pop();
              } else if (bonusSelected != null) {
                widget.parent!.applyBonusToStudent(bonusSelected!);
                Navigator.of(context).pop();
              }
            },
            child: Text(
              "Valider",
              style: TextStyle(
                color: malusSelected != null
                    ? Colors.blue
                    : bonusSelected != null
                        ? Colors.blue
                        : Colors.grey,
                fontWeight: malusSelected != null
                    ? FontWeight.bold
                    : bonusSelected != null
                        ? FontWeight.bold
                        : null,
                fontSize: malusSelected != null
                    ? 17.0
                    : bonusSelected != null
                        ? 17.0
                        : null,
              ),
            )),
      ],
    );
  }

  Widget malusCard(Malus malus) {
    return GestureDetector(
      onTap: () {
        setState(() {
          malusSelected = malus;
        });
      },
      child: Card(
        shadowColor: Colors.black,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 3.0,
              color: malus == malusSelected ? Colors.blue : Colors.white,
            ),
            borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          height: 400,
          width: 100,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                      child: Text(
                    malus.name,
                    style: TextStyle(
                        fontSize: (MediaQuery.of(context).orientation ==
                                Orientation.portrait)
                            ? MediaQuery.of(context).size.width / 20
                            : MediaQuery.of(context).size.height / 20),
                  )),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    malus.value == malus.value!.round()
                        ? malus.value!.toStringAsFixed(0)
                        : malus.value.toString(),
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: (MediaQuery.of(context).orientation ==
                                Orientation.portrait)
                            ? MediaQuery.of(context).size.width / 20
                            : MediaQuery.of(context).size.height / 20),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bonusCard(Bonus bonus) {
    return GestureDetector(
      onTap: () {
        setState(() {
          bonusSelected = bonus;
        });
      },
      child: Card(
        shadowColor: Colors.black,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 3.0,
              color: bonus == bonusSelected ? Colors.blue : Colors.white,
            ),
            borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          height: 400,
          width: 100,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                      child: Text(
                    bonus.name,
                    style: TextStyle(
                        fontSize: (MediaQuery.of(context).orientation ==
                                Orientation.portrait)
                            ? MediaQuery.of(context).size.width / 20
                            : MediaQuery.of(context).size.height / 20),
                  )),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    bonus.value == bonus.value!.round()
                        ? "+" + bonus.value!.toStringAsFixed(0)
                        : "+" + bonus.value.toString(),
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: (MediaQuery.of(context).orientation ==
                                Orientation.portrait)
                            ? MediaQuery.of(context).size.width / 20
                            : MediaQuery.of(context).size.height / 20),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
