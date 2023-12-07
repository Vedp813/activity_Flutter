import 'package:activity/Screens/activities.dart';
import 'package:activity/Screens/finder.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:math';
import 'package:flutter/services.dart';

class PreFind extends StatefulWidget {
  @override
  State<PreFind> createState() => _PreFindState();
}

class _PreFindState extends State<PreFind> with SingleTickerProviderStateMixin {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 53,
              child: Text(
                'Activities:',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    shadows: [
                      Shadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(3, 5))
                    ]),
              ),
            ),
            Container(
              margin: EdgeInsets.all(0),
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5, // card height
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 5,
                  controller: PageController(viewportFraction: 0.75),
                  onPageChanged: (int index) => setState(() => _index = index),
                  itemBuilder: (_, i) {
                    return Transform.scale(
                      filterQuality: FilterQuality.medium,
                      scale: i == _index ? 1 : 0.90,
                      child: Card(
                        color: Colors.white,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            "Walking ${i + 1}",
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  child: Icon(
                    Icons.add,
                    size: 23,
                  ),
                  backgroundColor: Colors.black,
                  mini: true,
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: activities()));
                  },
                )),
            SizedBox(height: 22),
            GestureDetector(
              onLongPress: () async {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                HapticFeedback.heavyImpact().then((value) {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: finder()));
                });
              },
              child: Container(
                  alignment: Alignment.center,
                  child: CustomPaint(
                    painter: new SpritePainter(_controller),
                    child: IconButton(
                      alignment: Alignment.center,
                      iconSize: 60,
                      color: Colors.white,
                      icon: Icon(Icons.search, size: 60),
                      onPressed: () {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.black87,
                                duration: Duration(milliseconds: 500),
                                content: Text('Try a Long Press :D')));
                      },
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
    _startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.stop();
    _controller.reset();
    _controller.repeat(
      period: Duration(seconds: 1),
    );
  }
}

class SpritePainter extends CustomPainter {
  final Animation<double> _animation;

  SpritePainter(this._animation) : super(repaint: _animation);

  void circle(Canvas canvas, Rect rect, double value) {
    double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    Color color = new Color.fromRGBO(0, 0, 0, opacity);

    double size = rect.width / 2;
    double area = size * size * 1.4;
    double radius = sqrt(area * value / 0.8);

    final Paint paint = new Paint()..color = color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = new Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(SpritePainter oldDelegate) {
    return true;
  }
}
