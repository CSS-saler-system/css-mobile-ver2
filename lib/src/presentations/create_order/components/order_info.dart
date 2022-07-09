import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/custom_input.dart';
import 'package:flutter_application_1/src/components/drop_downinput.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/resource/bloc/customer_bloc/customer_bloc.dart';
import 'package:flutter_application_1/src/resource/response/customer_response.dart';
import 'package:flutter_application_1/src/utils/validation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderInfo extends StatefulWidget {
  final Function(String) selectCustomer;
  final TextEditingController phoneNumberControler;
  final TextEditingController addressController;
  final GlobalKey<FormState> formKey;
  final CustomerData? initCustomer;
  const OrderInfo({
    Key? key,
    required this.selectCustomer,
    required this.addressController,
    required this.phoneNumberControler,
    required this.formKey,
    this.initCustomer,
  }) : super(key: key);

  @override
  State<OrderInfo> createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  final CustomerBloc _customerBloc = getIt<CustomerBloc>();
  final List<CustomerData> _customers = [];

  @override
  void initState() {
    super.initState();
    _customerBloc.add(const GetListCustomer());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _customerBloc,
      child: BlocListener<CustomerBloc, CustomerState>(
        listener: (context, state) {
          if (state is CustomersLoaded) {
            setState(() {
              _customers.clear();
              _customers.addAll(state.customers);
            });
          }
        },
        child: Form(
          key: widget.formKey,
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(children: [
              DropDownInput(
                initData: widget.initCustomer,
                label: "Customer",
                data: _customers,
                selectCustomer: (customerId) {
                  widget.selectCustomer(customerId);
                },
              ),
              const Divider(),
              CustomInputWidget(
                label: "Phone Number",
                validation: (value) =>
                    AppValidations.validatePhoneNumber(value),
                controller: widget.phoneNumberControler,
              ),
              const Divider(),
              CustomInputWidget(
                label: "Address",
                validation: (value) => AppValidations.required(value),
                controller: widget.addressController,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
