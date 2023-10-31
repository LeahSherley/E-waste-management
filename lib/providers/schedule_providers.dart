import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/models/myschedules.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScheduleStateNotifier extends StateNotifier<List<mySchedules>> {
  ScheduleStateNotifier() : super([]);

  void addSchedule(mySchedules schedules) {
    if (!state.contains(schedules)) {
      state = [...state, schedules];
    }
  }

  void removeSchedule(mySchedules schedules) {
    if (state.contains(schedules)) {
      state = state.where((s) => s.id != schedules.id).toList();
    }
  }
  void setSchedules(List<mySchedules> newSchedules) {
    state = newSchedules;
  }
  Future <void> fetchPickUps() async {
    final response = await http
        .get(Uri.parse('https://randiki.000webhostapp.com/fetchpickup.php'));

    if (response.statusCode == 200) {
      final jsonData =  json.decode(response.body);
      final List<mySchedules> schedules = (jsonData as List)
          .map((item) => mySchedules.fromJson(item))
          .toList();
           state = schedules;
      
    } else {
      throw Exception('Failed to load pickups');
    }
  }
}


final scheduleStateProvider =
    StateNotifierProvider<ScheduleStateNotifier, List<mySchedules>>(
  (ref) => ScheduleStateNotifier(),
);


