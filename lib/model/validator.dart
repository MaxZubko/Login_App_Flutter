class Validator {
  static bool validateName(String text) {
    return text
        .contains(new RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"));
  }

  static bool validateEmail(String text) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(text);
  }

  static bool validatePassword(String text) {
    return text.toString().length >= 6;
  }
}

// class Validator {
//   static String validateEmail(String value) {
//     Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
//     RegExp regex =RegExp(pattern);
//     if (!regex.hasMatch(value))
//       return 'Please enter a valid email address.';
//     else
//       return null;
//   }

//   static String validatePassword(String value) {
//     Pattern pattern = r'^.{6,}$';
//     RegExp regex =RegExp(pattern);
//     if (!regex.hasMatch(value))
//       return 'Password must be at least 6 characters.';
//     else
//       return null;
//   }

//   static String validateName(String value) {
//     Pattern pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
//     RegExp regex =RegExp(pattern);
//     if (!regex.hasMatch(value))
//       return 'Please enter a name.';
//     else
//       return null;
//   }
// }
