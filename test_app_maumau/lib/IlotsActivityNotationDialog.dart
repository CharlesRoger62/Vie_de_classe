import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'IlotsActivity.dart';
import 'models/Student.dart';

class IlotsActivityNotationDialog extends StatefulWidget {
  final int indexIlot;
  final List<Student> ilot;
  final IlotsActivityState parent;

  IlotsActivityNotationDialog({Key key, this.indexIlot, this.ilot, this.parent}) : super(key : key);

  @override
  _IlotsActivityNotationDialogState createState() => _IlotsActivityNotationDialogState();
}

class _IlotsActivityNotationDialogState extends State<IlotsActivityNotationDialog> {
  List<int> noteList = [0,1,2,3,4,5];
  int selectedNote;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Noter le groupe ${widget.indexIlot.toString()}"),
      content: SizedBox(
        width: 800.0,
        height: 100.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemExtent: 60.0,
            itemCount: noteList.length,
            itemBuilder: (context, index) {
              return NoteCard(index);
            }
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
              if(selectedNote != null){
                widget.parent.addGradeToIlot(widget.ilot, selectedNote.toDouble());
                Navigator.of(context).pop();
              }
            },
            child: Text("Valider",
              style: TextStyle(
                color: selectedNote != null ? Colors.green : Colors.grey,
              ),
            )
        ),
      ],
    );
  }

  Widget NoteCard(int index){
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedNote = index;
        });
      },
      child: Card(
        shadowColor: Colors.black,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 3.0,
              color: selectedNote == index ? Colors.blue : Colors.white,
            ),
            borderRadius: BorderRadius.circular(10.0)
        ),
        child: Container(
          height: 100,
          width: 100,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Center(child: Text(index.toString(),
                    style: TextStyle(
                        fontSize: (MediaQuery.of(context).orientation == Orientation.portrait)
                            ? MediaQuery.of(context).size.width/20
                            : MediaQuery.of(context).size.height/20
                    ),
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
