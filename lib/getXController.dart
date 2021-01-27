import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:tcp_socket_connection/tcp_socket_connection.dart';

class SliderController extends GetxController {
  TcpSocketConnection socketConnection =
      TcpSocketConnection("192.168.43.91", 51617);

  @override
  void onInit() {
   // startConnection();
    super.onInit();
  }

  final TextEditingController ipAddress = TextEditingController();
  String result = " noting ";
  final movieBtnValue = false.obs;
  final timeLapsBtnValue = false.obs;
  final stopMotionBtnValue = false.obs;
  ButtonState stateTextWithIcon = ButtonState.idle;

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

  Widget buildTextWithIcon() {
    return ProgressButton.icon(iconedButtons: {
      ButtonState.idle: IconedButton(
          text: "START",
          icon: Icon(Icons.power_settings_new, color: Colors.white),
          color: Colors.deepPurple.shade500),
      ButtonState.loading:
          IconedButton(text: "Loading", color: Colors.deepPurple.shade700),
      ButtonState.fail: IconedButton(
          text: "FINISH",
          icon: Icon(Icons.cancel, color: Colors.white),
          color: Colors.red.shade300),
      ButtonState.success: IconedButton(
          text: "STOP",
          icon: Icon(
            Icons.stop,
            color: Colors.white,
          ),
          color: Colors.green.shade400)
    }, onPressed: onPressedIconWithText, state: stateTextWithIcon);
  }

  void onPressedIconWithText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIcon = ButtonState.loading;
        Future.delayed(Duration(milliseconds: 300), () {
          stateTextWithIcon = Random.secure().nextBool()
              ? ButtonState.success
              : ButtonState.fail;
          update();
        });

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIcon = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    stateTextWithIcon = stateTextWithIcon;
    update();
  }
}
