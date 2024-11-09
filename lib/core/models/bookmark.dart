import 'package:hive/hive.dart';

part 'bookmark.g.dart';

@HiveType(typeId: 1) // Make sure to assign a unique typeId
class Bookmark extends HiveObject {
  @HiveField(0)
  final String questionText;

  @HiveField(1)
  final String answer;

  Bookmark({
    required this.questionText,
    required this.answer,
  });
}
