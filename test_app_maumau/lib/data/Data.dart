import 'dart:collection';

import 'package:test_app_maumau/models/Bonus.dart';
import 'package:test_app_maumau/models/Classe.dart';
import 'package:test_app_maumau/models/Malus.dart';
import 'package:test_app_maumau/models/Student.dart';

class Data {
  static final Data _singleton = Data._internal();
  List<Malus> malusList;
  List<Bonus> bonusList;
  List<Classe> classes;
  List<Student> studentList;
  bool mode; /// if mode is true, standard mode with 20 start grade and sort is croissant else start grade is 0 and sort is decroissant

  factory Data(){
    return _singleton;
  }

  Data._internal();

  void instanciate(bool mode) {
    malusList = List();
    bonusList = List();
    classes = List();
    studentList = List();

    this.mode = mode;

    Malus malus1 = new Malus("Chewing gum", -2.0);
    Malus malus2 = Malus("Se lève sans autorisation",-2.0);
    Malus malus3 = Malus("Bavardage",-1);
    Malus malus4 = Malus("Lance du matériel",-3.0);

    malusList.addAll({malus1,malus2,malus3,malus4});
    malusList.sort((a,b) => b.value.compareTo(a.value));

    Bonus bonus1 = Bonus("Correction exercice", 2.0);
    Bonus bonus2 = Bonus("Fayotage",2.0);
    Bonus bonus3 = Bonus("Participation",1);
    Bonus bonus4 = Bonus("Billet de 10 EUROS",3.0);

    bonusList.addAll({bonus1,bonus2,bonus3,bonus4});
    bonusList.sort((a,b) => a.value.compareTo(b.value));

    double grade;

    if(mode) grade = 20.0;
    else grade = 0.0;

    Student student1 = Student(firstName:"Jean",name:"testName",grade: grade);
    Student student2 = Student(firstName:"Wilfried",name:"testName",grade: grade);
    Student student3 = Student(firstName:"Paul",name:"testName",grade: grade);
    Student student4 = Student(firstName:"George",name:"testName",grade: grade);
    Student student5 = Student(firstName:"Camille",name:"testName",grade: grade);
    Student student6 = Student(firstName:"John",name:"testName",grade: grade);
    Student student7 = Student(firstName:"Nouamane",name:"testName",grade: grade);
    Student student8 = Student(firstName:"Charles",name:"testName",grade: grade);
    Student student9 = Student(firstName:"Christopher",name:"testName",grade: grade);
    Student student10 = Student(firstName:"Kevin",name:"testName",grade: grade);
    Student student11 = Student(firstName:"Abdoul",name:"testName",grade: grade);
    Student student12 = Student(firstName:"Merveille",name:"testName",grade: grade);
    Student student13 = Student(firstName:"Boris",name :"testName",grade: grade);
    Student student14 = Student(firstName:"Gabriel",name:"testName",grade: grade);
    Student student15 = Student(firstName:"Mira",name:"testName",grade: grade);
    Student student16 = Student(firstName:"Constance",name:"testName",grade: grade);
    Student student17 = Student(firstName: "Patrick", name:"testName", grade: grade);

    studentList.addAll({student1, student2, student3, student4, student5, student6, student7, student8, student9, student10,
      student11, student12, student13, student14, student15, student16, student17});

    studentList.sort((a,b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    Classe classe1 = new Classe(name: "5C");
    Classe classe2 = new Classe(name: "6A");
    Classe classe3 = new Classe(name: "3D");

    classe1.studentList = List();
    classe2.studentList = List();
    classe3.studentList = List();

    for(Student s in studentList) {
      classe1.studentList.add(s);
      classe2.studentList.add(s);
      classe3.studentList.add(s);
    }

    classes.addAll({classe1, classe2, classe3});
  }

  sortMalusOrBonusList(bool isMalus) {
    if(isMalus){
      malusList.sort((a,b) => b.value.compareTo(a.value));
    } else {
      bonusList.sort((a,b) => b.value.compareTo(a.value));
    }
  }

  applychangesFromIlotActivity(HashMap<List<Student>,double> groupGrades, Classe classe) {
    for(List<Student> ilot in groupGrades.keys) {
      for(Student student in ilot){
        student.grade += groupGrades[ilot];
        if(student.grade > 20) student.grade = 20;
      }
    }

    classe.studentList.sort((a,b) => b.grade.compareTo(a.grade));
  }

  changeMode() {
    mode = !mode;
    for(Classe c in classes) {
      for(Student s in c.studentList) {
        if(mode) s.grade = 20.0;
        else s.grade = 0.0;
      }
    }
  }
}