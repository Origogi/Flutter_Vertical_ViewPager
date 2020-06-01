import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailView extends StatelessWidget {
  final heroTag;
  final imageFileName;

  const DetailView({this.heroTag, this.imageFileName});

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
          padding: EdgeInsets.only(left : 5, top: 45),
          child: CustomBackButton())
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
