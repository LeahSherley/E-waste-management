import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:quiz_app/helpers/database.dart';
import 'package:quiz_app/models/myschedules.dart';
import 'package:quiz_app/models/notifications.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:http/http.dart' as http;

class NewSchedule extends ConsumerStatefulWidget {
  const NewSchedule(this.onAddSchedule, {super.key});

  final void Function(mySchedules schedules) onAddSchedule;

  @override
  ConsumerState<NewSchedule> createState() => _NewScheduleState();
}

class _NewScheduleState extends ConsumerState<NewSchedule> {
  TextEditingController titleController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  DateTime? _selecteddate;

  TimeOfDay? _selectedtime;
  late String lat;
  late String long;
  String data = "Address";
  late String newText = '';
  late ScaffoldMessengerState scaffoldMessenger;
  final Prefs _prefs = Prefs();
  String? user;

  List <String> electronicItems = [
    "Refridgerator",
    "Television",
    "Printers",
    "Computers",
    "Laptops",
    "Washing Machine",
    "Vending Machine",
    "Electronic Cookers",
    "Water Dispenser",
    "IT Equipment",
    "Microwave Oven"
  ];
  String? selectedElectronicItem;

  

  void _scheduleTimePicker() async {
    final timeSelected = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (BuildContext context, Widget? child) {
        return Column(
          children: <Widget>[
            const SizedBox(height: 16),
            child!,
          ],
        );
      },
    );

    
    if (timeSelected != null) {
      if (_isTimeBlocked(timeSelected)) {
        // ignore: use_build_context_synchronously
        QuickAlert.show(
            width: double.infinity,
            context: context,
            type: QuickAlertType.warning,
            text: 'Please note that all Pick-Ups are done between 9AM and 4PM',
            titleColor: Colors.grey,
            confirmBtnColor: Colors.blueGrey,
            textColor: Colors.grey,
            borderRadius: 20,
            confirmBtnTextStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 11.5,
            ));
      } else {
        setState(() {
          _selectedtime = timeSelected;
        });
      }
    }
  }

  bool _isTimeBlocked(TimeOfDay time) {
    if (time.hour < 10 || time.hour > 14) {
      return true;
    }
    return false;
  }

  void _scheduleDatePicker() async {
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    final dateSelected = await showDatePicker(
        context: context,
        initialDate: tomorrow,
        firstDate: tomorrow,
        lastDate: DateTime.utc(2025));

    setState(() {
      _selecteddate = dateSelected;
    });
  }

  Future <Position> currentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    //print(placemark);
    newText = '${place.street}, ${place.locality}';
  }

  void newschedule() async {
    if (selectedElectronicItem == null ||
        addressController.text.isEmpty ||
        numberController.text.isEmpty ||
        _selecteddate == null ||
        _selectedtime == null) {
      warning(context);
    } else {
      final dbHelper = MySchedulesDatabase.instance;
      final mySchedule = mySchedules(
        title: selectedElectronicItem!,
        address: addressController.text,
        number: numberController.text,
        date: _selecteddate!,
        time: _selectedtime!,
      );
      await dbHelper.insertSchedule(mySchedule);
      
      schedule(selectedElectronicItem!, _selecteddate!, numberController.text,
          addressController.text, _selectedtime!);
    }
    

    widget.onAddSchedule(
      mySchedules(
        title: selectedElectronicItem!,
        address: addressController.text,
        number: numberController.text,
        date: _selecteddate!,
        time: _selectedtime!,
      ),
    );
    //final notifications = ref.watch(notificationsProvider);

    Notifications().showNotification(
      title: "Scheduled Pickup",
      body:
          "Dear $user,\nWe're excited to inform you that your electronic waste pickup has been successfully scheduled! Thank you for taking the important step towards responsible disposal of your electronic items. Here are the details of your pickup:\nElectronic: $selectedElectronicItem\nDate: $_selecteddate\nLocation: ${addressController.text}\nTime:${numberController.text}",
      payload:
          "Scheduled Pickup\n\nDear $user,\nWe're excited to inform you that your electronic waste pickup has been successfully scheduled! Thank you for taking the important step towards responsible disposal of your electronic items. Here are the details of your pickup:\n\nElectronic: $selectedElectronicItem\n\nDate: $_selecteddate\n\nLocation: ${addressController.text}\n\nNumber: ${numberController.text}\n\n One of our team will call you soon!",
    );
    

    Navigator.pop(context);
    success(context);
    /* _prefs.addStringToSF("title", selectedElectronicItem!);
    _prefs.addStringToSF("address", addressController.text);
    _prefs.addStringToSF("number", numberController.text);
    _prefs.addDate(_selecteddate!);*/
    
  }

  void warning(BuildContext context) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: "Please Provide All Information to Proceed",
        titleColor: Colors.grey,
        confirmBtnColor: Colors.blueGrey,
        textColor: Colors.grey,
        borderRadius: 20,
        confirmBtnTextStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 11.5,
        ));
  }

  void success(BuildContext context) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: "Schedule Successful",
        titleColor: Colors.grey,
        confirmBtnColor: Colors.blueGrey,
        textColor: Colors.grey,
        borderRadius: 20,
        confirmBtnTextStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 11.5,
        ));
  }

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    String hour = timeOfDay.hour.toString().padLeft(2, '0');
    String minute = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$minute:00';
  }

  schedule(
    String title,
    DateTime date,
    String number,
    String address,
    TimeOfDay time,
  ) async {
    /* showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));*/

    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = dateFormat.format(date);
    //String formattedTime = formatTimeOfDay(time);
    String formattedTime =
        _selectedtime != null ? formatTimeOfDay(_selectedtime!) : '';

    Map data = {
      "title": title,
      "date": formattedDate,
      "number": number,
      "address": address,
      "time": formattedTime,
      "user": user,
    };
    //print("Sending data to sever: $data");

    var response = await http.post(
        Uri.parse("https://randiki.000webhostapp.com/eschedule.php"),
        body: data);
    //print("Server Response: ${response.body}");
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        /* setState(() {
          Navigator.pop(context);
        });*/
        int isRegistered = jsonResponse['code'];
        if (isRegistered == 1) {
        } else {}
      }
    } else {
      setState(() {
        // Navigator.pop(context);
      });
    }
  }

  @override
  void dispose() {
    /* _prefs.addStringToSF("title", titleController.text);
    _prefs.addStringToSF("address", addressController.text);
    _prefs.addStringToSF("number", numberController.text);
    _prefs.addDate(_selecteddate!);*/

    titleController.dispose();
    addressController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _prefs.getStringValuesSF("username").then((username) => {
          setState(() {
            user = username;
          })
        });
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 50, 18, 18),
      child: Column(
        children: [
          const Text(
            "New Schedule",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 11,
          ),
          Container(
            margin: const EdgeInsets.only(right: 18, left: 18),
            width: double.infinity,
            height: 45,
            child: DropdownButtonFormField<String>(
              value: selectedElectronicItem,
              onChanged: (newValue) {
                setState(() {
                  selectedElectronicItem = newValue;
                });
              },
              items: electronicItems.map((item) {
                return DropdownMenuItem<String>(
                  alignment: Alignment.center,
                  value: item,
                  child: mytext(item),
                );
              }).toList(),
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.computer,
                  size: 20,
                ),
                hintText: "Electronic",
                hintStyle: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Colors.transparent,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blueGrey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(right: 18, left: 18),
            width: double.infinity,
            height: 45,
            child: TextField(
              onTap: _scheduleDatePicker,
              readOnly: true,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: () {
                    _scheduleDatePicker();
                  },
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                    size: 20,
                  ),
                ),
                hintText: _selecteddate == null
                    ? 'Date'
                    : dateformat.format(_selecteddate!),
                hintStyle: const TextStyle(fontSize: 10, color: Colors.grey),
                filled: true,
                fillColor: Colors.transparent,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blueGrey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(right: 18, left: 18),
            width: double.infinity,
            height: 45,
            child: TextField(
              readOnly: true,
              onTap: _scheduleTimePicker,
              controller: timeController,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: _scheduleTimePicker,
                  icon: const Icon(
                    Icons.access_time,
                    size: 20,
                  ),
                ),
                hintText: _selectedtime == null
                    ? 'Time'
                    : formatTimeOfDay(_selectedtime!),
                hintStyle: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Colors.transparent,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blueGrey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(right: 18, left: 18),
            width: double.infinity,
            height: 45,
            child: TextField(
              maxLength: 10,
              controller: numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                counterText: '',
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.call_rounded,
                    size: 20,
                  ),
                ),
                hintText: 'Number (e.g 07xx xxx xxx)',
                hintStyle: const TextStyle(fontSize: 10, color: Colors.grey),
                filled: true,
                fillColor: Colors.transparent,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blueGrey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(right: 18, left: 18),
            width: double.infinity,
            height: 45,
            child: TextField(
              readOnly: true,
              onTap: () async {},
              controller: addressController,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.location_pin,
                    size: 20,
                  ),
                ),
                hintText: 'Address',
                hintStyle: const TextStyle(fontSize: 10, color: Colors.grey),
                filled: true,
                fillColor: Colors.transparent,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blueGrey),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: locationtext2(
                "Tap on the button below to fetch current address\nThis will be the address used for pickup."),
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*Container(
                width: 284,
                height: 40,
                margin: const EdgeInsets.only(left: 20, right:20),
                child: MaterialButton(
                  /*padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),*/
                  
                  color: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) =>
                            const Center(child: CircularProgressIndicator()));
                    Position position = await currentPosition();
                    getAddressFromLatLong(position);
                    setState(() {});
              
                    final updatedText = addressController.text + newText;
                    addressController.value = addressController.value.copyWith(
                      text: updatedText,
                      selection:
                          TextSelection.collapsed(offset: updatedText.length),
                    );
                    
                    Navigator.pop(context);
                  },
                  child: const Text("Get Address",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11.5,
                      )),
                ),
              )*/
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                height: 40,
                width: 284,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) =>
                            const Center(child: CircularProgressIndicator()));
                    Position position = await currentPosition();
                    getAddressFromLatLong(position);
                    setState(() {});

                    final updatedText = addressController.text + newText;
                    addressController.value = addressController.value.copyWith(
                      text: updatedText,
                      selection:
                          TextSelection.collapsed(offset: updatedText.length),
                    );

                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.location_on,
                    color: Colors.grey,
                    size: 20,
                  ),
                  label: const Text("Get Address",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      )),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                elevation: 0,
                padding: const EdgeInsets.only(right: 30, left: 30),
                height: 40,
                color: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: newschedule,
                child: const Text("Proceed",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11.5,
                    )),
              ),
              const SizedBox(width: 12),
              MaterialButton(
                elevation: 0,
                padding: const EdgeInsets.only(right: 30, left: 30),
                height: 40,
                color: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(" Cancel ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11.5,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
