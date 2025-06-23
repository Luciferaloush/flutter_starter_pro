import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.onTap,
      required this.customColor,
      required this.title,
      required this.colorTitle})
      : super(key: key);
  final void Function()? onTap;
  final Color? customColor;
  final String? title;
  final Color? colorTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: const BoxConstraints(maxWidth: 400),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: customColor,
        ),
        child: Center(
          child: Text(
            title!,
            style: TextStyle(
              color: colorTitle,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
