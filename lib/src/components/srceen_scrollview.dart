import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScrollViewBase extends StatefulWidget {
  final Widget? body;
  final Color? backgroundColor;
  final bool backButton;
  final String title;
  final Color? appBarColor;
  const ScrollViewBase(
      {Key? key,
      this.body,
      this.backgroundColor,
      this.backButton = false,
      this.title = "",
      this.appBarColor})
      : super(key: key);

  @override
  State<ScrollViewBase> createState() => _ScrollViewBaseState();
}

class _ScrollViewBaseState extends State<ScrollViewBase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight:widget.appBarColor == Colors.transparent ? 0 : AppBar().preferredSize.height,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: widget.appBarColor ?? Colors.orange,
        elevation: widget.appBarColor == Colors.transparent ? 0 : 1,
        leading: widget.backButton
            ? Container(
                margin: const EdgeInsets.only(top: 10, left: 20),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_ios),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  color: Colors.white,
                ),
              )
            : const SizedBox(),
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: widget.backgroundColor ?? Colors.white,
      body: SafeArea(
        child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: widget.body,
                ))),
      ),
    );
  }
}
