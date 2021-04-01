import 'package:flutter/material.dart';
import 'package:flutter_skills_test/utils/utils.dart';

class CarItem extends StatelessWidget {
  final String heading;
  final String data;
  CarItem(this.heading, this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          appText(heading),
          appText(data),
        ],
      ),
    );
  }
}
