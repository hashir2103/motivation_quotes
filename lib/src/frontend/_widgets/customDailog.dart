import 'package:flutter/material.dart';
import 'package:motivation_quotes/src/AppConfigurations/TextStyles.dart';

class CustomDailogBox extends StatefulWidget {
  final String title, description;
  CustomDailogBox({this.title, this.description});

  @override
  _CustomDailogBoxState createState() => _CustomDailogBoxState();
}

class _CustomDailogBoxState extends State<CustomDailogBox> {
  final double _borderRadius = 10;
  bool _visble = true;

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    Future.delayed(Duration(milliseconds: 2500)).then((value) {
      if (this.mounted) {
        setState(() {
          _visble = false;
        });
        Navigator.pop(context);
      }
    });
    return Visibility(
      visible: _visble,
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              bottom: 20,
              right: 0,
              left: 0,
              child: Container(
                  width: _width,
                  // margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Color(0xff434c51),
                    borderRadius: BorderRadius.circular(_borderRadius),
                  ),
                  child: Text(
                    widget.description,
                    style: alertText,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
