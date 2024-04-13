import 'package:flightblueball/constants/colors.dart';
import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
  final size;
  Barrier({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
          color: BARRIER_COLOR,
          border: Border.all(
            width: 10,
            color: BARRIER_BORDER_COLOR,
          ),
          borderRadius: BorderRadius.circular(17)),
    );
  }
}
