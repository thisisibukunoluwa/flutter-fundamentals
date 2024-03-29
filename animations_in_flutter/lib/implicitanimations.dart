import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

// implicit animations
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool _bigger = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // we can add some animation to this widget by switching the Container widget for an AnimatedContainer Widget and specifying an animation duration
        // Container(
        //   width:_bigger ? 100 : 500,
        //   child:Image.asset('');
        // ),
        AnimatedContainer(
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: [Colors.purple, Colors.transparent],
                    stops: [_bigger ? 0.2 : 0.5, 1.0])),
            // curve: Curves.easeInOutQuint,
            curve: SineCurve(count: 2),
            width: _bigger ? 100 : 500,
            child: Image.asset('assets/images/star2.png'),
            duration: Duration(seconds: 1)),
        ElevatedButton(
            onPressed: () => setState(() {
                  _bigger = !_bigger;
                }),
            child: Icon(Icons.star))
      ],
    );
  }
}

//This is an example of a custom curve , that is the sine curve that uses the sine fucntion to make our curve bounce
class SineCurve extends Curve {
  final double count;

  SineCurve({this.count = 1});

  @override
  double transformInternal(double t) {
    return sin(count * 2 * pi * t) * 0.5 + 0.5;
  }
}
