import 'package:flutter/material.dart';
import 'package:forget_pass_word/handel_pass_word.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HandelPassWord(),
    );
  }
}
