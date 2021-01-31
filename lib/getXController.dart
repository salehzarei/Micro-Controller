import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:omidsystem/dataModel.dart';
import 'package:omidsystem/settingPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settingPage.dart';

class SliderController extends GetxController {
  final settings = <String>[].obs;
  final deviceIp = '192.168.4.1'.obs;
  final deviceport = 1010.obs;
  final movieCommand = 'mode1'.obs;
  final timeLapseCommand = 'mode2'.obs;
  final stopMotionCommand = 'mode3'.obs;

  final TextEditingController ipAddress = TextEditingController();
  final TextEditingController port = TextEditingController();
  final TextEditingController moviec = TextEditingController();
  final TextEditingController timel = TextEditingController();
  final TextEditingController stopm = TextEditingController();

  final sliderSpeed = 0.0.obs;
  final sliderDirection = 'off'.obs;
  final movieBtnValue = true.obs;
  final timeLapsBtnValue = false.obs;
  final stopMotionBtnValue = false.obs;
  final shoterCount = '0000'.obs;
  final intervalTime = '00:00'.obs;
  final selectedIntevalTime = '00:00'.obs;
  final startBtnStatus = false.obs;
  final batteryLevel = 70.obs;

  final TextEditingController shoterCounter = TextEditingController();
  final MaskedTextController intervalCounter =
      MaskedTextController(mask: '00:00');
  final reciveData = ''.obs;
  var deviceData = DataModel().obs;

  Socket _socket;

  @override
  void onInit() {
    loadSettingData().whenComplete(() => connectToDevice());

    super.onInit();
    print("Run onInit");
  }

  // void connect() async {
  //   Socket.connect(deviceIp.value, deviceport.value).then((Socket sock) {
  //     _socket = sock;
  //     _socket.listen(dataHandler,
  //         onDone: doneHandler, onError: errorHandler, cancelOnError: false);
  //   }).catchError((AsyncError e) {
  //     print("Unable to connect: $e");
  //   });
  //   //Connect standard in to the socket
  //   stdin.listen(
  //       (data) => _socket.write(new String.fromCharCodes(data).trim() + '\n'));
  // }

  // void dataHandler(data) {
  //   print(new String.fromCharCodes(data).trim());
  // }

  // void doneHandler() {
  //   _socket.destroy();
  // }

  // void errorHandler(error, StackTrace trace) {
  //   print(error);
  // }

  void connectToDevice() async {
    Socket.connect(deviceIp.value, deviceport.value,
            timeout: Duration(milliseconds: 1000))
        .then((soket) {
      _socket = soket;
      Get.snackbar("Connected",
          "Device Connected to ${deviceIp.value}:${deviceport.value.toString()}",
          colorText: Colors.white,
          duration: Duration(milliseconds: 3000),
          snackPosition: SnackPosition.BOTTOM);

      _socket.listen(
        (onData) {
          reciveData(String.fromCharCodes(onData).trim());
          deviceData(DataModel.fromJson(json.decode(reciveData.value)));
          updateAllValue();
          update();
        },
      );
    }).catchError((e) {
      Get.snackbar('Connection Faild', e.toString(),
          colorText: Colors.white,
          duration: Duration(milliseconds: 3000),
          icon: Icon(
            Icons.warning_amber_rounded,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.BOTTOM);
      Future.delayed(Duration(milliseconds: 4000))
          .whenComplete(() => Get.to(SettingPage()));
    });

//     try {

//       // _socket.listen((List<int> event) {
//       //    print(event.length);
//       //   Map data = json.decode(utf8.decode(event));
//       //   print("Recive Data :" + utf8.decode(event));
//       //  print("Data is :" + data.toString());
//       // reciveData(utf8.decode(event));
  }

  Future disconnectFromServer() async {
    print("disconnectFromServer");
    _socket.add(utf8.encode('slp'));
    _socket.close();

    _socket = null;
  }

  void updateAllValue() {
    ///// Slider Speed ////
    sliderSpeed(double.parse(deviceData.value.slid));

    ///// Direction Arrow /////
    switch (deviceData.value.dir) {
      case "2":
        sliderDirection('l');
        break;
      case "1":
        sliderDirection('r');
        break;
      case "0":
        sliderDirection('off');
        break;
    }
    ///// Mode Button Status ////
    switch (deviceData.value.mode) {
      case "1":
        movieBtnValue(true);
        timeLapsBtnValue(false);
        stopMotionBtnValue(false);
        break;
      case "2":
        movieBtnValue(false);
        timeLapsBtnValue(true);
        stopMotionBtnValue(false);
        break;
      case "3":
        movieBtnValue(false);
        timeLapsBtnValue(false);
        stopMotionBtnValue(true);
        break;
      default:
    }
    ///// Shoter Counter /////
    shoterCount(deviceData.value.shot);

    ///// InterVal Counter /////
    intervalTime(deviceData.value.m + ":" + deviceData.value.e);

    ///// Start/Stop Button ////
    switch (deviceData.value.st) {
      case "0":
        startBtnStatus(false);
        break;
      case "1":
        startBtnStatus(true);
        break;
      default:
    }

    ///// Battery Status /////
    batteryLevel(int.parse(deviceData.value.batt) * 20);
    update();
  }

  Future sendDirection() async {
    _socket.add(utf8.encode('direction'));
    print("ReciveDirectionData :" + deviceData.value.dir);
  }

  Future sendShoot() async {
    _socket.add(utf8.encode('shot'));
  }

  Future loadSettingData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final myStringList = prefs.getStringList('setting') ?? [];

    if (myStringList.isNotEmpty) {
      deviceIp(myStringList[0]);
      deviceport(int.parse(myStringList[1]));
      movieCommand(myStringList[2]);
      timeLapseCommand(myStringList[3]);
      stopMotionCommand(myStringList[4]);
    }

    ipAddress.text = deviceIp.value;
    port.text = deviceport.value.toString();
    moviec.text = movieCommand.value;
    timel.text = timeLapseCommand.value;
    stopm.text = stopMotionCommand.value;

    update();
  }

