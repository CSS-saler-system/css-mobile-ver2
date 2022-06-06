import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/custom_button_widget.dart';
import 'package:flutter_application_1/src/components/custom_input.dart';
import 'package:flutter_application_1/src/components/custom_textarea_input.dart';
import 'package:flutter_application_1/src/components/dialog_widget.dart';
import 'package:flutter_application_1/src/components/srceen_scrollview.dart';
import 'package:flutter_application_1/src/configs/constants/app_router.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/presentations/main/main_screen.dart';
import 'package:flutter_application_1/src/resource/bloc/create_customer_bloc/create_customer_bloc_bloc.dart';
import 'package:flutter_application_1/src/resource/usecase/create_customer_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCustomerScreen extends StatefulWidget {
  const CreateCustomerScreen({Key? key}) : super(key: key);

  @override
  State<CreateCustomerScreen> createState() => _CreateCustomerScreenState();
}

class _CreateCustomerScreenState extends State<CreateCustomerScreen> {
  late TextEditingController _fullnameController,
      _phoneNumberController,
      _addressController,
      _birthdayController,
      _descriptionController;

  @override
  void initState() {
    super.initState();

    _fullnameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _addressController = TextEditingController();
    _birthdayController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _fullnameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _birthdayController.dispose();
    _descriptionController.dispose();
  }

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
        children: [
          CustomInputWidget(
            controller: _fullnameController,
            label: "Full Name",
          ),
          const SizedBox(height: 15),
          CustomInputWidget(
            controller: _phoneNumberController,
            label: "Phone Number",
          ),
          const SizedBox(height: 15),
          CustomInputWidget(
            controller: _addressController,
            label: "Address",
          ),
          const SizedBox(height: 15),
          CustomInputWidget(
            controller: _birthdayController,
            label: "Birthday",
          ),
          const SizedBox(height: 15),
          CustomTextAreaInput(
            controller: _descriptionController,
            label: "Description",
          )
        ],
      ),
    );
  }

  Widget _buildButton() {
    return BlocProvider(
      create: (context) => getIt<CreateCustomerBlocBloc>(),
      child: BlocListener<CreateCustomerBlocBloc, CreateCustomerBlocState>(
        listener: (context, state) {
          if (state is CreateCustomerBlocLoading) {
            DialogHelper.onLoading(context);
          }

          if (state is CreateCustomerSuccess) {
            DialogHelper.hideLoading(context);
            Navigator.pushReplacementNamed(context, AppRouters.customerScreen);
          }

          if (state is CreateCustomerFailure) {
            DialogHelper.hideLoading(context);
            DialogHelper.onError(context, state.failure.message);
          }
        },
        child: BlocBuilder<CreateCustomerBlocBloc, CreateCustomerBlocState>(
          builder: (context, state) {
            return CustomButton(
              onPressed: () => BlocProvider.of<CreateCustomerBlocBloc>(context)
                  .add(CreateCustomerOnPressed(CreateCustomerInput(
                      name: _fullnameController.text,
                      phone: _phoneNumberController.text,
                      dob: _birthdayController.text,
                      address: _addressController.text,
                      description: _descriptionController.text))),
              text: "Save",
            );
          },
        ),
      ),
    );
  }
}
