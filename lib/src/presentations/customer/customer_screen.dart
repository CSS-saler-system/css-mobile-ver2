import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/srceen_scrollview.dart';
import 'package:flutter_application_1/src/configs/constants/app_router.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return ScrollViewBase(
      backButton: true,
      title: "Customer",
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildFormSearch(),
          const SizedBox(height: 15),
          _buildTextAdd(),
        ]),
      ),
    );
  }

  Widget _buildFormSearch() {
    return const TextField(
      decoration: InputDecoration(
        labelText: "Search",
        prefixIcon: Icon(Icons.search),
      ),
    );
  }

  Widget _buildTextAdd() {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed(AppRouters.createCustomerScreen),
      child: const Text(
        "+ Add new customer",
        style: TextStyle(color: Colors.orange),
      ),
    );
  }
}
