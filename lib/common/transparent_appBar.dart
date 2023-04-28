import 'package:flutter/material.dart';

PreferredSizeWidget transparentAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    // title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 32)),
    backgroundColor: Colors.transparent,
      elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_rounded, color: Color(0xff444444),size: 35,),
      onPressed: () => Navigator.of(context).pop(),
    ),
    // automaticallyImplyLeading: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
        ),
      ),

  );
}