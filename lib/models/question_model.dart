
import 'package:hive/hive.dart';
part 'question_model.g.dart';

@HiveType(typeId: 0)
class Question extends HiveObject {

  @HiveField(0)
  String question;
  @HiveField(1)
  String option1;
  @HiveField(2)
  String option2;
  @HiveField(3)
  String option3;
  @HiveField(4)
  String option4;

  Question({required this.question,required this.option1, required this.option2, required this.option3, required this.option4});

}

