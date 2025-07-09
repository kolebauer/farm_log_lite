//import 'dart:convert';

class Log {
  final int? id;  //auto-increment
  final String field;
  final String crop;
  final String activity;
  final String date;

  Log({
    this.id,
    required this.field,
    required this.crop,
    required this.activity,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'field': field,
      'crop': crop,
      'activity': activity,
      'date': date,
    };
  }

  @override
  String toString() {
    return 'Log{id: $id, field: $field, crop: $crop, activity: $activity, date: $date}';
  }
}
