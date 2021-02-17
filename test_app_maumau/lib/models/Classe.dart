import 'Student.dart';

class Classe {
  String name;
  List<Student> studentList;
  List<Student> firstGroup;
  List<Student> secondGroup;
  List<List<Student>> ilots;
  List<Student> studentsToPlace;

  Classe({
    this.name,
    this.studentList,
  });

  void setDemiGroups() {
    int effectif = studentList.length;
    firstGroup = List();
    secondGroup = List();

    for(int i=0; i<effectif; i++){
      if(i<effectif/2) firstGroup.add(studentList[i]);
      else secondGroup.add(studentList[i]);
    }
  }

  void initiateIlots(){
    ilots = List();
    studentsToPlace = List();
    for(Student s in studentList){
      studentsToPlace.add(s);
    }
  }

  void cancelIlots() {
    ilots = null;
    studentsToPlace = null;
  }

  void createAnIlot(List<Student> myIlot){
    ilots.add(myIlot);
    for(Student student in myIlot) {
      studentsToPlace.remove(student);
    }
  }
}
