import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fanimation',
      debugShowCheckedModeBanner: false,
      home: LaunchScene(),
    );
  }
}

class LaunchScene extends StatefulWidget {
  @override
  _LaunchSceneState createState() => _LaunchSceneState();
}

class _LaunchSceneState extends State<LaunchScene> with TickerProviderStateMixin{

  AnimationController rocketController, steamController;
  Animation<double> rocketAnimation, steamAnimation;

  @override
  void initState() {

    // Rocket animation
    rocketController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this
    );

    final CurvedAnimation curve = CurvedAnimation(
      parent: rocketController, 
      curve: Curves.easeInOut
    );

    rocketAnimation = Tween(begin: 30.0, end: 0.0).animate(curve);

    rocketAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        rocketController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        rocketController.forward();
      }
    });

    rocketController.forward();

    // Steam animation
    steamController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this
    );

    final CurvedAnimation curveSteam = CurvedAnimation(
      parent: steamController, 
      curve: Curves.linear
    );

    steamAnimation = Tween(begin: 55.0, end: 78.0).animate(curveSteam);
    steamController.repeat();
    super.initState();
  }

  @override
    void dispose() {
      rocketController.dispose();
      steamController.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE1F0F3),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            height: 200.0,
            child: Stack(
              children: <Widget>[
                Container(
                        alignment: Alignment(1.0, -1.0),
                        padding: EdgeInsets.only(right: 106.0),
                        child: AnimatedSteam(
                          animation: steamAnimation,
                        )
                      ),
                      Container(
                        alignment: Alignment(1.0, -1.0),
                        padding: EdgeInsets.only(right: 85.0),
                        child: AnimatedRocket(
                          animation: rocketAnimation,
                        ),
                      ),
                      Container(
                        alignment: Alignment(1.0, 1.0),
                        child: Image.asset('assets/images/launch_clouds.png')
                      ),
              ],
            )
          )
        ],
      )
    );
  }
}

class AnimatedRocket extends AnimatedWidget {
  AnimatedRocket({Key key, Animation<double> animation})
    : super(key: key, listenable: animation);

  @override
    Widget build(BuildContext context) {
      final Animation<double> animation = listenable;
      return Container(
        margin: EdgeInsets.only(top: animation.value),
        child: Image.asset('assets/images/rocket.png')
      );
    }
}

class AnimatedSteam extends AnimatedWidget {
  AnimatedSteam({Key key, Animation<double> animation})
    : super(key: key, listenable: animation);

  @override
    Widget build(BuildContext context) {
      final Animation<double> animation = listenable;
      return Container(
        margin: EdgeInsets.only(top: animation.value),
        child: Image.asset('assets/images/launch_steam.png')
      );
    }
}
