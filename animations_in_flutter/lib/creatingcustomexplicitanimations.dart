// Creating custom explicit animations with AnimatedBuilder and AnimatedWidget

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

// https://medium.com/flutter/when-should-i-useanimatedbuilder-or-animatedwidget-57ecae0959e8

// we want to write an app with an alien spaeship and a spaceship animation

class MyAppHome extends StatelessWidget {
  const MyAppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: MyHomePage()),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  // _MyHomePageState({super.key});

  late AnimationController _animation;

  final Image starsBackground = Image.asset(
    "assets/images/starsbackground.jpg",
  );
  final Image ufo = Image.asset(
    "assets/images/ufo1.png",
    height: 400,
    width: 400,
  );
  @override
  void initState() {
    super.initState();
    _animation =
        AnimationController(duration: Duration(seconds: 5), vsync: this)
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        FittedBox(
          fit: BoxFit.fill,
          child: starsBackground,
        ),
        //  AnimatedBuilder(
        //   animation: _animation,
        //   builder: (_,__) {
        //      return ClipPath(
        //       clipper: const BeamClipper(),
        //       child: Container(
        //         height: 1000,
        //         decoration: BoxDecoration(
        //             gradient: RadialGradient(
        //                 radius: 1.5,
        //                 colors: [Colors.yellow, Colors.transparent],
        //                 stops: [0,_animation.value]
        //            )),
        //       )
        //     );
        //  }
        // ),
        BeamTransition(animation: _animation),
        ufo
      ],
    );
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }
}

class BeamClipper extends CustomClipper<Path> {
  const BeamClipper();
  @override
  getClip(Size size) {
    return Path()
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(size.width / 2, size.height / 2)
      ..close();
  }

  /// Return false always because we always clip the same area.
  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}

class BeamTransition extends AnimatedWidget {
  BeamTransition({super.key, required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return ClipPath(
        clipper: const BeamClipper(),
        child: Container(
          height: 1000,
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  radius: 1.5,
                  colors: [Colors.yellow, Colors.transparent],
                  stops: [0, animation.value])),
        ));
  }
}

// we want to create a beam shaped animation that will be repeated starting from the center of the Ufo but their is no inbuilt widgets for funnel shaped gradients so we will use Animated Gradient , we will wrap the graident code inisde the AnimatedBuilder , we're also ging to use a controller to drive the animation , we create the controller in the initState instead of the buildMethod, because we don't want to create the controller multiple times

//The build method looks quire large, but we can fix this by extracting it into a separate widget, but then we will have a build method inside a build method, which will not make much sense so it better we make it an animated Widget wiht tht anme BeamTransiiton to follow the 'FooTransition' naming convention

//Just like AnimatedBuilder, if appropriate, i can add a child parameter to my widget as a performance optimization sp that6 it builds ahead of time instead of every time i animate 