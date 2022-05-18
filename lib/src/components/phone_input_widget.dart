import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/utils/validation.dart';

class PhoneInputWidget extends StatefulWidget {
  const PhoneInputWidget({Key? key}) : super(key: key);

  @override
  State<PhoneInputWidget> createState() => _PhoneInputWidgetState();
}

class _PhoneInputWidgetState extends State<PhoneInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFFFFCD92),
          borderRadius: BorderRadius.circular(5)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "+85",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
            child: Container(
          decoration: const BoxDecoration(
              border: Border(left: BorderSide(color: Colors.white))),
          child: TextFormField(
            validator: (value) => AppValidations.validatePhoneNumber(value),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: InputBorder.none,
              filled: true,
            ),
          ),
        ))
      ]),
    );
  }
}
