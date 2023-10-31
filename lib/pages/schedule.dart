import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quiz_app/helpers/database.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:quiz_app/models/myschedules.dart';
import 'package:quiz_app/pages/add_schedulelist.dart';
import 'package:quiz_app/pages/landing_page.dart';
import 'package:quiz_app/pages/new_schedule.dart';
import 'package:quiz_app/providers/schedule_providers.dart';

class schedule extends ConsumerStatefulWidget {
  const schedule({super.key});

  @override
  ConsumerState<schedule> createState() => _scheduleState();
}

class _scheduleState extends ConsumerState<schedule> {
  late ScaffoldMessengerState scaffoldMessenger;

  // final List<mySchedules> _collections = [];
  //late SharedPreferences _prefs;
  void _overlay() {
    showModalBottomSheet(
      backgroundColor: Colors.grey[300],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return NewSchedule(addSchedule);
      },
    );
  }

  void addSchedule(mySchedules schedules) async {
    setState(() {
      //_collections.add(schedules);
      ref.read(scheduleStateProvider.notifier).addSchedule(schedules);
    });
  }

  /*void removeSchedule(mySchedules schedules) {
    //final scheduleIndex = _collections.indexOf(schedules);
    setState(() {
      ref.read(scheduleStateProvider.notifier).removeSchedule(schedules);

      // _collections.remove(schedules);
      scaffoldMessenger.clearSnackBars();
      scaffoldMessenger.showSnackBar(
        SnackBar(
          elevation: 5.0,
          duration: const Duration(milliseconds: 3000),
          margin: const EdgeInsets.all(20),
          dismissDirection: DismissDirection.horizontal,
          action: SnackBarAction(
            label: "Undo",
            textColor: Colors.grey,
            onPressed: () async {
              await MySchedulesDatabase.instance.insertSchedule(schedules);
              setState(() {
                // _collections.insert(scheduleIndex, schedules);
                ref.read(scheduleStateProvider.notifier).addSchedule(schedules);
              });
            },
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.blueGrey,
          content: const Text(
            "Deleted",
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    });
  }*/
  void removeSchedule(mySchedules schedules) async {
    try {
      ref.read(scheduleStateProvider.notifier).removeSchedule(schedules);

      await MySchedulesDatabase.instance.deleteSchedule(schedules.id);

      scaffoldMessenger.clearSnackBars();
      scaffoldMessenger.showSnackBar(
        SnackBar(
          elevation: 5.0,
          duration: const Duration(milliseconds: 3000),
          margin: const EdgeInsets.all(20),
          dismissDirection: DismissDirection.horizontal,
          action: SnackBarAction(
            label: "Undo",
            textColor: Colors.grey,
            onPressed: () async {
              await MySchedulesDatabase.instance.insertSchedule(schedules);

              ref.read(scheduleStateProvider.notifier).addSchedule(schedules);
            },
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.blueGrey,
          content: const Text(
            "Deleted",
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    } catch (error) {
      print("Error deleting schedule: $error");
      
    }
  }

  @override
  void initState() {
    super.initState();
    loadSchedules();
  }

  void loadSchedules() async {
    final dbHelper = MySchedulesDatabase.instance;
    final scheduless = await dbHelper.getAllSchedules();
    setState(() {
      ref.read(scheduleStateProvider.notifier).setSchedules(scheduless);
    });
  }

  @override
  Widget build(BuildContext context) {
    final schedules = ref.watch(scheduleStateProvider);

    Widget nonemptyCollections = SizedBox(
      height: 200,
      child: Center(
        child: texttwo("No Pick-Ups"),
      ),
    );

    if (schedules.isNotEmpty) {
      nonemptyCollections = AddSchedulesList(
          schedules: schedules, onRemoveSchedule: removeSchedule);
    }

    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatBot()),
          );
        },
        child: const Icon(
          Icons.message_rounded,
          color: Colors.grey,
        ),
      ),*/
      appBar: AppBar(
        elevation: 8.0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Landing()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
        ),
        centerTitle: true,
        title: scaffoldtext(
          "Schedule Pick-Ups",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heading(
                        DateFormat.yMMMMEEEEd().format(DateTime.now()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 9),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: double.infinity,
              child: const Text(
                "Today",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 9),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: DatePicker(
                DateTime.now(),
                height: 100,
                width: 70,
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.blueGrey,
                selectedTextColor: Colors.grey,
                dateTextStyle: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
                dayTextStyle: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
                monthTextStyle: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
                onDateChange: (date) {},
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                  //color: Colors.grey[300],
                  gradient: LinearGradient(
                    colors: [Colors.grey[400]!, Colors.grey[300]!],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: scheduletext(
                "Recycle your Electronic waste hassle-free! ♻️ Schedule a pickup today for a greener future! 🌍",
              ),
            ),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                height: 40,
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _overlay,
                  icon: const Icon(
                    Icons.add_circle_outline_rounded,
                    color: Colors.grey,
                  ),
                  label: mytext("Schedule"),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                )),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              height: 40,
              width: double.infinity,
              child: const Text(
                "Pick-Up History",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            nonemptyCollections,
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
