import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ClassView.dart';
import 'models/Class.dart';

class ClasseCard extends StatefulWidget {
  final Class? classe;
  final bool? modifier;

  @override
  _ClasseCardState createState() => _ClasseCardState();

  const ClasseCard({Key? key, this.classe, this.modifier}) : super(key: key);
}

class _ClasseCardState extends State<ClasseCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.modifier!) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ClassView(selectedClass: widget.classe)));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ClassView(selectedClass: widget.classe)));
        }
      },
      child: Card(
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
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                      child: Text(
                    widget.classe!.name!,
                    style: TextStyle(
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
