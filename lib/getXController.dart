import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:omidsystem/dataModel.dart';
import 'package:omidsystem/settingPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SliderController extends GetxController {
  final settings = <String>[].obs;
  final deviceIp = '192.168.1.39'.obs;
  final deviceport = 54777.obs;
  final movieCommand = 'mode1'.obs;
  final timeLapseCommand = 'mode2'.obs;
  final stopMotionCommand = 'mode3'.obs;

  final TextEditingController ipAddress = TextEditingController();
  final TextEditingController port = TextEditingController();
  final TextEditingController moviec = TextEditingController();
  final TextEditingController timel = TextEditingController();
  final TextEditingController stopm = TextEditingController();

  final sliderSpeed = 0.0.obs;
  final sliderDirection = false.obs;
  final movieBtnValue = true.obs;
  final timeLapsBtnValue = false.obs;
  final stopMotionBtnValue = false.obs;
  final shoterCount = '0000'.obs;
  final intervalTime = '00:00'.obs;
  final projectStatus = false.obs;
  final batteryLevel = 70.obs;

  final TextEditingController shoterCounter = TextEditingController();
  final MaskedTextController intervalCounter =
      MaskedTextController(mask: '00:00');
  final reciveData = ''.obs;
  var deviceData = DataModel().obs;

  Socket _socket;

  @override
  void onInit() {
    connectToDevice();
    // connect();
    loadSettingData();
    super.onInit();
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
    Socket.connect(deviceIp.value, deviceport.value).then((soket) {
      _socket = soket;
      Get.snackbar("Connected",
          "Device Connected to ${deviceIp.value}:${deviceport.value.toString()}");

      _socket.listen(
        (onData) {
          //  print("Recives : " + String.fromCharCodes(onData).trim());
          // items.insert(
          //   0,
          // MessageItem(_socket.remoteAddress.address,
          //     String.fromCharCodes(onData).trim())
          // String.fromCharCodes(onData).trim());
          reciveData(String.fromCharCodes(onData).trim());
          deviceData(DataModel.fromJson(json.decode(reciveData.value)));
          //  );

          update();
        },
        //  onDone: () => onDone,
//onError: () => onError,
      );
    }).catchError((e) {
      Get.snackbar('Connection Faild', e.toString());
      Get.to(SettingPage());
    });

//     try {

//       // _socket.listen((List<int> event) {
//       //    print(event.length);
//       //   Map data = json.decode(utf8.decode(event));
//       //   print("Recive Data :" + utf8.decode(event));
//       //  print("Data is :" + data.toString());
//       // reciveData(utf8.decode(event));
  }

  void disconnectFromServer() {
    print("disconnectFromServer");

    _socket.close();

    _socket = null;
    update();
  }

  Future sendDirection() async {
    print("sned Direction Request");
    _socket.add(utf8.encode('direction'));
    // await Future.delayed(Duration(seconds: 5));
    print("reciveData is :" + deviceData.value.dir);
    if (deviceData.value.dir == '2') {
      sliderDirection(true);
    } else if (deviceData.value.dir == '1') {
      sliderDirection(false);
    } else {
      print(deviceData.value.dir);
    }
    update();
  }

  Future sendShoot() async {
    _socket.add(utf8.encode('shot'));
  }

  void loadSettingData() async {
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

    if (deviceData.value.st == '1') {
      projectStatus(false);
    } else
      projectStatus(true);
    print("Updated");
    // sliderSpeed(double.parse(deviceData.value.slid));
    update();
  }

  Future changeSettingData() async {
    settings([ipAddress.text, port.text, moviec.text, timel.text, stopm.text]);
    print(settings);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('setting', settings());
  }

  Future changeSliderSpeed(speed) async {
    print("Sended Speed :" + sliderSpeed.value.round().toString());
    _socket.add(utf8.encode('\$${sliderSpeed.value.round()}'));
    sliderSpeed(speed);
    update();
  }

  changeShoterCounter() {
    shoterCount(shoterCounter.text);
    update();
    Get.back();
  }

  changeIntervalTime() {
    intervalTime(intervalCounter.text);
    update();
    Get.back();
  }

  Future startStop() async {
    _socket.add(utf8.encode('start'));
    await Future.delayed(Duration(milliseconds: 300));
    print(deviceData.value.st);
    if (deviceData.value.st == '1') {
      projectStatus(false);
    } else if (deviceData.value.st == '0') {
      projectStatus(true);
    } else {
      print("Noting");
    }
    update();
  }

  Future changeMovieBtnValue(bool value) async {
    movieBtnValue(value);
    if (value) {
      timeLapsBtnValue(false);
      stopMotionBtnValue(false);
      _socket.add(utf8.encode('MODE1'));
    }
    update();
  }

  void changeTimeLapsValue(bool value) {
    timeLapsBtnValue(value);
    if (value) {
      movieBtnValue(false);
      stopMotionBtnValue(false);
      _socket.add(utf8.encode('MODE2'));
    }
    update();
  }

  void changeStopMotionValue(bool value) {
    stopMotionBtnValue(value);
    if (value) {
      timeLapsBtnValue(false);
      movieBtnValue(false);
      _socket.add(utf8.encode('MODE3'));
    }
    update();
  }
}
