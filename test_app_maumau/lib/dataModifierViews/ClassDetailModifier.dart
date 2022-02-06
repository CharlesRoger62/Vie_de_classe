import 'package:flutter/material.dart';
import 'package:test_app_maumau/models/Class.dart';
import 'package:test_app_maumau/models/Student.dart';

import 'StudentCardModifier.dart';

class ClassDetailModifier extends StatefulWidget {
  final Class? classe;

  const ClassDetailModifier({Key? key, this.classe}) : super(key: key);

  @override
  ClassDetailModifierState createState() => ClassDetailModifierState();
}

class ClassDetailModifierState extends State<ClassDetailModifier> {
  Class? classe;

  @override
  void initState() {
    classe = widget.classe;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(classe!.name!)),
      body: Center(
        child: SizedBox(
          width: 800.0,
          height: 800.0,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemExtent: 80.0,
              itemCount: classe!.studentList!.length,
              itemBuilder: (context, index) {
                return StudentCardModifier(
                    student: classe!.studentList![index], parent: this);
              }),
        ),
      ),
    );
  }

  void removeStudent(Student? student) {
    setState(() {
      classe!.studentList!.remove(student);
    });
  }
}
