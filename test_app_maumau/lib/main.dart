import 'package:flutter/material.dart';
import 'package:test_app_maumau/dataModifierViews/MalusModifierView.dart';

import 'Classe_card.dart';
import 'data/Data.dart';
import 'dataModifierViews/BonusModifierView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vie de Classe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Data().instanciate(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choisir une classe :", textAlign: TextAlign.center),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Paramètres de \n Maureen Cordier',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Modifier mes classes  EN COURS'),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Vous ne savez pas lire !"),
                        content: Text(" C'EST ECRIT EN COURS"),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "J'arrête promis",
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              )),
                        ],
                      );
                    });
              },
            ),
            ListTile(
              title: Text('Modifier mes malus'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MalusModifierView()));
              },
            ),
            ListTile(
              title: Text('Modifier mes bonus'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BonusModifierView()));
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Text(Data().mode! ? "Mode Standard" : "Mode Particulier"),
                  SizedBox(width: 10.0),
                  Switch(
                    value: Data().mode!,
                    onChanged: (value) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Attention !"),
                              content: Text(
                                  "Vous allez changer de mode : toutes vos notes vont être réinitialisées !"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Annuler")),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        Data().changeMode();
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(" J'accepte !"))
                              ],
                            );
                          });
                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(Data().mode!
                    ? "  Le mode standard fait commencer les notes des élèves à 20 pour et place les moins bonnes notes en premier."
                    : "  Le mode particulier fait commencer les notes des élèves à 0 et place les meilleures notes en premier."))
          ],
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 800.0,
          height: 800.0,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemExtent: 80.0,
              itemCount: Data().classes.length,
              itemBuilder: (context, index) {
                return ClasseCard(
                    classe: Data().classes[index], modifier: false);
              }),
        ),
      ),
    );
  }
}
