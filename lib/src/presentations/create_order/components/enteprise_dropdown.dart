import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/resource/response/customer_response.dart';
import 'package:flutter_application_1/src/resource/response/enteprise_response.dart';

class EntepriseDropDownInput extends StatefulWidget {
  final String? label;
  final List<EntepriseData> data;
  final Function(String) selectEnteprise;
  final CustomerData? initData;
  const EntepriseDropDownInput({
    Key? key,
    this.label,
    required this.data,
    required this.selectEnteprise,
    this.initData,
  }) : super(key: key);

  @override
  State<EntepriseDropDownInput> createState() =>
      _EnterpriseDropDownInputState();
}

class _EnterpriseDropDownInputState extends State<EntepriseDropDownInput> {
  String _selected = "";

  @override
  void initState() {
    super.initState();
    if (widget.initData != null) {
      setState(() {
        _selected = widget.initData?.name ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              _selected.isNotEmpty ? _selected : "Select Enteprise",
            ),
          ),
        )
      ],
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
                      widget.selectEnteprise(widget.data[index].id ?? "");
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
