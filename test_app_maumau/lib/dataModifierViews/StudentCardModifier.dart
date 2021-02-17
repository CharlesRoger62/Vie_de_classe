import 'package:flutter/material.dart';
import 'package:test_app_maumau/dataModifierViews/ClassDetailModifier.dart';
import 'package:test_app_maumau/models/Student.dart';

class StudentCardModifier extends StatefulWidget {
  final Student student;
  final ClassDetailModifierState parent;

  const StudentCardModifier({Key key, this.student, this.parent}) : super(key: key);

  @override
  _StudentCardModifierState createState() => _StudentCardModifierState();
}

class _StudentCardModifierState extends State<StudentCardModifier> {
  Student student;

  @override
  void initState() {
    this.student = widget.student;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: Container(
        height: 200,
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Center(child: Text(student.firstName,
                  style: TextStyle(
                      fontSize: (MediaQuery.of(context).orientation == Orientation.portrait)
                          ? MediaQuery.of(context).size.width/20
                          : MediaQuery.of(context).size.height/20
                  ),
                )),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: GestureDetector(
                  onTap: () {
                    /// add missing code here to acess settings of a student
                  },
                  child: Center(
                      child: Icon(Icons.settings, color: Colors.grey[500], size: 40.0,)
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.parent.removeStudent(student);
                    });
                  },
                  child: Center(
                      child: Icon(Icons.remove, color: Colors.red, size: 40.0)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
