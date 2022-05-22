import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/custom_button_widget.dart';
import 'package:flutter_application_1/src/components/custom_input.dart';
import 'package:flutter_application_1/src/components/srceen_scrollview.dart';

class CreateCustomerScreen extends StatefulWidget {
  const CreateCustomerScreen({Key? key}) : super(key: key);

  @override
  State<CreateCustomerScreen> createState() => _CreateCustomerScreenState();
}

class _CreateCustomerScreenState extends State<CreateCustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return ScrollViewBase(
      backButton: true,
      title: "Add new customer",
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(children: [
          const SizedBox(height: 30),
          _buildForm(),
          const SizedBox(height: 30),
          _buildButton(),
        ]),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          CustomInputWidget(
            label: "Full Name",
          ),
          SizedBox(height: 15),
          CustomInputWidget(
            label: "Phone Number",
          ),
          SizedBox(height: 15),
          CustomInputWidget(
            label: "Address",
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return CustomButton(
      onPressed: () {},
      text: "Save",
    );
  }
}
