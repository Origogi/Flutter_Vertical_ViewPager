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
                itemCount: 5,
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
    Colors.indigo
  ];

  CardControllerWidget({this.currentPostion});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var viewWidth = constraints.maxWidth;
      var viewHeight = constraints.maxHeight;

      List<Widget> cardList = List();

      for (int i = 0; i < cardLength; i++) {
        var cardWidth = cardWidthMax - 60 * (currentPostion - i).abs();
        var cardHeight = getCardHeight(i);

        var cardTop = getCardPositionTop(cardHeight, viewHeight, i);

        Widget card = Positioned.directional(
            textDirection: TextDirection.ltr,
            top: cardTop,
            start: (viewWidth / 2) - (cardWidth / 2),
            child: Container(
              width: cardWidth,
              height: cardHeight,
              color: colors[i],
            ));

        cardList.add(card);
      }

      return Stack(
        children: cardList,
      );
    });
  }

  double getCardPositionTop(double cardHeight, double viewHeight, int i) {
    double diff = (currentPostion - i);

    if (diff < -2) {
      return (viewHeight / 2) - (cardHeight / 2) + 350;
    } else if (diff >= -2 && diff < -1) {
      return (viewHeight / 2) - (cardHeight / 2) + 350;
    } else if (diff >= -1 && diff < 0) {
      return (viewHeight / 2) - (cardHeight / 2) + 240;
    } else if (diff >= 0 && diff < 1) {
      return (viewHeight / 2) - (cardHeight / 2) + 240 * ( diff.floor() - diff);
    } else if (diff >= 1 && diff < 2) {
      return (viewHeight / 2) - (cardHeight / 2) - 240 ;
    } else if (diff >= 2 && diff < 3) {
      return (viewHeight / 2) - (cardHeight / 2) - 350;
    } else {
      return (viewHeight / 2) - (cardHeight / 2) - 350;
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
