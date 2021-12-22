import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final bool isActive;
  final String text;

  const FilterButton({Key? key, required this.isActive, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: Container(
            // padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isActive ? Colors.green : Colors.transparent,
                  width: 4,
                )),
            child: SizedBox(
                height: 20, width: 40, child: Center(child: Text(text)))));
  }
}
