import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FullPageLoadingV2 extends StatefulWidget {
  final String lottie;
  final String message;
  const FullPageLoadingV2(
      {Key? key, required this.lottie, required this.message})
      : super(key: key);

  @override
  State<FullPageLoadingV2> createState() => _FullPageLoadingV2State();
}

class _FullPageLoadingV2State extends State<FullPageLoadingV2>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              widget.lottie,
              controller: _controller,
              width: MediaQuery.of(context).size.width * 0.5,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..forward();
              },
            ),
            const SizedBox(height: 20),
            Text(widget.message, style: Theme.of(context).textTheme.headline6),
          ],
        ),
      ),
    );
  }
}
