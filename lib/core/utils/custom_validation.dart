class CustomValidation {
  static String? emptyValidation(String? val, String? errorMessage) {
    if (val == null || val.isEmpty) {
      return errorMessage;
    }
    return null;
  }
}
