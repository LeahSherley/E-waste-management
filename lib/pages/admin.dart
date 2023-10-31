import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:quiz_app/pages/admindrawer.dart';
import 'package:quiz_app/pages/scheduleitems.dart';
import 'package:quiz_app/providers/pickupsprovider.dart';
import 'package:quiz_app/providers/schedule_providers.dart';

class AdminScreen extends ConsumerStatefulWidget {
  const AdminScreen({super.key});

  @override
  ConsumerState<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends ConsumerState<AdminScreen> {
  //int deletedPickups = 0;
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final Prefs _prefs = Prefs();
  String? user;
  late ScaffoldMessengerState scaffoldMessenger;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    ref.read(scheduleStateProvider.notifier).fetchPickUps().then((value) => setState((){
      isLoading = false;
    }));
  }

  @override
  Widget build(BuildContext context) {
    final completedPickups = ref.watch(completedPickupsProvider);
    _prefs.getStringValuesSF("username").then((username) => {
          setState(() {
            user = username;
          })
        });
    final schedules = ref.watch(scheduleStateProvider);
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: scaffoldtext('Dashboard'),
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(
              Icons.account_circle_rounded,
              size: 30,
              color: Colors.blueGrey,
            ),
            onPressed: () {
              if (scaffoldkey.currentState!.isDrawerOpen) {
                scaffoldkey.currentState!.closeDrawer();
              } else {
                scaffoldkey.currentState!.openDrawer();
              }
            }),
      ),
      drawer: const adminDrawer(),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 24, top: 15),
            width: double.infinity,
            child: Row(
              children: [
                Text(
                  "Hello, $user!",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 10),
            width: double.infinity,
            child: const Text(
              'Statistics',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 10),
            padding: const EdgeInsets.all(16.0),
            child: PieChart(
              ringStrokeWidth: 18,
              animationDuration: const Duration(milliseconds: 1200),
              dataMap: {
                'Pending': schedules.length.toDouble() - 2,
                'Completed': completedPickups.toDouble(),
                //deletedPickups.toDouble(),
              },
              colorList: const [
                Colors.blueGrey,
                Colors.grey,
              ], 
              chartRadius: MediaQuery.of(context).size.width,
              chartType: ChartType.ring,
              centerText: 'Scheduled PickUps',
              legendOptions: const LegendOptions(
                legendPosition: LegendPosition.bottom,
                showLegendsInRow: true,
                legendTextStyle: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
             
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 10),
            width: double.infinity,
            child: const Text(
              'Scheduled PickUps',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          isLoading
              ? const SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  ),
                )
                :schedules.isEmpty
                ? SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Center(
                    child: texttwo("No Pending Pick-Ups")
                  ),
                )
              : ListView.builder(
                reverse:true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: schedules.length,
                  itemBuilder: (context, index) {
                    final schedule = schedules[index];
                    return Dismissible(
                      key: Key(schedule.id),
                      onDismissed: (direction) {
                        ref
                            .read(scheduleStateProvider.notifier)
                            .removeSchedule(schedule);
                        setState(() {
                          ref
                              .read(completedPickupsProvider.notifier)
                              .increment();
                          //deletedPickups++;
                        });
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
                              onPressed: () {
                                setState(() {
                                  // _collections.insert(scheduleIndex, schedules);
                                  ref
                                      .read(scheduleStateProvider.notifier)
                                      .addSchedule(schedule);
                                });
                              },
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.blueGrey,
                            content: const Text(
                              "Completed",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                      child: ScheduleItems(schedules: schedule),
                    );
                  },
                ),
          const SizedBox(
            height: 12,
          ),
        ]),
      ),
    );
  }
}
