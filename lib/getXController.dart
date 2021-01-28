import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcp_socket_connection/tcp_socket_connection.dart';

class SliderController extends GetxController {
  final settings = <String>[].obs;
  final deviceIp = '0.0.0.0'.obs;
  final deviceport = '3040'.obs;
  final movieCommand = 'mode1'.obs;
  final timeLapseCommand = 'mode2'.obs;
  final stopMotionCommand = 'mode3'.obs;

  final TextEditingController ipAddress = TextEditingController();
  final TextEditingController port = TextEditingController();
  final TextEditingController moviec = TextEditingController();
  final TextEditingController timel = TextEditingController();
  final TextEditingController stopm = TextEditingController();

  String result = " noting ";

  final sliderSpeed = 0.0.obs;
  final sliderDirection = false.obs;
  final movieBtnValue = false.obs;
  final timeLapsBtnValue = false.obs;
  final stopMotionBtnValue = false.obs;
  final shoterCount = '0000'.obs;
  final TextEditingController shoterCounter = TextEditingController();
  ButtonState stateTextWithIcon = ButtonState.idle;

  TcpSocketConnection socketConnection =
      TcpSocketConnection("192.168.43.91", 51617);

  @override
  void onInit() {
    // startConnection();
    loadSettingData();
    shoterCounter.text = shoterCount();
    super.onInit();
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

      print(deviceIp);
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

  void changeSliderDirection() {
    sliderDirection.toggle();
    update();
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

  void messageReceived(String msg) {
    result = msg;
    print(msg);

    socketConnection.sendMessage("MessageIsReceived :D");
    update();
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

  void startConnection() async {
    // await socketConnection.connect(120000, "%", messageReceived);
    // await socketConnection.simpleConnect(12000, messageReceived);
    print("Runnnn");
    // socketConnection.sendMessage("Omiad Tala");
  }

  void sendMess(String command) {
    socketConnection.sendMessage(command);
    // socketConnection.connectWithCommand(5000, "", command, messageReceived);
    print("Send Message");
  }
}
