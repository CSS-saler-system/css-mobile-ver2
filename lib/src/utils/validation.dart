class AppValidations {
  // phonenumber validation
  static String? validatePhoneNumber(String? value) {
    RegExp phoneRegex = RegExp(r'^\d{10}$');
    if (value != null) {
      if (value.isNotEmpty) {
        return "Phone Number is Required";
      } else if (!phoneRegex.hasMatch(value)) {
        return "Invalid Phone Number";
      }
    }
    return null;
  }
}
