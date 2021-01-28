import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omidsystem/getXController.dart';
import 'package:omidsystem/slider.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:xlive_switch/xlive_switch.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SliderController>(
        init: SliderController(),
        builder: (x) => Scaffold(
              appBar: AppBar(
                  centerTitle: true,
                  title: Text("Omid Slider Controller"),
                  backgroundColor: Colors.redAccent.shade200,
                  actions: [
                    IconButton(
                        icon: Icon(Icons.settings, color: Colors.white),
                        onPressed: () {})
                  ],
                  leading: Icon(Icons.wifi)),
              body: Center(
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
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          XlivSwitch(
                              value: x.movieBtnValue.value,
                              onChanged: (v) => x.changeMovieBtnValue(v)),
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
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              XlivSwitch(
                                  value: x.timeLapsBtnValue.value,
                                  onChanged: (v) => x.changeTimeLapsValue(v)),
                              Text(
                                "Time Lapse",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text("00:00",
                                  style: TextStyle(
                                      color: x.timeLapsBtnValue.value
                                          ? Colors.yellow
                                          : Colors.grey,
                                      fontSize: 20)),
                              Container(
                                margin: EdgeInsets.all(5),
                                width: 80,
                                height: 0.5,
                                color: Colors.white,
                              ),
                              Text("00:00",
                                  style: TextStyle(
                                      color: x.timeLapsBtnValue.value
                                          ? Colors.white
                                          : Colors.grey,
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
                                  value: x.stopMotionBtnValue.value,
                                  onChanged: (v) => x.changeStopMotionValue(v)),
                              Text(
                                "Stop Motion",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              ProgressButton.icon(
                                  iconedButtons: {
                                    ButtonState.idle: IconedButton(
                                        text: "Send",
                                        icon: Icon(Icons.send,
                                            color: Colors.white),
                                        color: Colors.deepPurple.shade500),
                                    ButtonState.loading: IconedButton(
                                        text: "Loading",
                                        color: Colors.deepPurple.shade700),
                                    ButtonState.fail: IconedButton(
                                        text: "Failed",
                                        icon: Icon(Icons.cancel,
                                            color: Colors.white),
                                        color: Colors.red.shade300),
                                    ButtonState.success: IconedButton(
                                        text: "Success",
                                        icon: Icon(
                                          Icons.check_circle,
                                          color: Colors.white,
                                        ),
                                        color: Colors.green.shade400)
                                  },
                                  onPressed: x.onPressedIconWithText,
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
                      padding: EdgeInsets.only(top: 8),
                    ),
                    Center(
                      child: Text("0000",
                          style: TextStyle(
                              color: x.movieBtnValue.value
                                  ? Colors.grey
                                  : Colors.white,
                              fontSize: 40)),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 15.0),
                    //   child: Center(child: x.buildTextWithIcon()),
                    // ),
                    Spacer(),
                    MySlider()
                  ],
                ),
              )),
            ));
  }
}
