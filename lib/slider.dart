import 'package:awesome_slider/awesome_slider.dart';
import 'package:flutter/material.dart';

class MySlider extends StatefulWidget {
 



  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  double valueOnTextWidget = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     colors: [Colors.redAccent.shade200, Color(0xFF890808)],
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight,
      //     stops: [0.0, 0.6],
      //   ),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              valueOnTextWidget.round().toString(),
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
          ),
          FittedBox(
            child: AwesomeSlider(
              value: valueOnTextWidget,
              min: 0.0,
              max: 14.0,
              // thumbColor: Color(0xFF890808),
              thumbColor: Colors.red,
              roundedRectangleThumbRadius: 80.0,
              thumbSize: 50.0,
              topLeftShadow: false,

              topLeftShadowColor: Colors.redAccent,
              topLeftShadowBlur: MaskFilter.blur(BlurStyle.normal, 8.0),
              bottomRightShadow: true,
              bottomRightShadowColor: Colors.black,

              bottomRightShadowBlur: MaskFilter.blur(BlurStyle.normal, 7.0),
              activeLineStroke: 2.0,
              activeLineColor: Colors.redAccent,
              inactiveLineColor: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 16.0,
                  ),
                  SizedBox(width: 0.0),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 16.0,
                  )
                ],
              ),

              onChanged: (double value) {
      
              },
            ),
          ),
        ],
      ),
    );
  }
}
