class AppValidations {
  // phonenumber validation
  static String? validatePhoneNumber(String? value) {
    RegExp phoneRegex = RegExp(r'(84|0[3|5|7|8|9])+([0-9]{8})$');
    if (value != null) {
      if (value.isNotEmpty) {
        return "Phone Number is Required";
      } else if (!phoneRegex.hasMatch(value)) {
        return "Invalid Phone Number";
      }
    }
    return null;
  }

  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    return null;
  }
}
