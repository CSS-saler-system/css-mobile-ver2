import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/configs/constants/app_lotties.dart';
import 'package:lottie/lottie.dart';

class DiaLogError extends StatefulWidget {
  final String messsage;
  const DiaLogError({Key? key, required this.messsage}) : super(key: key);

  @override
  State<DiaLogError> createState() => _DialogErrorState();
}

class _DialogErrorState extends State<DiaLogError>
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
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              AppLotties.error,
              controller: _controller,
              width: MediaQuery.of(context).size.width * 0.5,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..forward();
              },
            ),
            const SizedBox(height: 30),
            Text(
              widget.messsage,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"))
          ],
        ),
      ),
    );
  }
}
