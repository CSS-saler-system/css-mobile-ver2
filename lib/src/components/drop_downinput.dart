import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/resource/response/customer_response.dart';

class DropDownInput extends StatefulWidget {
  final String? label;
  final List<CustomerData> data;
  final Function(String) selectCustomer;
  const DropDownInput(
      {Key? key, this.label, required this.data, required this.selectCustomer})
      : super(key: key);

  @override
  State<DropDownInput> createState() => _DropDownInputState();
}

class _DropDownInputState extends State<DropDownInput> {
  String _selected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label ?? "",
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          GestureDetector(
              onTap: () => showModal(context),
              child: SizedBox(
                  width: double.infinity,
                  child: Text(
                      _selected.isNotEmpty ? _selected : "Select customer")))
        ],
      ),
    );
  }

  void showModal(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(8),
            height: 200,
            alignment: Alignment.center,
            child: ListView.separated(
                itemCount: widget.data.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selected = widget.data[index].name!;
                      });
                      widget.selectCustomer(widget.data[index].id ?? "");
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(widget.data[index].name!)),
                  );
                }),
          );
        });
  }
}
