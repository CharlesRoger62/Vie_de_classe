import 'package:flutter/material.dart';
import 'package:test_app_maumau/data/Data.dart';
import '../Classe_card.dart';

class ClassChoiceModifier extends StatefulWidget {
  @override
  _ClassChoiceModifierState createState() => _ClassChoiceModifierState();
}

class _ClassChoiceModifierState extends State<ClassChoiceModifier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choisir une classe")),
      body: Center(
        child: SizedBox(
          width: 800.0,
          height: 800.0,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemExtent: 80.0,
              itemCount: Data().classes.length,
              itemBuilder: (context, index) {
                return ClasseCard(classe: Data().classes[index],modifier: true);
              }
          ),
        ),
      ),
    );
  }
}
