// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ShiftModel {
  final String date;
  final String id;
  final String title;
  final String period;
  ShiftModel({
    required this.date,
    required this.id,
    required this.period,
    required this.title,
  });

  ShiftModel copyWith({
    String? date,
    String? id,
    String? period,
    String? title,
  }) {
    return ShiftModel(
      date: date ?? this.date,
      id: id ?? this.id,
      title: title ?? this.title,
      period: period ?? this.period,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'id': id,
      'title': title,
      'period': period,
    };
  }

  factory ShiftModel.fromMap(Map<String, dynamic> map) {
    return ShiftModel(
      date: map['date'] as String,
      id: map['id'] as String,
      title: map['title'] as String,
      period: map["period"] == null ? "" : map["period"] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShiftModel.fromJson(String source) => ShiftModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ShiftModel(date: $date, id: $id, title: $title)';

  @override
  bool operator ==(covariant ShiftModel other) {
    if (identical(this, other)) return true;

    return other.date == date && other.id == id && other.title == title;
  }

  @override
  int get hashCode => date.hashCode ^ id.hashCode ^ title.hashCode;
}
