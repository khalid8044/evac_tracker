// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart'; // Import slide_to_act package

class SlideToAct extends StatefulWidget {
  const SlideToAct({
    super.key,
    this.width,
    this.height,
    required this.text,
    required this.onSubmit,
    this.icon,
    this.innerColor,
    this.outerColor,
    this.iconSize,
    this.textColor,
  });

  final double? width;
  final double? height;
  final String text;
  final Future<dynamic> Function() onSubmit;
  final Widget? icon;
  final Color? innerColor;
  final Color? outerColor;
  final double? iconSize;
  final Color? textColor;

  @override
  State<SlideToAct> createState() => _SlideToActState();
}

class _SlideToActState extends State<SlideToAct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: SlideAction(
        text: widget.text,
        textStyle: TextStyle(
          color: widget.textColor ?? Colors.black, // Set the text color
        ),
        onSubmit: widget.onSubmit,
        innerColor: widget.innerColor ?? Colors.white,
        outerColor: widget.outerColor ?? Colors.blue,
        sliderButtonIcon: widget.icon ?? Icon(Icons.arrow_forward),
        sliderButtonIconSize: widget.iconSize ?? 24.0, // Set the icon size
      ),
    );
  }
}
