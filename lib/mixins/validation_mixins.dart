class ValidationMixin {
  String validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please don\'t leave the field empty!!!';
    } else if (!value.contains('@')) {
      return 'Please enter a valid email!!!';
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please don\'t leave this field empty!!!';
    } else if (value.length < 4) {
      return 'Password must be of at least 4 characters';
    }
    return null;
  }
}
