import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app_maumau/data/Data.dart';
import 'package:test_app_maumau/dataModifierViews/AddingBonusDialog.dart';
import 'package:test_app_maumau/models/Bonus.dart';

class BonusModifierView extends StatefulWidget {
  @override
  _BonusModifierViewState createState() => _BonusModifierViewState();
}

class _BonusModifierViewState extends State<BonusModifierView> {
  List<Bonus>? bonusList;

  @override
  void initState() {
    bonusList = Data().bonusList;
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
                height: bonusList!.length * 100 - 50.0,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemExtent: 80.0,
                    itemCount: bonusList!.length,
                    itemBuilder: (context, index) {
                      return malusModifierCard(bonusList![index]);
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(left: 100.0),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddingBonusDialog();
                        });
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.add, color: Colors.green),
                      SizedBox(width: 5.0),
                      Text("Ajouter un bonus", style: TextStyle(fontSize: 20.0))
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

  Widget malusModifierCard(Bonus bonus) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Center(
                    child: Text(
                  bonus.name,
                  style: TextStyle(
                      fontSize: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? MediaQuery.of(context).size.width / 20
                          : MediaQuery.of(context).size.height / 20),
                )),
                Row(
                  children: <Widget>[
                    Center(
                        child: Text(
                      bonus.value.toString(),
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: (MediaQuery.of(context).orientation ==
                                  Orientation.portrait)
                              ? MediaQuery.of(context).size.width / 20
                              : MediaQuery.of(context).size.height / 20),
                    )),
                    SizedBox(width: 20.0),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            bonusList!.remove(bonus);
                          });
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 30.0,
                        )),
                    SizedBox(width: 5.0)
                  ],
                )
              ],
            )),
      ),
    );
  }
}
