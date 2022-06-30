import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeInput extends StatefulWidget {
  final Function(String?)? onCompleted;
  const PinCodeInput({Key? key, this.onCompleted}) : super(key: key);

  @override
  State<PinCodeInput> createState() => _PinCodeInputState();
}

class _PinCodeInputState extends State<PinCodeInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PinCodeTextField(
        onCompleted: widget.onCompleted,
        appContext: context,
        length: 6,
        keyboardType: TextInputType.number,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          borderWidth: 0,
          inactiveFillColor: Colors.grey[300],
          activeColor: Colors.black,
          activeFillColor: Colors.grey[300],
          selectedFillColor: Colors.grey[300],
        ),
        onChanged: (value) {},
      ),
    );
  }
}
