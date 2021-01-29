import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SliderController extends GetxController {
  final settings = <String>[].obs;
  final deviceIp = '0.0.0.0'.obs;
  final deviceport = '0000'.obs;
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
  final TextEditingController shoterCounter = TextEditingController();
  final MaskedTextController intervalCounter =
      MaskedTextController(mask: '00:00');

  Socket _socket;

  // TcpSocketConnection socketConnection =
  //     TcpSocketConnection("192.168.43.91", 58459);

  @override
  void onInit() {
    connectToDevice();
    loadSettingData();
    shoterCounter.text = shoterCount();
    intervalCounter.text = intervalTime();
    super.onInit();
  }

  void connectToDevice() async {
    try {
      _socket = await Socket.connect('192.168.43.91', 58459);
      print(_socket.address);
      // listen to the received data event stream
      _socket.listen((List<int> event) {
        print("Recive Data : " + utf8.decode(event));
      });
      print(_socket.isEmpty);
     } catch (e) {
      print(e.printError());
      Get.snackbar('Connection Faild', 'plase Chack IP and Port for connection');
    }

  }

  void sendDirection() async {
      // send hello
      _socket.add(utf8.encode('dir'));

      // wait 5 seconds
      // await Future.delayed(Duration(seconds: 5));
      // _socket.close();
  }

  void sendShoot(){
     _socket.add(utf8.encode('Shoot'));
  }

  void loadSettingData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final myStringList = prefs.getStringList('setting') ?? [];

    if (myStringList.isNotEmpty) {
      deviceIp(myStringList[0]);
      deviceport(myStringList[1]);
      movieCommand(myStringList[2]);
      timeLapseCommand(myStringList[3]);
      stopMotionCommand(myStringList[4]);
    }

    ipAddress.text = deviceIp.value;
    port.text = deviceport.value;
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

 
  void changeSliderSpeed(speed) {
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

  void startStop() {
    projectStatus.toggle();
    // sendMess('Test Message');
    connectToDevice();
    update();
  }

  void messageReceived(String msg) {
    print(msg);

    // socketConnection.sendMessage("MessageIsReceived :D");
    //  update();
  }

  void changeMovieBtnValue(bool value) {
    movieBtnValue(value);
    if (value) {
      timeLapsBtnValue(false);
      stopMotionBtnValue(false);
    }
    update();
  }

  void changeTimeLapsValue(bool value) {
    timeLapsBtnValue(value);
    if (value) {
      movieBtnValue(false);
      stopMotionBtnValue(false);
    }
    update();
  }

  void changeStopMotionValue(bool value) {
    stopMotionBtnValue(value);
    if (value) {
      timeLapsBtnValue(false);
      movieBtnValue(false);
    }
    update();
  }

  // void startConnection() async {
  //   // await socketConnection.connect(120000, "%", messageReceived);
  //   await socketConnection.simpleConnect(12000, messageReceived);
  //   socketConnection.sendMessage("Omiad Tala");
  // }

  // void sendMess(String command) async {
  //   await socketConnection.connect(5000, '', messageReceived );
  //   socketConnection.sendMessage(command);
  //   // socketConnection.connectWithCommand(5000, "", command, messageReceived);
  //   print("Send Message");
  //   socketConnection.disconnect();
  //   print(socketConnection.isConnected());
  // }
}
