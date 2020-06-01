import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:vertical_view_pager/page/detail_view.dart';

final titles = [
  "AKALI",
  "CAMILE",
  "EZREAL",
  "IRELIA",
  "POPPY",
  "ZOE",
];

final subjects = [
  "THE ROGUE ASSASSIN",
  "THE STEEL SHADOW",
  "THE PRODIGAL EXPLORER",
  "THE BLADE DANCER",
  "KEEPER OF THE HAMMER",
  "THE ASPECT OF TWILIGHT",
];

class VerticalCardPager extends StatefulWidget {
  @override
  _VerticalCardPagerState createState() => _VerticalCardPagerState();
}

class _VerticalCardPagerState extends State<VerticalCardPager> {
  bool isScrolling = false;

  double currentPosition = 2.0;

  PageController controller = PageController(initialPage: 2);

  int onTapUp(
      BuildContext context, double maxHeight, double maxWidth, details) {
    print('${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    print("local offset ${localOffset.dx}, ${localOffset.dy}");

    double dx = localOffset.dx;
    double dy = localOffset.dy;

    for (int i = 0; i < 5; i++) {
      double width = getWidth(maxHeight, i);
      double height = getHeight(maxHeight, i);
      double left = (maxWidth / 2) - (width / 2);
      double top = getCardPositionTop(height, maxHeight, i);

      if (top <= dy && dy <= top + height) {
        if (left <= dx && dx <= left + width) {
          return i;
        }
      }
    }
    return -1;
  }

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {
        currentPosition = controller.page;
        print(currentPosition);
      });
    });
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
            int selectedIndex = onTapUp(
                context, constraints.maxHeight, constraints.maxWidth, details);

            if (selectedIndex == 2) {
              print(
                  "images/${(titles[currentPosition.toInt()]).toLowerCase()}_lol.gif");
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailView(
                          heroTag: titles[currentPosition.toInt()],
                          title: titles[currentPosition.toInt()],
                          subject: subjects[currentPosition.toInt()],
                          imageFileName:
                              "images/${(titles[currentPosition.toInt()]).toLowerCase()}_lol.gif",
                        )),
              );
            } else if (selectedIndex >= 0) {
              int goToPage = currentPosition.toInt() + selectedIndex - 2;
              controller.animateToPage(goToPage,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOutExpo);
            }
          }
        },
        child: Stack(
          children: [
            CardControllerWidget(
              currentPostion: currentPosition,
              cardViewPagerHeight: constraints.maxHeight,
              cardViewPagerWidth: constraints.maxWidth,
            ),
            Positioned.fill(
              child: PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 7,
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

  double getWidth(maxHeight, i) {
    double cardMaxWidth = maxHeight / 2;
    return cardMaxWidth - 60 * (i - 2).abs();
  }

  double getHeight(maxHeight, i) {
    double cardMaxHeight = maxHeight / 2;

    if (i == 2) {
      return cardMaxHeight;
    } else if (i == 0 || i == 4) {
      return cardMaxHeight - cardMaxHeight * (4 / 5) - 10;
    } else
      return cardMaxHeight - cardMaxHeight * (4 / 5);
  }
}

double getCardPositionTop(double cardHeight, double viewHeight, int i) {
  int diff = (2 - i);
  int diffAbs = diff.abs();

  double basePosition = (viewHeight / 2) - (cardHeight / 2);
  double cardMaxHeight = viewHeight / 2;

  if (diffAbs == 0) {
    return basePosition;
  }
  if (diffAbs == 1) {
    if (diff >= 0) {
      return basePosition - (cardMaxHeight * (6 / 9));
    } else {
      return basePosition + (cardMaxHeight * (6 / 9));
    }
  } else {
    if (diff >= 0) {
      return basePosition - cardMaxHeight * (8 / 9);
    } else {
      return basePosition + cardMaxHeight * (8 / 9);
    }
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
      : cardMaxHeight = cardViewPagerHeight * (1 / 2),
        cardMaxWidth = cardViewPagerHeight * (1 / 2);

  static List images = [
    // Image.asset(
    //   "images/catalina.png",
    //   fit: BoxFit.cover,
    // ),
    // Image.asset(
    //   "images/el_capitan.png",
    //   fit: BoxFit.cover,
    // ),
    // Image.asset(
    //   "images/high_sierra.png",
    //   fit: BoxFit.cover,
    // ),
    // Image.asset(
    //   "images/mojave.png",
    //   fit: BoxFit.cover,
    // ),
    // Image.asset(
    //   "images/sierra.png",
    //   fit: BoxFit.cover,
    // ),
    // Image.asset(
    //   "images/yosemite.png",
    //   fit: BoxFit.cover,
    // ),
    Image.asset(
      "images/akali_lol.gif",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "images/camile_lol.gif",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "images/ezreal_lol.gif",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "images/irelia_lol.gif",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "images/poppy_lol.gif",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "images/zoe_lol.gif",
      fit: BoxFit.cover,
    ),
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

      var cardTop = getTop(cardHeight, cardViewPagerHeight, i);

      Widget card = Positioned.directional(
          textDirection: TextDirection.ltr,
          top: cardTop,
          start: (cardViewPagerWidth / 2) - (cardWidth / 2),
          child: Hero(
            tag: titles[i],
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
                      titles[i],
                      style: titleTextStyle.copyWith(fontSize: getFontSize(i)),
                      textAlign: TextAlign.center,
                    )),
                  ],
                ),
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

  double getTop(double cardHeight, double viewHeight, int i) {
    double diff = (currentPostion - i);
    double diffAbs = diff.abs();

    double basePosition = (viewHeight / 2) - (cardHeight / 2);

    if (diffAbs == 0) {
      return basePosition;
    }
    if (diffAbs > 0.0 && diffAbs <= 1.0) {
      if (diff >= 0) {
        return basePosition - (cardMaxHeight * (6 / 9)) * diffAbs;
      } else {
        return basePosition + (cardMaxHeight * (6 / 9)) * diffAbs;
      }
    } else if (diffAbs > 1.0 && diffAbs < 2.0) {
      if (diff >= 0) {
        return basePosition -
            (cardMaxHeight * (6 / 9)) -
            cardMaxHeight * (2 / 9) * (diffAbs - diffAbs.floor()).abs();
      } else {
        return basePosition +
            (cardMaxHeight * (6 / 9)) +
            cardMaxHeight * (2 / 9) * (diffAbs - diffAbs.floor()).abs();
      }
    } else {
      if (diff >= 0) {
        return basePosition - cardMaxHeight * (8 / 9);
      } else {
        return basePosition + cardMaxHeight * (8 / 9);
      }
    }
  }

  double getCardHeight(int index) {
    double diff = (currentPostion - index).abs();

    if (diff >= 0.0 && diff < 1.0) {
      return cardMaxHeight - cardMaxHeight * (4 / 5) * ((diff - diff.floor()));
    } else if (diff >= 1.0 && diff < 2.0) {
      return cardMaxHeight -
          cardMaxHeight * (4 / 5) -
          10 * ((diff - diff.floor()));
    } else {
      final height = cardMaxHeight -
          cardMaxHeight * (4 / 5) -
          10 -
          5 * ((diff - diff.floor()));

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
