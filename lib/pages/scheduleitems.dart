import 'package:flutter/material.dart';

import 'package:quiz_app/models/myschedules.dart';
import 'package:quiz_app/myWidgets.dart';

class ScheduleItems extends StatefulWidget {
  const ScheduleItems({super.key, required this.schedules});
  final mySchedules schedules;

  @override
  State<ScheduleItems> createState() => _ScheduleItemsState();
}

class _ScheduleItemsState extends State<ScheduleItems> {
  String? user;
  final Prefs _prefs = Prefs();

  @override
  Widget build(BuildContext context) {
    _prefs.getStringValuesSF("username").then((username) => {
          setState(() {
            user = username;
          })
        });
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 1.0,
      color: Colors.grey[300],
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Electronic:",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
                Text(
                  widget.schedules.title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Address: ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
                Text(
                  widget.schedules.address,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Number:",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
                Text(
                  widget.schedules.number,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Date:",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
                Text(
                  widget.schedules.dateformatted,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Time:",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11.5,
                  ),
                ),
                Text(
                  widget.schedules.timeformatted,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // widget.schedules.isPicked = true?
                const Icon(
                  Icons.schedule_rounded,
                  color: Colors.blueGrey,
                  size: 18,
                ),

                const SizedBox(
                  width: 5,
                ),
                Text(
                  DateTime.parse(widget.schedules.dateformatted)
                          .isBefore(DateTime.now())
                      ? "Completed"
                      : "Pending",
                  style: TextStyle(
                      color: DateTime.parse(widget.schedules.dateformatted)
                              .isBefore(DateTime.now())
                          ? Colors.blueGrey
                          : Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                /* Text(
                  "Pending",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),*/
              ],
            ),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.schedule_rounded,
                  color: widget.schedules.date.isBefore(DateTime.now())
                      ? Colors.blueGrey 
                      : Colors.red, 
                  size: 18,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.schedules.date.isBefore(DateTime.now())
                      ? "Completed"
                      : "Pending",
                  style: TextStyle(
                      color: widget.schedules.date.isBefore(DateTime.now())
                          ? Colors.blueGrey 
                          : Colors.red, 
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
