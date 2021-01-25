import 'dart:math';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:omidsystem/slider.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:tcp_socket_connection/tcp_socket_connection.dart';
import 'package:xlive_switch/xlive_switch.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.redAccent.shade200,
          elevation: 0.0,
          title: Text(
            "ُSlider Controller",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: DashBoard()),
  ));
}

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final TextEditingController ipAddress = TextEditingController();
  String result = " noting ";
  bool _currentValue1 = false;
  bool _currentValue2 = false;
  bool _currentValue3 = false;
  ButtonState stateTextWithIcon = ButtonState.idle;
  TcpSocketConnection socketConnection =
      TcpSocketConnection("192.168.4.1", 1010);

  void messageReceived(String msg) {
    setState(() {
      result = msg;
      print(msg);
    });
    socketConnection.sendMessage("MessageIsReceived :D");
  }

  void startConnection() async {
    await socketConnection.connect(120000, "", messageReceived);
    print("Runnnn");
    // socketConnection.sendMessage("Omiad Tala");
  }

  void sendMess(String command) {
    socketConnection.sendMessage(command);
    // socketConnection.connectWithCommand(5000, "", command, messageReceived);
    print("Send Message");
  }

  void onPressedIconWithText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIcon = ButtonState.loading;
        Future.delayed(Duration(milliseconds: 300), () {
          setState(() {
            stateTextWithIcon = Random.secure().nextBool()
                ? ButtonState.success
                : ButtonState.fail;
          });
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
    setState(() {
      stateTextWithIcon = stateTextWithIcon;
    });
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

  @override
  void initState() {
    super.initState();
    startConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.redAccent.shade200, Color(0xFF890808)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.6],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                XlivSwitch(
                  value: _currentValue1,
                  onChanged: (v) {
                    setState(() {
                      _currentValue1 = v;
                    });

                    if (v) {
                      sendMess("mode1");
                      setState(() {
                        _currentValue2 = false;
                        _currentValue3 = false;
                      });
                    }
                  },
                ),
                Text(
                  "Movie",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    XlivSwitch(
                      value: _currentValue2,
                      onChanged: (v) {
                        setState(() {
                          _currentValue2 = v;
                        });

                        if (v) {
                          sendMess("mode2");
                          setState(() {
                            _currentValue1 = false;
                            _currentValue3 = false;
                          });
                        }
                      },
                    ),
                    Text(
                      "Time Lapse",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text("00:00",
                        style: TextStyle(
                            color: _currentValue2 ? Colors.yellow : Colors.grey,
                            fontSize: 20)),
                    Container(
                      margin: EdgeInsets.all(5),
                      width: 80,
                      height: 0.5,
                      color: Colors.white,
                    ),
                    Text("00:00",
                        style: TextStyle(
                            color: _currentValue2 ? Colors.white : Colors.grey,
                            fontSize: 40)),
                  ],
                )
              ],
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    XlivSwitch(
                      value: _currentValue3,
                      onChanged: (v) {
                        setState(() {
                          _currentValue3 = v;
                        });

                        if (v) {
                          setState(() {
                            sendMess("mode3");
                            _currentValue1 = false;
                            _currentValue2 = false;
                          });
                        }
                      },
                    ),
                    Text(
                      "Stop Motion",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
                Column(
                  children: [
                    ProgressButton.icon(
                        iconedButtons: {
                          ButtonState.idle: IconedButton(
                              text: "Send",
                              icon: Icon(Icons.send, color: Colors.white),
                              color: Colors.deepPurple.shade500),
                          ButtonState.loading: IconedButton(
                              text: "Loading",
                              color: Colors.deepPurple.shade700),
                          ButtonState.fail: IconedButton(
                              text: "Failed",
                              icon: Icon(Icons.cancel, color: Colors.white),
                              color: Colors.red.shade300),
                          ButtonState.success: IconedButton(
                              text: "Success",
                              icon: Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              ),
                              color: Colors.green.shade400)
                        },
                        onPressed: onPressedIconWithText,
                        state: ButtonState.idle)
                  ],
                )
              ],
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Center(
            child: Text("0000",
                style: TextStyle(
                    color: _currentValue1 ? Colors.grey : Colors.white,
                    fontSize: 40)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Center(child: buildTextWithIcon()),
          ),
          Spacer(),
          MySlider(socketConnection: socketConnection)
        ],
      ),
    ));
  }
}
