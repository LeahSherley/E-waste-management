import 'package:flutter/material.dart';
import 'package:quiz_app/helpers/database.dart';
import 'package:quiz_app/models/myschedules.dart';
import 'package:quiz_app/pages/scheduleitems.dart';

class AddSchedulesList extends StatelessWidget {
  const AddSchedulesList(
      {super.key, required this.schedules, required this.onRemoveSchedule});

  final List<mySchedules> schedules;
  final void Function(mySchedules schedules) onRemoveSchedule;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        reverse: true,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          return Dismissible(
              key: ValueKey(schedules[index]),
              onDismissed: (direction) {
                onRemoveSchedule(schedules[index]);
              },
              child: ScheduleItems(schedules: schedules[index]));
        });
  }
}
