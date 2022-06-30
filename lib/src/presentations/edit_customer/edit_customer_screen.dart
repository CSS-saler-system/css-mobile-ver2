import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/button_error.dart';
import 'package:flutter_application_1/src/components/custom_button_widget.dart';
import 'package:flutter_application_1/src/components/custom_input.dart';
import 'package:flutter_application_1/src/components/custom_textarea_input.dart';
import 'package:flutter_application_1/src/components/dialog_error.dart';
import 'package:flutter_application_1/src/components/dialog_success.dart';
import 'package:flutter_application_1/src/components/dialog_widget.dart';
import 'package:flutter_application_1/src/components/srceen_scrollview.dart';
import 'package:flutter_application_1/src/configs/constants/app_lotties.dart';
import 'package:flutter_application_1/src/configs/constants/app_router.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/presentations/full_page_loading_2/fullpage_loading_v2.dart';
import 'package:flutter_application_1/src/presentations/main/main_screen.dart';
import 'package:flutter_application_1/src/resource/bloc/create_customer_bloc/create_customer_bloc_bloc.dart';
import 'package:flutter_application_1/src/resource/bloc/customer_bloc/customer_bloc.dart';
import 'package:flutter_application_1/src/resource/bloc/get_products/get_products_bloc.dart';
import 'package:flutter_application_1/src/resource/bloc/update_customer_bloc/update_customer_bloc_bloc.dart';
import 'package:flutter_application_1/src/resource/usecase/create_customer_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/update_customer_usecase.dart';
import 'package:flutter_application_1/src/utils/validation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCustomerScreen extends StatefulWidget {
  final String customerId;
  const EditCustomerScreen({Key? key, required this.customerId})
      : super(key: key);

  @override
  State<EditCustomerScreen> createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen>
    with TickerProviderStateMixin {
  final TextEditingController _fullnameController = TextEditingController(),
      _phoneNumberController = TextEditingController(),
      _addressController = TextEditingController(),
      _birthdayController = TextEditingController(),
      _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final CustomerBloc _customerBloc = getIt<CustomerBloc>();
  final UpdateCustomerBlocBloc _updateCustomerBlocBloc =
      getIt<UpdateCustomerBlocBloc>();

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _customerBloc.add(GetCustomerDetailEvent(widget.customerId));
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _fullnameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _birthdayController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _customerBloc,
        ),
        BlocProvider(
          create: (context) => _updateCustomerBlocBloc,
        ),
      ],
      child: BlocListener<CustomerBloc, CustomerState>(
        listener: (context, state) {
          if (state is GetCustomerDetailLoaded) {
            log("GetCustomerDetailLoaded" + state.toString());
            _fullnameController.text = state.customer.name ?? "";
            _phoneNumberController.text = state.customer.phone ?? "";
            _addressController.text = state.customer.address ?? "";
            _birthdayController.text = state.customer.dob ?? "";
            _descriptionController.text = state.customer.description ?? "";
          }
        },
        child: BlocBuilder<CustomerBloc, CustomerState>(
          builder: (context, state) {
            if (state is GetProductDetailError) {
              return ScrollViewBase(
                backButton: true,
                title: "Edit customer",
                body: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: ButtonError(
                      onPressed: () {},
                    )),
              );
            } else if (state is GetCustomerDetailLoaded) {
              return ScrollViewBase(
                backButton: true,
                title: "Edit customer",
                body: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(children: [
                    const SizedBox(height: 30),
                    _buildForm(),
                    const SizedBox(height: 30),
                    _buildButton(),
                  ]),
                ),
              );
            } else {
              return const FullPageLoadingV2(
                  lottie: AppLotties.lottie_customer_search,
                  message: "Customer is loading...");
            }
          },
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInputWidget(
            controller: _fullnameController,
            label: "Full Name",
            validation: (value) => AppValidations.required(value),
          ),
          const SizedBox(height: 15),
          CustomInputWidget(
            validation: (value) => AppValidations.validatePhoneNumber(value),
            controller: _phoneNumberController,
            label: "Phone Number",
          ),
          const SizedBox(height: 15),
          CustomInputWidget(
            controller: _addressController,
            label: "Address",
            validation: (value) => AppValidations.required(value),
          ),
          const SizedBox(height: 15),
          CustomInputWidget(
            controller: _birthdayController,
            label: "Birthday",
            validation: (value) => AppValidations.required(value),
          ),
          const SizedBox(height: 15),
          CustomTextAreaInput(
            controller: _descriptionController,
            label: "Description",
            validation: (value) => AppValidations.required(value),
          )
        ],
      ),
    );
  }

  Widget _buildButton() {
    return BlocListener<UpdateCustomerBlocBloc, UpdateCustomerBlocState>(
      listener: (context, state) {
        if (state is UpdateCustomerLoading) {
          DialogHelper.onLoading(context);
        }

        if (state is UpdateCustomerLoaded) {
          DialogHelper.hideLoading(context);
          // Navigator.pushReplacementNamed(context, AppRouters.customerScreen);
          DialogHelper.successAnimation(
            context,
            "Update customer successfully!",
            routerName: AppRouters.customerScreen,
          );
        }

        if (state is UpdateCustomerError) {
          DialogHelper.hideLoading(context);
          DialogHelper.errorAnimation(
              context, "Update customer is fail, please try again!",
              serverMessage: state.failure.message);
        }
      },
      child: BlocBuilder<CustomerBloc, CustomerState>(
        builder: (context, state) {
          return CustomButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _updateCustomerBlocBloc.add(
                  UpdateCustomerEvent(
                    UpdateCustomerInput(
                        name: _fullnameController.text,
                        phone: _phoneNumberController.text,
                        dob: _birthdayController.text,
                        address: _addressController.text,
                        description: _descriptionController.text,
                        id: widget.customerId),
                  ),
                );
              }
            },
            text: "Save",
          );
        },
      ),
    );
  }
}
