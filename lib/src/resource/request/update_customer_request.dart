class UpdateCustomerRequest {
  String name;
  String phone;
  String dob;
  String description;
  String address;
  String id;
  AccountCreatorRequest accountCreator;

  UpdateCustomerRequest({
    required this.name,
    required this.phone,
    required this.dob,
    required this.description,
    required this.accountCreator,
    required this.address,
    required this.id,
  });
}

class AccountCreatorRequest {
  String id;

  AccountCreatorRequest({required this.id});
}
