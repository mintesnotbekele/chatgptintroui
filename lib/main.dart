import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<Widget> widgets = [];
  bool setOpacity = true;
  @override
  initState() {
    super.initState();
    _changeOpacity();
    _controller.stop();
    Timer(const Duration(seconds: 6), () {
      setState(() {
        setOpacity = false;
        image = true;
      });
      repeatOnce();
      Timer(const Duration(milliseconds: 60), () {
        populateLogoText("L");
        Timer(const Duration(milliseconds: 60), () {
          populateLogoText("I");
          Timer(const Duration(milliseconds: 60), () {
            populateLogoText("N");
            Timer(const Duration(milliseconds: 60), () {
              populateLogoText("K");
              Timer(const Duration(milliseconds: 60), () {
                populateLogoText("O");
                Timer(const Duration(milliseconds: 60), () {
                  populateLogoText(".");
                });
              });
            });
          });
        });
      });
    });
  }

  double opacityLevel = 1.0;
  bool initial = false;
  bool image = false;
  void _changeOpacity() {
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (setOpacity == true) {
        setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
      } else {
        setState(() => opacityLevel = 1.0);
        t.cancel();
      }
    });
  }

  var animaterate = -0.0;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  )..repeat(min: 0.0, max: 0.5, reverse: true);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, 0.0),
    end: Offset(animaterate, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  ));
  String logotext = "";
  var arr = ['L', 'I', 'N', 'K', '0', '.'];
  late final Animation<Offset> _offsetAnimation1 = Tween<Offset>(
    begin: const Offset(-0.4, 0.0),
    end: const Offset(1.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  ));
  final String assetName = 'assets/texts.svg';

  void populateLogoText(x) {
    setState(() {
      logotext = logotext + x;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool selected = false;
  void repeatOnce() async {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _offsetAnimation,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: image
                          ? Image.asset(
                              'assets/texts.png',
                              width: 20,
                            )
                          : null),
                ),
                Text(logotext,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold))
              ],
            )),
            Center(
              child: Container(
                margin: const EdgeInsets.only(left: 30),
                child: SlideTransition(
                    position: _offsetAnimation1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedOpacity(
                        opacity: opacityLevel,
                        duration: const Duration(seconds: 1),
                        child: Image.asset(
                          'assets/dot.png',
                          width: 25,
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
