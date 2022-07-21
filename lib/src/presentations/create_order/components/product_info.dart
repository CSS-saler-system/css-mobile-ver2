import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/drop_downinput.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/presentations/create_order/components/enteprise_dropdown.dart';
import 'package:flutter_application_1/src/presentations/create_order/components/item_product.dart';
import 'package:flutter_application_1/src/presentations/create_order/components/product_select_modal.dart';
import 'package:flutter_application_1/src/resource/bloc/enteprise_bloc/enteprise_bloc.dart';
import 'package:flutter_application_1/src/resource/bloc/get_products/get_products_bloc.dart';
import 'package:flutter_application_1/src/resource/response/enteprise_response.dart';
import 'package:flutter_application_1/src/resource/response/product_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductInfo extends StatefulWidget {
  final Function(List<ProductOrder>) productOrder;
  const ProductInfo({Key? key, required this.productOrder}) : super(key: key);

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  final EntepriseBloc _entepriseBloc = getIt<EntepriseBloc>();
  final List<EntepriseData> _enteprises = [];
  late String entepriseId = "";
  late List<ProductOrder> _productOrder = [];

  @override
  void initState() {
    super.initState();
    _entepriseBloc.add(GetListEntepriseEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) => _entepriseBloc,
        child: BlocListener<EntepriseBloc, EntepriseState>(
          listener: (context, state) {
            if (state is GetListEntepriseLoaded) {
              _enteprises.clear();
              _enteprises.addAll(state.enteprises);
            }
          },
          child: Column(
            children: [
              EntepriseDropDownInput(
                // initData: ,
                label: "Enteprise",
                data: _enteprises,
                selectEnteprise: (id) => setState(() => entepriseId = id),
              ),
              SizedBox(height: entepriseId.isNotEmpty ? 10 : 0),
              entepriseId.isNotEmpty
                  ? ProductModalSelect(
                      entepriseId: entepriseId,
                      onProductSelect: (productSelected) {
                        setState(() {
                          _productOrder = productSelected
                              .map(
                                (e) => ProductOrder(
                                  orderQuantiry: 1,
                                  image: e.image,
                                  name: e.name ?? "UNKNOW",
                                  price: e.price,
                                  id: e.id ?? "",
                                ),
                              )
                              .toList();
                        });
                        widget.productOrder(_productOrder);
                      },
                    )
                  : const SizedBox(),
              Column(
                children: _productOrder
                    .map((e) => ItemProductOrder(
                          product: e,
                          onChange: (quantity) {
                            if (quantity > 0) {
                              _productOrder[_productOrder.indexOf(e)]
                                  .orderQuantiry = quantity;
                            } else {
                              _productOrder.remove(e);
                            }
                            widget.productOrder(_productOrder);
                          },
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductOrder {
  int orderQuantiry;
  final String name;
  final List<ProductImageData>? image;
  final double? price;
  final String id;
  ProductOrder({
    required this.orderQuantiry,
    required this.image,
    required this.name,
    required this.price,
    required this.id,
  });
}
