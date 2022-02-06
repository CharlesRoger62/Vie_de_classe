import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app_maumau/IlotsActivity.dart';

import 'Student_card.dart';
import 'data/Data.dart';
import 'models/Class.dart';
import 'models/Student.dart';

class ClassView extends StatefulWidget {
  final Class? selectedClass;

  ClassView({this.selectedClass});

  @override
  ClassViewState createState() => ClassViewState();
}

class ClassViewState extends State<ClassView> {
  bool? mode;
  Class? selectedClass;
  bool selectionMode = false;
  List<Student?>? ilotToForm;

  @override
  void initState() {
    mode = Data().mode;
    selectedClass = widget.selectedClass;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Liste des élèves :",
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                if (!selectionMode) {
                  return {'créer ilots'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                } else {
                  return {'annuler ilots'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                }
              },
            ),
          ],
        ),
        body: Center(
          child: SizedBox(
            width: 800.0,
            height: 800.0,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemExtent: 80.0,
                itemCount: selectionMode
                    ? selectedClass!.studentsToPlace!.length
                    : selectedClass!.studentList!.length,
                itemBuilder: (context, index) {
                  if (!selectionMode)
                    return StudentCard(
                        student: selectedClass!.studentList![index],
                        parent: this,
                        selectionMode: selectionMode,
                        isSelected: false);
                  else
                    return StudentCard(
                        student: selectedClass!.studentsToPlace![index],
                        parent: this,
                        selectionMode: selectionMode,
                        isSelected: ilotToForm!
                            .contains(selectedClass!.studentsToPlace![index]));
                }),
          ),
        ),
        floatingActionButton: selectionMode &&
                selectedClass!.studentsToPlace != null &&
                selectedClass!.studentsToPlace!.length > 0
            ? Visibility(
                visible: !selectionMode
                    ? false
                    : ilotToForm!.length >= 2
                        ? true
                        : false,
                child: Badge(
                  badgeColor: Colors.red,
                  badgeContent: selectedClass!.ilots != null
                      ? Text(selectedClass!.ilots!.length.toString(),
                          style: TextStyle(color: Colors.white))
                      : Text("0"),
                  child: FloatingActionButton(
                    child: Icon(Icons.add),
                    backgroundColor: Colors.blue,
                    onPressed: () => addSelectedIlot(),
                  ),
                ),
              )
            : selectionMode &&
                    selectedClass!.studentsToPlace != null &&
                    selectedClass!.studentsToPlace!.length == 0
                ? FloatingActionButton(
                    child: Text("Go"),
                    backgroundColor: Colors.green,
                    onPressed: () => createIlotActivity(),
                  )
                : null);
  }

  void applyChangesToStudent(Student? student) {
    for (Student? s in selectedClass!.studentList!) {
      if (s!.name == student!.name && s.firstName == student.firstName)
        s = student;
    }
    setState(() {
      sortStudentsByGrade();
    });
  }

  void sortStudentsByGrade() {
    if (mode!)
      selectedClass!.studentList!.sort((a, b) => a.grade.compareTo(b.grade));
    else
      selectedClass!.studentList!.sort((a, b) => b.grade.compareTo(a.grade));
  }

  void addOrDeleteSelectedStudent(Student? selectedStudent) {
    setState(() {
      if (!ilotToForm!.contains(selectedStudent))
        ilotToForm!.add(selectedStudent);
      else
        ilotToForm!.remove(selectedStudent);
    });
  }

  void handleClick(String value) {
    switch (value) {
      case 'créer ilots':
        beginSelectionIlots();
        break;
      case 'annuler ilots':
        cancelSelectionIlots();
        break;
    }
  }

  void beginSelectionIlots() {
    selectedClass!.initiateIlots();
    ilotToForm = <Student?>[];
    setState(() {
      selectionMode = true;
    });
  }

  void cancelSelectionIlots() {
    selectedClass!.cancelIlots();
    ilotToForm = null;
    setState(() {
      selectionMode = false;
    });
  }

  void addSelectedIlot() {
    if (selectedClass!.studentsToPlace!.length - ilotToForm!.length == 1) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Erreur"),
              content: Text(
                  " Ce groupe ne peut être former car il ne resterait qu'un seul élève or tous les groupes doivent être au minimun de taille 2."),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Compris!",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    )),
              ],
            );
          });
    } else {
      setState(() {
        selectedClass!.createAnIlot(ilotToForm!);
        ilotToForm = <Student>[];
      });
    }
  }

  void createIlotActivity() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                IlotsActivity(parent: this, classe: widget.selectedClass)));
  }
}
