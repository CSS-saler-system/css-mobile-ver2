import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/custom_input.dart';

class FormEditProfile extends StatefulWidget {
  const FormEditProfile({Key? key}) : super(key: key);

  @override
  State<FormEditProfile> createState() => _FormEditProfileState();
}

class _FormEditProfileState extends State<FormEditProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(children: [
        CustomInputWidget(label: "Full name", textRequired: true),
        const SizedBox(height: 10),
        CustomInputWidget(label: "Phone Number", textRequired: true),
        const SizedBox(height: 10),
        CustomInputWidget(label: "Email"),
        const SizedBox(height: 10),
        CustomInputWidget(label: "Address"),
      ]),
    );
  }
}
