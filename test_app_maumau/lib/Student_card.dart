import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app_maumau/AddMalus.dart';
import 'package:test_app_maumau/ClassView.dart';
import 'package:test_app_maumau/data/Data.dart';

import 'models/Bonus.dart';
import 'models/Malus.dart';
import 'models/Student.dart';

class StudentCard extends StatefulWidget {
  final Student? student;
  final ClassViewState? parent;
  final bool? selectionMode;
  final bool? isSelected;

  @override
  StudentCardState createState() => StudentCardState();

  const StudentCard(
      {Key? key,
      this.student,
      this.parent,
      this.selectionMode,
      this.isSelected})
      : super(key: key);
}

class StudentCardState extends State<StudentCard> {
  Student? student;

  @override
  void initState() {
    student = widget.student;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.selectionMode!) {
          widget.parent!.addOrDeleteSelectedStudent(widget.student);
        }
      },
      child: Card(
        shadowColor: Colors.black,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              width: student!.grade == 20.0 && !Data().mode! ? 3.0 : 1.0,
              color: student!.grade == 20.0 && !Data().mode!
                  ? Colors.green
                  : Colors.white,
            ),
            borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          height: 200,
          width: 100,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: <Widget>[
                Visibility(
                  visible: widget.selectionMode!,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Center(
                        child: Icon(Icons.add_circle,
                            color:
                                widget.isSelected! ? Colors.green : Colors.grey,
                            size: 40.0)),
                  ),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    widget.student!.firstName!,
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
                      widget.student!.grade == widget.student!.grade.round()
                          ? widget.student!.grade.toStringAsFixed(0)
                          : widget.student!.grade.toString(),
                      style: TextStyle(
                          color: widget.student!.grade >= 15
                              ? Colors.green
                              : student!.grade >= 10
                                  ? Colors.orange
                                  : Colors.red,
                          fontSize: (MediaQuery.of(context).orientation ==
                                  Orientation.portrait)
                              ? MediaQuery.of(context).size.width / 20
                              : MediaQuery.of(context).size.height / 20),
                    ),
                  ),
                ),
                Visibility(
                  visible: !widget.selectionMode!,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddMalus(
                                student: widget.student,
                                parent: this,
                                isMalus: false);
                          }),
                      child: Center(
                          child: Icon(
                        Icons.add,
                        color: Colors.green,
                        size: 40.0,
                      )),
                    ),
                  ),
                ),
                Visibility(
                  visible: !widget.selectionMode!,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddMalus(
                                student: widget.student,
                                parent: this,
                                isMalus: true);
                          }),
                      child: Center(
                          child: Icon(Icons.remove,
                              color: Colors.red, size: 40.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void applyMalusToStudent(Malus malus) {
    if (student!.malusList == null) student!.malusList = <Malus>[];
    student!.grade += malus.value!;
    student!.malusList!.add(malus);

    widget.parent!.applyChangesToStudent(student);
  }

  void applyBonusToStudent(Bonus bonus) {
    if (student!.bonusList == null) student!.bonusList = <Bonus>[];
    student!.grade += bonus.value!;
    if (student!.grade > 20) student!.grade = 20.0;
    student!.bonusList!.add(bonus);

    widget.parent!.applyChangesToStudent(student);
  }
}
