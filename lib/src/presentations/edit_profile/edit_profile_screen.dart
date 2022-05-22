import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/custom_button_widget.dart';
import 'package:flutter_application_1/src/components/srceen_scrollview.dart';
import 'package:flutter_application_1/src/presentations/edit_profile/components/form_edit.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ScrollViewBase(
        backButton: true,
        backgroundColor: const Color(0xFFFBFBFB),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          margin: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              _buildAvatar(),
              const FormEditProfile(),
              _buildButtonAction(),
            ],
          ),
        ));
  }

  Widget _buildAvatar() {
    return const CircleAvatar(
      radius: 70,
    );
  }

  Widget _buildButtonAction() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: const CustomButton(
        text: "Save",
      ),
    );
  }
}
