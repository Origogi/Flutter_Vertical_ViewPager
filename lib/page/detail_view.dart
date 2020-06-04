import 'dart:ui';

import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vertical_view_pager/constant/constant.dart';
import 'package:vertical_view_pager/model/champion.dart';

class DetailView extends StatefulWidget {
  final heroTag;
  final String title;
  final subject;
  final imageFileName;

  const DetailView(
      {this.heroTag, this.title, this.subject, this.imageFileName});

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> with TickerProviderStateMixin {
  bool init = false;

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    Tween<double> tween = Tween(begin: 0.0, end: 400.0);

    animation = tween.animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        init = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(init);

    final champ = championsMap[widget.title.toLowerCase()];

    return Scaffold(
      backgroundColor: backgoundColor,
      body: SafeArea(
        child: Stack(children: [
          Hero(
            tag: widget.heroTag,
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [backgoundColor, Colors.transparent],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                widget.imageFileName,
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 5, top: 45),
              child: CustomBackButton()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                    width: double.infinity,
                    height: 320,
                    child: Stack(
                      children: [
                        AnimatedBorder(animation: animation),
                        Align(
                          alignment: Alignment.center,
                          child: AnimatedOpacity(
                            opacity: init ? 1 : 0,
                            duration: Duration(milliseconds: 500),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          "images/role/${champ.role.toString().split(".")[1].toLowerCase()}.png",
                                          width: 60,
                                          height: 60),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "ROLE",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      Text(champ.role.toString().split(".")[1],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15))
                                    ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 60,
                                      child: Center(
                                        child: Stack(children: [
                                          Parallelogram(
                                            cutLength: 10.0,
                                            edge: Edge.RIGHT,
                                            child: Container(
                                              color: difficultyEnableColor,
                                              width: 25.0,
                                              height: 10.0,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 16),
                                            child: Parallelogram(
                                              cutLength: 10.0,
                                              edge: Edge.RIGHT,
                                              child: Container(
                                                color: difficultyEnableColor,
                                                width: 25.0,
                                                height: 10.0,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 32),
                                            child: Parallelogram(
                                              cutLength: 10.0,
                                              edge: Edge.RIGHT,
                                              child: Container(
                                                color: difficultyDisableColor,
                                                width: 25.0,
                                                height: 10.0,
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "DIFFICULTY",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    Text("MODERATE",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15))
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: init ? 1.0 : 0.0,
              child: Container(
                margin: EdgeInsets.only(bottom: 185),
                width: double.infinity,
                height: 270,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.subject,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class AnimatedBorder extends StatelessWidget {
  const AnimatedBorder({
    @required this.animation,
  });

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AnimatedBuilder(
        animation: animation,
        builder: (context, snapshot) {
          return CustomPaint(
            painter: MyPainter(value: animation.value),
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
            ),
          );
        },
      );
    });
  }
}

class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        color: Colors.grey[100].withOpacity(0.3),
        child: InkWell(
          child: SizedBox(
              width: 40,
              height: 40,
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double value;

  MyPainter({this.value});

  final paintBorder = Paint()
    ..color = Colors.white54
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.5;

  final transparentBorder = Paint()
    ..color = Colors.transparent
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.5;

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    if (value < 15) {
      double lineValue = size.width * value / 100;
      path.lineTo(lineValue, 0);
      canvas.drawPath(path, paintBorder);
      return;
    } else {
      path.lineTo(size.width * 15 / 100, 0);
      canvas.drawPath(path, paintBorder);
    }

    path = Path();
    path.moveTo(size.width * 15 / 100, 0);

    if (value >= 15 && value <= 85) {
      double lineValue = size.width * value / 100;
      path.lineTo(lineValue, 0);
      canvas.drawPath(path, transparentBorder);
      return;
    } else {
      path.lineTo(size.width * 85 / 100, 0);
      canvas.drawPath(path, transparentBorder);
    }

    path = Path();
    path.moveTo(size.width * 85 / 100, 0);

    if (value > 85 && value < 100) {
      double lineValue = size.width * value / 100;
      path.lineTo(lineValue, 0);
      canvas.drawPath(path, paintBorder);
      return;
    } else {
      path.lineTo(size.width, 0);
      canvas.drawPath(path, paintBorder);
    }

    if (value < 200) {
      double lineValue = size.height * (value - 100) / 100;
      path.lineTo(size.width, lineValue);
      canvas.drawPath(path, paintBorder);
      return;
    } else {
      path.lineTo(size.width, size.height);
      canvas.drawPath(path, paintBorder);
    }

    path = Path();
    path.moveTo(size.width, size.height);

    if (value < 300) {
      double lineValue = size.width - size.width * (value - 200) / 100;
      path.lineTo(lineValue, size.height);
      canvas.drawPath(path, paintBorder);
      return;
    } else {
      path.lineTo(0, size.height);
      canvas.drawPath(path, paintBorder);
    }

    path = Path();
    path.moveTo(0, size.height);

    if (value < 400) {
      double lineValue = size.height - size.height * (value - 300) / 100;
      path.lineTo(0, lineValue);
      canvas.drawPath(path, paintBorder);
      return;
    } else {
      path.lineTo(0, 0);
      canvas.drawPath(path, paintBorder);
    }
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
