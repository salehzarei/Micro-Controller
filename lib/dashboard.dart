import 'package:battery_indicator/battery_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omidsystem/getXController.dart';
import 'package:omidsystem/settingPage.dart';
import 'package:xlive_switch/xlive_switch.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SliderController>(
        init: SliderController(),
        builder: (x) => SafeArea(
              child: Scaffold(
                appBar: AppBar(
                    centerTitle: true,
                    title: Text("AVA Slider Controller"),
                    backgroundColor: Colors.blueAccent.shade200,
                    actions: [
                      IconButton(
                          icon: Icon(Icons.settings, color: Colors.white),
                          onPressed: () => Get.to(SettingPage()))
                    ],
                    leading: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 8),
                      child: BatteryIndicator(
                        mainColor: Colors.white,
                        batteryFromPhone: false,
                        showPercentNum: false,
                        colorful: false,
                        batteryLevel: x.batteryLevel.value,
                        style: BatteryIndicatorStyle.values[1],
                      ),
                    )),
                body: Center(
                    child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blueAccent.shade200,
                        Colors.blue.shade900
                      ],
                      //Color(0xFF890808)
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  XlivSwitch(
                                      value: x.movieBtnValue.value,
                                      onChanged: (v) =>
                                          x.changeMovieBtnValue(v)),
                                  Text(
                                    "Movie",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  XlivSwitch(
                                      value: x.timeLapsBtnValue.value,
                                      onChanged: (v) =>
                                          x.changeTimeLapsValue(v)),
                                  Text(
                                    "Time Lapse",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text('Shoter Count',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12)),
                                InkWell(
                                  onTap: () => x.timeLapsBtnValue.value
                                      ? Get.dialog(Padding(
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
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text("Shots Count",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16)),
                                                  ),
                                                  Spacer(
                                                    flex: 1,
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: TextField(
                                                      onSubmitted: (v) => x
                                                          .changeShoterCounter(),
                                                      controller:
                                                          x.shoterCounter,
                                                      cursorColor: Colors.white,
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLength: 4,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30),
                                                      decoration:
                                                          InputDecoration(
                                                        counterText: '',
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.white,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        fillColor: Colors.white,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                Colors.white54,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.white,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ))
                                      : null,
                                  child: Text(x.shoterCount(),
                                      style: TextStyle(
                                          color: x.movieBtnValue.value
                                              ? Colors.grey
                                              : Colors.white,
                                          fontSize: 40)),
                                ),
                              ],
                            ),

                            /// Shot
                            MaterialButton(
                              color: x.stopMotionBtnValue.value
                                  ? Colors.green
                                  : Colors.grey,
                              shape: CircleBorder(),
                              onPressed: () => x.stopMotionBtnValue.value
                                  ? x.sendShoot()
                                  : null,
                              child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 35,
                                  )
                                  // Text(
                                  //   'Shoot',
                                  //   style: TextStyle(
                                  //       color: Colors.white, fontSize: 18),
                                  // ),
                                  ),
                            ),

                            /// interval btn

                            Column(
                              children: [
                                // Container(
                                //   margin: EdgeInsets.all(5),
                                //   width: 80,
                                //   height: 0.5,
                                //   color: Colors.white,
                                // ),
                                Text('Interval Time',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12)),
                                InkWell(
                                  onTap: () => x.timeLapsBtnValue.value
                                      ? Get.dialog(Padding(
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
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text("Interval Time",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16)),
                                                  ),
                                                  Spacer(
                                                    flex: 1,
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: TextField(
                                                      onSubmitted: (v) => x
                                                          .changeIntervalTime(),
                                                      controller:
                                                          x.intervalCounter,
                                                      cursorColor: Colors.white,
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLength: 5,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30),
                                                      decoration:
                                                          InputDecoration(
                                                        counterText: '',
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.white,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        fillColor: Colors.white,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                Colors.white54,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.white,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ))
                                      : null,
                                  child: Text(x.intervalTime(),
                                      style: TextStyle(
                                          color: x.timeLapsBtnValue.value
                                              ? Colors.white
                                              : Colors.grey,
                                          fontSize: 40)),
                                ),
                                Text(x.selectedIntevalTime.value,
                                    style: TextStyle(
                                        color: x.timeLapsBtnValue.value
                                            ? Colors.yellow
                                            : Colors.grey,
                                        fontSize: 20)),
                              ],
                            )
                          ],
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
                              color: x.sliderDirection() == 'l'
                                  ? Colors.white
                                  : x.sliderDirection() == 'r'
                                      ? Colors.white.withOpacity(0.2)
                                      : Colors.white.withOpacity(0.2),
                              size: 60,
                            ),
                            RaisedButton(
                              textColor: Colors.white,
                              color: Colors.red.shade900,
                              child: Text("Slider Direction"),
                              onPressed: () => x.sendDirection(),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: x.sliderDirection() == 'r'
                                  ? Colors.white
                                  : x.sliderDirection() == 'l'
                                      ? Colors.white.withOpacity(0.2)
                                      : Colors.white.withOpacity(0.2),
                              size: 60,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  "Slider Speed : ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0),
                                ),
                                Text(
                                  x.sliderSpeed.round().toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30.0),
                                ),
                              ],
                            ),
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.blue[700],
                              inactiveTrackColor: Colors.blue[100],
                              trackShape: RoundedRectSliderTrackShape(),
                              trackHeight: 4.0,
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 12.0),
                              thumbColor: Colors.redAccent,
                              overlayColor: Colors.red.withAlpha(32),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 28.0),
                              tickMarkShape: RoundSliderTickMarkShape(),
                              activeTickMarkColor: Colors.red[700],
                              inactiveTickMarkColor: Colors.red[100],
                              valueIndicatorShape:
                                  PaddleSliderValueIndicatorShape(),
                              valueIndicatorColor: Colors.redAccent,
                              valueIndicatorTextStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            child: Slider(
                                //  onChanged: (v) {},
                                min: 0,
                                max: 15,
                                label: '${x.sliderSpeed().round()}',
                                value: x.sliderSpeed(),
                                // onChangeStart: (value) =>
                                //     x.changeSliderSpeed(value),
                                onChangeEnd: (value) =>
                                    x.sendSliderSpeed(value),
                                onChanged: (value) =>
                                    x.changeSliderSpeed(value)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: x.startBtnStatus.value
                              ? Colors.red.shade900
                              : Colors.green.shade700,
                          child: x.startBtnStatus.value
                              ? Text(
                                  "Stop",
                                  style: TextStyle(fontSize: 25),
                                )
                              : Text(
                                  "Start",
                                  style: TextStyle(fontSize: 25),
                                ),
                          onPressed: () => x.startStop(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            ));
  }
}
