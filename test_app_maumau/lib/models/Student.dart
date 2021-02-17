import 'Bonus.dart';
import 'Malus.dart';

class Student {
  String firstName;
  String name;
  double grade;
  List<Malus> malusList;
  List<Bonus> bonusList;

  Student({
    this.firstName,
    this.name,
    this.grade = 20,
    this.malusList,
    this.bonusList
  });


}