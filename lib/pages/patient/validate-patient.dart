class Validate {
  RegExp regexCapital = RegExp(r'^(?=.*?[A-Z])');

  RegExp regexSmalll = RegExp(r'^(?=.*?[a-z])');

  RegExp regexNumber = RegExp(r'^(?=.*?[0-9])');

  RegExp regexSpecial = RegExp(r'^(?=.*?[#?!@$%^&*-])');

  bool validateName(String fname) {
    if (fname.isEmpty || fname == "") {
      return true;
    }
    if (regexSpecial.hasMatch(fname) || regexNumber.hasMatch(fname)) {
      return true;
    } else {
      return false;
    }
  }

  bool isTrueNumber(String number) {
    if (regexNumber.hasMatch(number) && number.length <= 3) {
      return false;
    } else {
      return true;
    }
  }

  bool isTrueBloodOxygen(String number) {
    if (regexNumber.hasMatch(number) && number.length <= 2) {
      return false;
    } else {
      return true;
    }
  }

  bool validateAddress(String address) {
    if (regexSpecial.hasMatch(address) || address.length < 5) {
      return true;
    } else {
      return false;
    }
  }

  bool validatePhoneNumber(String phoneNumber) {
    if (regexNumber.hasMatch(phoneNumber) && phoneNumber.length == 10) {
      return false;
    } else {
      return true;
    }
  }

  bool validateHeightandWeight(String number) {
    if (regexNumber.hasMatch(number)) {
      return false;
    } else {
      return true;
    }
  }

  bool validateSlots(String number) {
    if (regexNumber.hasMatch(number) && number.length <= 5) {
      return false;
    } else {
      return true;
    }
  }
}