  Future changeSettingData() async {
    settings([ipAddress.text, port.text, moviec.text, timel.text, stopm.text]);
    print(settings);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('setting', settings());
  }

  changeSliderSpeed(speed) {
    print("Sended Speed :" + sliderSpeed.value.round().toString());

    sliderSpeed(speed);
    update();
  }

  sendSliderSpeed(speed) {
    _socket.add(utf8.encode('\$${sliderSpeed.value.round()}'));
  }

  changeShoterCounter() {
    _socket.add(utf8.encode('#${shoterCounter.text}'));
    Get.back();
  }

  changeIntervalTime() {
    String min, sec;
    if (int.parse(intervalCounter.text.split(":")[0]) > 59)
      min = '59';
    else
      min = intervalCounter.text.split(":")[0];
    if (int.parse(intervalCounter.text.split(":")[1]) > 59)
      sec = '59';
    else
      sec = intervalCounter.text.split(":")[1];

    _socket.add(utf8.encode('*$min":"$sec'));
    selectedIntevalTime("$min:$sec");
    update();
    Get.back();
  }

  void startStop() {
    _socket.add(utf8.encode('start'));
  }

  void changeMovieBtnValue(bool value) {
    if (timeLapsBtnValue.value) {
      Get.dialog(
        SimpleDialog(
          backgroundColor: Colors.white.withOpacity(0.9),
          titlePadding: EdgeInsets.all(8),
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
          title: Text("Are you sure you want to Stop TimeLapse Mode ?"),
          children: [
            RaisedButton(
                child: Text("Yes", style: TextStyle(color: Colors.white)),
                color: Colors.blue,
                onPressed: () {
                  _socket.add(utf8.encode('MODE1'));
                  Get.back();
                }),
            RaisedButton(
                child: Text(
                  "No",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.redAccent,
                onPressed: () => Get.back())
          ],
        ),
      );
    }
  }

  void changeTimeLapsValue(bool value) {
    _socket.add(utf8.encode('MODE2'));
  }

  void changeStopMotionValue(bool value) {
    if (timeLapsBtnValue.value) {
      Get.dialog(
        SimpleDialog(
          backgroundColor: Colors.white.withOpacity(0.9),
          titlePadding: EdgeInsets.all(8),
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
          title: Text("Are you sure you want to Stop TimeLapse Mode ?"),
          children: [
            RaisedButton(
                child: Text("Yes", style: TextStyle(color: Colors.white)),
                color: Colors.blue,
                onPressed: () {
                  _socket.add(utf8.encode('MODE3'));
                  Get.back();
                }),
            RaisedButton(
                child: Text(
                  "No",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.redAccent,
                onPressed: () => Get.back())
          ],
        ),
      );
    }
  }
}
