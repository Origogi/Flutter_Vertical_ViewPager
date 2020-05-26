import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double currentPostion = 2.0;
  PageController controller = PageController(initialPage: 2);

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      setState(() {
        currentPostion = controller.page;
      });
    });

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CardControllerWidget(currentPostion: currentPostion),
            Positioned.fill(
              child: PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 6,
                controller: controller,
                itemBuilder: (context, index) {
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardControllerWidget extends StatelessWidget {
  final double currentPostion;
  final int cardLength = 5;
  final cardWidthMax = 350.0;
  final cardHeightMax = 350.0;

  var centerTopPosition = 0.0;

  final colors = [
    Colors.red,
    Colors.blue,
    Colors.amber,
    Colors.cyan,
    Colors.indigo,
    Colors.brown
  ];

  CardControllerWidget({this.currentPostion});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var viewWidth = constraints.maxWidth;
      var viewHeight = constraints.maxHeight;

      List<Widget> cardList = List();

      for (int i = 0; i < colors.length; i++) {
        var cardWidth = cardWidthMax - 60 * (currentPostion - i).abs();
        var cardHeight = getCardHeight(i);

        var cardTop = getCardPositionTop(cardHeight, viewHeight, i);

        if (i == 2) {
          // print(cardTop);
        }

        Widget card = Positioned.directional(
            textDirection: TextDirection.ltr,
            top: cardTop,
            start: (viewWidth / 2) - (cardWidth / 2),
            child: Opacity(
              opacity:getOpacity(i),
              child: Container(
                width: cardWidth,
                height: cardHeight,
                color: colors[i],
              ),
            ));

        cardList.add(card);
      }

      return Stack(
        children: cardList,
      );
    });
  }

  double getOpacity(int i) {
    double diff = (currentPostion - i);


    if (diff >= -2 && diff <= 2) {
      return 1.0;
    } else if (diff > -3 && diff < -2) {
      return 3 - diff.abs();
    } else if (diff > 2 && diff < 3) {
      return 3 - diff.abs();
    }
    else {
      return 0;
    }
  }

  double getCardPositionTop(double cardHeight, double viewHeight, int i) {
    double diff = (currentPostion - i);
    double diffAbs = diff.abs();

    double basePosition = (viewHeight / 2) - (cardHeight / 2);

    if (i == 2) {
      print(diff);
    }

    if (diffAbs == 0) {
      return basePosition;
    }
    if (diffAbs > 0.0 && diffAbs < 1.0) {
      if (diff >= 0) {
        return basePosition - 240 * diff.abs();
      } else {
        return basePosition + 240 * diffAbs;
      }
    } else if (diffAbs == 1) {
      if (diff >= 0) {
        return basePosition - 240;
      } else {
        return basePosition + 240;
      }
    } else if (diffAbs > 1.0 && diffAbs < 2.0) {
      if (diff >= 0) {
        return basePosition - 240 - 110 * (diffAbs - diffAbs.floor()).abs();
      } else {
        return basePosition + 240 + 110 * (diffAbs - diffAbs.floor()).abs();
      }
    } else {
      if (diff >= 0) {
        return basePosition - 350;
      } else {
        return basePosition + 350;
      }
    }
  }

  double getCardHeight(int index) {
    double diff = (currentPostion - index).abs();

    if (diff >= 0.0 && diff < 1.0) {
      return cardHeightMax - 250.0 * ((diff - diff.floor()));
    } else if (diff >= 1.0 && diff < 2.0) {
      return cardHeightMax - 250 - 20 * ((diff - diff.floor()));
    } else {
      return cardHeightMax - 270.0;
    }
  }
}
