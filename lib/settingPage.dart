import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:omidsystem/dashboard.dart';
import 'getXController.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SliderController>(
        // init: SliderController(),
        builder: (x) => Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text("Setting"),
                backgroundColor: Colors.blueAccent.shade200,
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: () => x.disconnectFromServer().whenComplete(() =>  SystemNavigator.pop()),
                child: Icon(
                  Icons.power_settings_new,
                  color: Colors.white,
                ),
              ),
              body: Center(
                  child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent.shade200, Colors.blue.shade900],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 0.6],
                  ),
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text('Specify Commands to send to the Slider',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text('Device IP',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextField(
                                controller: x.ipAddress,
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: true),
                                maxLength: 15,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  counterText: "",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white54,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: Text('Port',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextField(
                                controller: x.port,
                                maxLength: 6,
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  counterText: "",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white54,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Divider(
                      color: Colors.white,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text('Movie Command',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextField(
                                controller: x.moviec,
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white54,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                    Divider(
                      color: Colors.white,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text('Time Lapse Command',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextField(
                                controller: x.timel,
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white54,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                    Divider(
                      color: Colors.white,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text('Stop Motion Command',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextField(
                                controller: x.stopm,
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white54,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                    Divider(
                      color: Colors.white,
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue.shade700,
                        child: Text("Save Setting"),
                        onPressed: () => x.changeSettingData().whenComplete(() {
                          x.onInit();
                          Get.to(Dashboard());
                        }),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    )
                  ],
                ),
              )),
            ));
  }
}
