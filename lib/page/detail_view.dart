import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final titleTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'Bevan',
  fontWeight: FontWeight.bold,
);

class DetailView extends StatelessWidget {
  final heroTag;
  final title;
  final subject;
  final imageFileName;

  const DetailView(
      {this.heroTag, this.title, this.subject, this.imageFileName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Hero(
          tag: heroTag,
          child: Image.asset(
            imageFileName,
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
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            width: double.infinity,
            height: 180,
            color: Colors.black.withOpacity(0.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(subject, style: titleTextStyle.copyWith(fontSize: 15)),
                  Text(
                    title,
                    style: titleTextStyle.copyWith(fontSize: 60),
                  ),
                ]),
          ),
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
