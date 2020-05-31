import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'constant/constant.dart';

class VerticalCardPager extends StatefulWidget {
  @override
  _VerticalCardPagerState createState() => _VerticalCardPagerState();
}

class _VerticalCardPagerState extends State<VerticalCardPager> {
  bool isScrolling;

  double currentPostion = 2.0;

  PageController controller = PageController(initialPage: 2);

  void onTapUp(BuildContext context, details) {
    print('${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    print("local offset ${localOffset.dx}, ${localOffset.dy}");

    double dx = localOffset.dx;
    double dy = localOffset.dy;
  }

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        currentPostion = controller.page;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onVerticalDragEnd: (details) {
          isScrolling = false;
        },
        onVerticalDragStart: (details) {
          isScrolling = true;
        },
        onTapUp: (details) {
          if (!isScrolling) {
            onTapUp(context, details);
          }
        },
        child: Stack(
          children: [
            CardControllerWidget(
              currentPostion: currentPostion,
              cardViewPagerHeight: constraints.maxHeight,
              cardViewPagerWidth: constraints.maxWidth,
            ),
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
      );
    });
  }
}

class CardControllerWidget extends StatelessWidget {
  final double currentPostion;
  final int cardLength = 5;
  final double cardMaxWidth;
  final double cardMaxHeight;
  final double cardViewPagerHeight;
  final double cardViewPagerWidth;

  CardControllerWidget(
      {this.cardViewPagerWidth, this.cardViewPagerHeight, this.currentPostion})
      : cardMaxWidth = cardViewPagerWidth - maxCardWidthPadding,
        cardMaxHeight = cardViewPagerHeight * (1 / 3);

  static List images = [
    Image.asset(
      "images/catalina.png",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "images/el_capitan.png",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "images/high_sierra.png",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "images/mojave.png",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "images/sierra.png",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "images/yosemite.png",
      fit: BoxFit.cover,
    ),
  ];

  final texts = [
    "Catalina",
    "El Capitan",
    "High Sierra",
    "Mojave",
    "Sierra",
    "Yosemite",
  ];

  final titleTextStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'Bevan',
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    List<Widget> cardList = List();

    for (int i = 0; i < images.length; i++) {
      var cardWidth = cardMaxWidth - 60 * (currentPostion - i).abs();
      var cardHeight = getCardHeight(i);

      var cardTop = getCardPositionTop(cardHeight, cardViewPagerHeight, i);

      Widget card = Positioned.directional(
          textDirection: TextDirection.ltr,
          top: cardTop,
          start: (cardViewPagerWidth / 2) - (cardWidth / 2),
          child: Opacity(
            opacity: getOpacity(i),
            child: Container(
              width: cardWidth,
              height: cardHeight,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: images[i],
                    ),
                  ),
                  Align(
                      child: Text(
                    texts[i],
                    style: titleTextStyle.copyWith(fontSize: getFontSize(i)),
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
            ),
          ));

      cardList.add(card);
    }

    return Stack(
      children: cardList,
    );
  }

  double getOpacity(int i) {
    double diff = (currentPostion - i);

    if (diff >= -2 && diff <= 2) {
      return 1.0;
    } else if (diff > -3 && diff < -2) {
      return 3 - diff.abs();
    } else if (diff > 2 && diff < 3) {
      return 3 - diff.abs();
    } else {
      return 0;
    }
  }

  double getCardPositionTop(double cardHeight, double viewHeight, int i) {
    double diff = (currentPostion - i);
    double diffAbs = diff.abs();

    double basePosition = (viewHeight / 2) - (cardHeight / 2);

    if (diffAbs == 0) {
      return basePosition;
    }
    if (diffAbs > 0.0 && diffAbs <= 1.0) {
      if (diff >= 0) {
        return basePosition - (cardViewPagerHeight * (2 / 7)) * diffAbs;
      } else {
        return basePosition + (cardViewPagerHeight * (2 / 7)) * diffAbs;
      }
    } else if (diffAbs > 1.0 && diffAbs < 2.0) {
      if (diff >= 0) {
        return basePosition -
            (cardViewPagerHeight * (2 / 7)) -
            cardViewPagerHeight * (1 / 7) * (diffAbs - diffAbs.floor()).abs();
      } else {
        return basePosition +
            (cardViewPagerHeight * (2 / 7)) +
            cardViewPagerHeight * (1 / 7) * (diffAbs - diffAbs.floor()).abs();
      }
    } else {
      if (diff >= 0) {
        return basePosition - cardViewPagerHeight * (3 / 7);
      } else {
        return basePosition + cardViewPagerHeight * (3 / 7);
      }
    }
  }

  double getCardHeight(int index) {
    double diff = (currentPostion - index).abs();

    if (diff >= 0.0 && diff < 1.0) {
      return cardMaxHeight - 120 * ((diff - diff.floor()));
    } else if (diff >= 1.0 && diff < 2.0) {
      return cardMaxHeight - 120 - 40 * ((diff - diff.floor()));
    } else {
      final height = cardMaxHeight - 160 - 40 * ((diff - diff.floor()));

      return height > 0 ? height : 0;
    }
  }

  double getFontSize(int index) {
    double diffAbs = (currentPostion - index).abs();
    diffAbs = num.parse(diffAbs.toStringAsFixed(2));

    double maxFontSize = 50;
    if (diffAbs >= 0.0 && diffAbs < 1.0) {
      if (diffAbs < 0.02) {
        diffAbs = 0;
      }

      return maxFontSize - 25 * ((diffAbs - diffAbs.floor()));
    } else if (diffAbs >= 1.0 && diffAbs < 2.0) {
      return maxFontSize - 25 - 5 * ((diffAbs - diffAbs.floor()));
    } else {
      final fontSize = maxFontSize - 30 - 15 * ((diffAbs - diffAbs.floor()));

      return fontSize > 0 ? fontSize : 0;
    }
  }
}
