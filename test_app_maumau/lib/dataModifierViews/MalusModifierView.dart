import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app_maumau/data/Data.dart';
import 'package:test_app_maumau/dataModifierViews/AddingMalusDialog.dart';
import 'package:test_app_maumau/models/Malus.dart';

class MalusModifierView extends StatefulWidget {
  @override
  _MalusModifierViewState createState() => _MalusModifierViewState();
}

class _MalusModifierViewState extends State<MalusModifierView> {
  List<Malus> malusList;

  @override
  void initState() {
    malusList = Data().malusList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("modifier mes malus")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 800.0,
                height: malusList.length*100-50.0,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemExtent: 80.0,
                    itemCount: malusList.length,
                    itemBuilder: (context, index) {
                      return MalusModifierCard(malusList[index]);
                    }
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 100.0),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                    builder: (BuildContext) {
                        return AddingMalusDialog();
                      }
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.add, color: Colors.green),
                      SizedBox(width: 5.0),
                      Text("Ajouter un malus", style: TextStyle( fontSize: 20.0))
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

  Widget MalusModifierCard(Malus malus) {
    return Card(
      shadowColor: Colors.black,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: Container(
        height: 200,
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Center(child: Text(malus.name,
                style: TextStyle(
                    fontSize: (MediaQuery.of(context).orientation == Orientation.portrait)
                        ? MediaQuery.of(context).size.width/20
                        : MediaQuery.of(context).size.height/20
                ),
              )),
              Row(
                children: <Widget>[
                  Center(child: Text(malus.value.toString(),
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: (MediaQuery.of(context).orientation == Orientation.portrait)
                            ? MediaQuery.of(context).size.width/20
                            : MediaQuery.of(context).size.height/20
                    ),
                  )),
                  SizedBox(width: 20.0),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        malusList.remove(malus);
                      });
                    },
                      child: Icon(
                        Icons.close, color: Colors.red, size: 30.0,)
                  ),
                  SizedBox(width: 5.0)
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}
