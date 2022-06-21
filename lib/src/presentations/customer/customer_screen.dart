import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/components/srceen_scrollview.dart';
import 'package:flutter_application_1/src/configs/constants/app_color.dart';
import 'package:flutter_application_1/src/configs/constants/app_router.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/resource/bloc/customer_bloc/customer_bloc.dart';
import 'package:flutter_application_1/src/resource/response/customer_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final CustomerBloc _customerBloc = getIt<CustomerBloc>();
  final List<CustomerData> customers = [];

  @override
  void initState() {
    super.initState();

    _customerBloc.add(const GetListCustomer());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: AppBar().preferredSize.height,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: AppColors.primarycolor,
        elevation: 1,
        leading: Container(
          margin: const EdgeInsets.only(top: 10, left: 20),
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Customers",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildFormSearch(),
          const SizedBox(height: 15),
          _buildTextAdd(),
          const SizedBox(height: 15),
          _buildListCustomer(),
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
        style: TextStyle(color: AppColors.primarycolor),
      ),
    );
  }

  Widget _buildListCustomer() {
    return Flexible(
        child: BlocProvider(
      create: (context) => _customerBloc,
      child: BlocBuilder<CustomerBloc, CustomerState>(
        builder: (context, state) {
          if (state is CustomersLoaded) {
            return ListView.builder(
              itemCount: state.customers.length,
              itemBuilder: (context, index) {
                final customer = state.customers[index];
                return GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(
                      AppRouters.editCustomerScreen,
                      arguments: {"customerId": customer.id}),
                  child: Card(
                    child: ListTile(
                      title: Text(customer.name ?? ""),
                      subtitle: Text(customer.dob ?? ""),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                      // onTap: () => Navigator.of(context).pushNamed(
                      //     AppRouters.detailCustomerScreen,
                      //     arguments: customer),
                    ),
                  ),
                );
              },
            );
          }

          if (state is CustomerLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return const SizedBox.shrink();
        },
      ),
    ));
  }
}
