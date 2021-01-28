import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omidsystem/getXController.dart';
import 'package:omidsystem/settingPage.dart';
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
                        onPressed: () => Get.to(SettingPage()))
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                XlivSwitch(
                                    value: x.movieBtnValue.value,
                                    onChanged: (v) => x.changeMovieBtnValue(v)),
                                Text(
                                  "Movie",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )
                              ],
                            ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                XlivSwitch(
                                    value: x.stopMotionBtnValue.value,
                                    onChanged: (v) =>
                                        x.changeStopMotionValue(v)),
                                Text(
                                  "Stop Motion",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )
                              ],
                            ),
                          ],
                        )),
                    Divider(
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('Shoter Count',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                              InkWell(
                                onTap: () => Get.dialog(Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.15,
                                      vertical: Get.height * 0.37),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color: Colors.red.shade900,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Text("Select the number of shots",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18)),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          TextField(
                                            onSubmitted: (v) =>
                                                x.changeShoterCounter(),
                                            controller: x.shoterCounter,
                                            cursorColor: Colors.white,
                                            textAlign: TextAlign.center,
                                            maxLength: 4,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 45),
                                            decoration: InputDecoration(
                                              counterText: '',
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              fillColor: Colors.white,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white54,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                                child: Text(x.shoterCounter.text,
                                    style: TextStyle(
                                        color: x.movieBtnValue.value
                                            ? Colors.grey
                                            : Colors.white,
                                        fontSize: 40)),
                              ),
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
                        children: [],
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.chevron_left,
                            color: x.sliderDirection()
                                ? Colors.white
                                : Colors.white.withOpacity(0.2),
                            size: 60,
                          ),
                          RaisedButton(
                            textColor: Colors.white,
                            color: Colors.red.shade900,
                            child: Text("Change Slider Direction"),
                            onPressed: () => x.changeSliderDirection(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: x.sliderDirection()
                                ? Colors.white.withOpacity(0.2)
                                : Colors.white,
                            size: 60,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    MySlider()
                  ],
                ),
              )),
            ));
  }
}
