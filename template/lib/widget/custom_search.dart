
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearch extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final void Function()? onTap;
  final bool isIcon;
  const CustomSearch({
    super.key,
    required this.hint,
    required this.controller,
     this.onTap,
     this.isIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.r,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hint,
             suffixIcon:isIcon ? InkWell(
              onTap: onTap,
              child: Icon(Icons.search_outlined),
            ): null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.white
        ),
      ),
    );
  }
}
