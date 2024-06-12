class TValidator{
  /// EMPTY TEXT VALIDARION
  static String? validateEmptyText(String? fieldName, String? value){
    if(value == null || value.isEmpty){
      return "$fieldName is required.";
    }
    return null;
  }

  static String? stringValue(String? value){
    if(value == null || value.isEmpty){
      return "Please Enter correct value";
    }
    return null;
  }


  static String ? validateEmail(String? value){
    if(value == null || value.isEmpty){
      return "Email is Required.";
    }

    //  REGULAR EXPRESSION FOR EMAIL VALIDATION
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if(!emailRegExp.hasMatch(value)){
      return "Invalid email address.";
    }
    return null;
  }


  static String? validatePassword(String? value){
    if(value == null || value.isEmpty){
      return "Password is required.";
    }

    //CHECK FOR MINIMUM PASSWORD LENGTH
    if(value.length < 6){
      return"Password must be at least 6 character long.";
    }

    //CHECK FOR UPPERCASE LETTERS
    if(!value.contains(RegExp(r'[A-Z]'))){
      return "Password must contain at least one uppercase letter.";
    }

    //CHECK FOR NUMBERS
    if(!value.contains(RegExp(r'[0-9]'))){
      return "Password must contain at least one number";
    }

    //CHECK FOR THE SPECIAL CHARACTERS
    if(!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
      return "Password must contain at least one special character.";
    }
    return null;
  }

  static String? validatePhoneNumber(String? value){
    if(value == null || value.isEmpty){
      return"Phone number is required.";
    }

    //REGULAR EXPRESSION FOR THE PHONE NUMBER VALIDATION
    final phoneRegEXp = RegExp(r'^\d{10}$');


    if(!phoneRegEXp.hasMatch(value)){
      return "Invalid phone number format(10 digit)";
    }
     return null;
  }
}