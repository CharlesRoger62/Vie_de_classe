import 'Student.dart';

class Class {
  String? name;
  List<Student>? studentList;
  late List<Student> firstGroup;
  late List<Student> secondGroup;
  List<List<Student?>>? ilots;
  List<Student>? studentsToPlace;

  Class({
    this.name,
    this.studentList,
  });

  void setDemiGroups() {
    int effectif = studentList!.length;
    firstGroup = <Student>[];
    secondGroup = <Student>[];

    for (int i = 0; i < effectif; i++) {
      if (i < effectif / 2)
        firstGroup.add(studentList![i]);
      else
        secondGroup.add(studentList![i]);
    }
  }

  void initiateIlots() {
    ilots = <List<Student>>[];
    studentsToPlace = <Student>[];
    for (Student s in studentList!) {
      studentsToPlace!.add(s);
    }
  }

  void cancelIlots() {
    ilots = null;
    studentsToPlace = null;
  }

  void createAnIlot(List<Student?> myIlot) {
    ilots!.add(myIlot);
    for (Student? student in myIlot) {
      studentsToPlace!.remove(student);
    }
  }
}
