class CreateCustomerRequest {
  String name;
  String phone;
  String dob;
  String description;
  String address;
  AccountCreatorRequest accountCreator;

  CreateCustomerRequest({
    required this.name,
    required this.phone,
    required this.dob,
    required this.description,
    required this.accountCreator,
    required this.address,
  });
}

class AccountCreatorRequest {
  String id;

  AccountCreatorRequest({required this.id});
}
