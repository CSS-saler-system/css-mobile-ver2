import 'package:flutter/material.dart';

class ScrollViewBase extends StatefulWidget {
  final Widget? body;
  const ScrollViewBase({Key? key, this.body}) : super(key: key);

  @override
  State<ScrollViewBase> createState() => _ScrollViewBaseState();
}

class _ScrollViewBaseState extends State<ScrollViewBase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: widget.body,
              ))),
    );
  }
}
