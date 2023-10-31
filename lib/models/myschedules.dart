import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final dateformat = DateFormat.yMd();
final timeformat = DateFormat('HH:mm:ss');

class mySchedules {
  mySchedules({
    required this.title,
    required this.date,
    required this.time,
    required this.address,
    required this.number,
    this.isPicked = false,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final DateTime date;
  final TimeOfDay time;
  final String address;
  final String number;
  bool isPicked;

  String get dateformatted {
    return dateformat.format(date);
  }

  String get timeformatted {
    return formatTimeOfDay(time);
  }

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    String hour = timeOfDay.hour.toString().padLeft(2, '0');
    String minute = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$minute:00';
  }

  factory mySchedules.fromJson(Map<String, dynamic> json) {
  final dateFormat = DateFormat('yyyy-MM-dd');
  final timeFormat = DateFormat('HH:mm:ss.SSSSSS');

  return mySchedules(
    title: json['title'],
    date: dateFormat.parse(json['date']),
    number: json['number'],
    address: json['address'],
    time: TimeOfDay.fromDateTime(timeFormat.parse(json['time'])),
   
  );
}

Map<String, dynamic> toMap() {
  return {
    'title': title,
    'date': dateformatted,
    'time': timeformatted,
    'address': address,
    'number': number,
    'isPicked': isPicked ? 1 : 0,
  };
}

factory mySchedules.fromMap(Map<String, dynamic> map) {
  return mySchedules(
    title: map['title'],
    date: dateformat.parse(map['date']),
    number: map['number'],
    address: map['address'],
    time: TimeOfDay.fromDateTime(
      DateFormat('HH:mm:ss').parse(map['time']),
    ),
    isPicked: map['isPicked'] == 1,
  );
}

}
