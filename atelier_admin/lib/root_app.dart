import 'package:atelier_admin/constraints/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Welcome back" , style: AppTextStyles.h1,),
        ),
      ),
    );
  }
}
