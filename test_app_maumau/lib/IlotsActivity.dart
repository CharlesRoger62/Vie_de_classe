import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app_maumau/ClassView.dart';
import 'package:test_app_maumau/data/Data.dart';

import 'IlotsActivityNotationDialog.dart';
import 'models/Class.dart';
import 'models/Student.dart';

class IlotsActivity extends StatefulWidget {
  final Class? classe;
  final ClassViewState? parent;

  IlotsActivity({Key? key, this.parent, this.classe}) : super(key: key);

  @override
  IlotsActivityState createState() => IlotsActivityState();
}

class IlotsActivityState extends State<IlotsActivity> {
  Class? classe;
  HashMap<List<Student?>?, double> groupGrades = HashMap();

  @override
  void initState() {
    classe = widget.classe;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Activité de groupe :",
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          areAllGroupNoted()
              ? ElevatedButton(
                  onPressed: () {
                    Data().applychangesFromIlotActivity(groupGrades, classe!);
                    widget.parent!.cancelSelectionIlots();
                    Navigator.of(context).pop();
                  },
                  child:
                      Text("Terminer!", style: TextStyle(color: Colors.white)))
              : ElevatedButton(onPressed: null, child: Container()),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: 800.0,
          height: 800.0,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemExtent: 80.0,
              itemCount: classe!.ilots!.length,
              itemBuilder: (context, index) {
                return groupCard(classe!.ilots![index], index + 1);
              }),
        ),
      ),
    );
  }

  Widget groupCard(List<Student?> ilot, int index) {
    bool isNoted = groupGrades.containsKey(ilot);
    String nameToDisplay = "";
    for (Student? s in ilot) {
      if (ilot.last == s)
        nameToDisplay += " ${s!.firstName}";
      else
        nameToDisplay += " ${s!.firstName},";
    }
    return Card(
      shadowColor: Colors.black,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        height: 200,
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Groupe ${index.toString()} ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: (MediaQuery.of(context).orientation ==
                                    Orientation.portrait)
                                ? MediaQuery.of(context).size.width / 20
                                : MediaQuery.of(context).size.height / 20),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        nameToDisplay,
                        style: TextStyle(
                            fontSize: (MediaQuery.of(context).orientation ==
                                    Orientation.portrait)
                                ? MediaQuery.of(context).size.width / 30
                                : MediaQuery.of(context).size.height / 30),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return IlotsActivityNotationDialog(
                              indexIlot: index, ilot: ilot, parent: this);
                        });
                  },
                  child: Column(
                    children: [
                      Expanded(
                          child: isNoted
                              ? Icon(Icons.assignment_turned_in,
                                  color: Colors.green)
                              : Icon(
                                  Icons.grade,
                                  color: Colors.amberAccent,
                                )),
                      Expanded(
                        child: Text(
                          isNoted
                              ? "Note: ${groupGrades[ilot]!.round().toString()}"
                              : "Noter",
                          style: TextStyle(
                              fontSize: (MediaQuery.of(context).orientation ==
                                      Orientation.portrait)
                                  ? MediaQuery.of(context).size.width / 30
                                  : MediaQuery.of(context).size.height / 30),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addGradeToIlot(List<Student?>? ilot, double grade) {
    setState(() {
      groupGrades[ilot] = grade;
    });
  }

  bool areAllGroupNoted() {
    if (groupGrades.isEmpty) return false;

    for (List<Student?> ilot in classe!.ilots!) {
      if (!groupGrades.containsKey(ilot)) return false;
    }

    return true;
  }
}
