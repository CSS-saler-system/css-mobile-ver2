import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/dialog_widget.dart';
import 'package:flutter_application_1/src/configs/constants/app_images.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/resource/bloc/enteprise_bloc/enteprise_bloc.dart';
import 'package:flutter_application_1/src/resource/bloc/get_products/get_products_bloc.dart';
import 'package:flutter_application_1/src/resource/response/product_response.dart';
import 'package:flutter_application_1/src/resource/usecase/get_enteprise_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductModalSelect extends StatefulWidget {
  final String entepriseId;
  final Function(List<ProductData>) onProductSelect;
  const ProductModalSelect({
    Key? key,
    required this.entepriseId,
    required this.onProductSelect,
  }) : super(key: key);

  @override
  State<ProductModalSelect> createState() => _ProductModalSelectState();
}

class _ProductModalSelectState extends State<ProductModalSelect> {
  String _entepriseId = "";
  final List<ProductData> _productSelect = [];
  final GetProductsBloc _productsBloc = getIt<GetProductsBloc>();
  final List<ProductData> _products = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      _entepriseId = widget.entepriseId;
    });

    _productsBloc
        .add(GetProductsReqistedEvent(enteprieseId: widget.entepriseId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _productsBloc,
      child: BlocListener<GetProductsBloc, GetProductsState>(
        listener: (context, state) {
          if (state is GetProductsLoaded) {
            _products.clear();
            setState(() {
              _products.addAll(state.response.data ?? []);
            });
          }
        },
        child: Container(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Select product",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                    onTap: () => showModalProductSelect(),
                    child: const Icon(Icons.add_circle_outline))
              ],
            ),
            const SizedBox(height: 10),
            _productSelect.isEmpty
                ? const Text("No product select!")
                : Column(
                    children: [],
                  )
          ]),
        ),
      ),
    );
  }

  showModalProductSelect() async {
    if (_products.isEmpty) {
      return DialogHelper.errorAnimation(context, "Not found products data!");
    } else {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return MultiSelec(
            productSelect: _productSelect,
            products: _products,
            onProductSelected: (productSelect) {
              setState(() {
                _productSelect.addAll(productSelect
                    .where((element) => !_productSelect.contains(element)));
                _productSelect
                    .removeWhere((element) => !productSelect.contains(element));
              });
              widget.onProductSelect(_productSelect);
              // log(jsonEncode(_productSelect));
            },
          );
        },
      );
    }
  }
}

class MultiSelec extends StatefulWidget {
  final List<ProductData> products;
  final List<ProductData> productSelect;
  final Function(List<ProductData>) onProductSelected;
  const MultiSelec(
      {Key? key,
      required this.products,
      required this.productSelect,
      required this.onProductSelected})
      : super(key: key);

  @override
  State<MultiSelec> createState() => _MultiSelecState();
}

class _MultiSelecState extends State<MultiSelec> {
  final List<ProductData> _products = [];
  final List<ProductData> _productSelect = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _products.clear();
      _products.addAll(widget.products);
      _productSelect.clear();
      _productSelect.addAll(widget.productSelect);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      title: const Text("Select Products"),
      content: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: ListBody(
            children: _products
                .map((item) => CheckboxListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      secondary: Container(
                        child: item.image == null ||
                                item.image != null && item.image!.isEmpty
                            ? Image.asset(
                                AppImages.iphone12,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                item.image![0].path!,
                                fit: BoxFit.cover,
                              ),
                      ),
                      title: Text(item.name ?? "UNKNOW"),
                      value: _productSelect
                              .where((element) => element.id == item.id)
                              .isEmpty
                          ? false
                          : true,
                      onChanged: (isCheked) => _itemChange(item, isCheked),
                    ))
                .toList(),
          )),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
        ElevatedButton(
          child: const Text('Submit'),
          onPressed: () {
            widget.onProductSelected(_productSelect);
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ],
    );
  }

  _itemChange(ProductData product, bool? isCheked) {
    setState(() {
      if (isCheked != null) {
        if (isCheked) {
          _productSelect.add(product);
        } else {
          _productSelect.remove(product);
        }
      }
    });
  }
}
