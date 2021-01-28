
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:omidsystem/dashboard.dart';

<<<<<<< HEAD
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
      TcpSocketConnection("192.168.1.39", 56358);

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
=======
>>>>>>> 364872c11a3ffdfb06c7623647e0ae6f9f9b1e35

void main() {
  runApp(GetMaterialApp(debugShowCheckedModeBanner: false, home: Dashboard()));
}
