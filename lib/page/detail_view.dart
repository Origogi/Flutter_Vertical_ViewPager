import 'package:drawing_animation/drawing_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final titleTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'Friz',
  fontWeight: FontWeight.bold,
);

class DetailView extends StatefulWidget {
  final heroTag;
  final title;
  final subject;
  final imageFileName;

  const DetailView(
      {this.heroTag, this.title, this.subject, this.imageFileName});

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  bool init = false;
  bool run = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        init = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(init);
    return Scaffold(
      body: Stack(children: [
        Hero(
          tag: widget.heroTag,
          child: Image.asset(
            widget.imageFileName,
            fit: BoxFit.fitHeight,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ),
        Padding(
            padding: EdgeInsets.only(left: 5, top: 45),
            child: CustomBackButton()),
        Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: init ? 1.0 : 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity,
              height: 180,
              color: Colors.black.withOpacity(0.3),
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
        // CustomPaint(
        //   //                       <-- CustomPaint widget
        //   size: Size(300, 300),
        //   painter: MyPainter(),
        // )
        AnimatedDrawing.paths(
          [Path()..addRect(Rect.fromLTWH(0, 0, 100, 100))],
          paints: [
            Paint()
              ..color = Colors.black
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4
          ],
          run: this.run,
          duration: new Duration(seconds: 3),
          onFinish: () => setState(() {
            this.run = false;
          }),
        )
      ]),
    );
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
  //         <-- CustomPainter class
  @override
  void paint(Canvas canvas, Size size) {
    //                                       <-- Insert your painting code here.
    final path = Path()..addRect(Rect.fromLTWH(0, 0, 100, 100));

    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
