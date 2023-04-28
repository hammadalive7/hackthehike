

import 'package:hackthehike/models/question_model.dart';
import 'package:hive/hive.dart';

class Boxes{
  static Box<Question> getBoxes() => Hive.box<Question>('quest');
}