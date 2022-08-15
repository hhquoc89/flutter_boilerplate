class Validator {
  static var passwordRegex = RegExp(r"\d");

  static bool isEmptyString(String str) {
    return (str.trim() == '');
  }

  static bool isValidEmail(String email) {
    final _emailRegExp =
        RegExp('[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}');
    return _emailRegExp.hasMatch(email);
  }

  static bool isAbleToConvertToNumber(String data) {
    final validNumberReg = RegExp(r"^(\d+(\,\d{3})*(\.\d{1,})?)?$");
    return validNumberReg.hasMatch(data.trim());
  }

  static bool isPhoneValid(String data) {
    final reg = RegExp(r"(84|0[3|5|7|8|9])+([0-9]{8})\b");
    return reg.hasMatch(data);
  }

  static isPasswordValid(String? p1) {
    return p1 != null &&
        p1.trim().isNotEmpty &&
        RegExp(r"[^ ]\ *([a-z.0-9])*\d").hasMatch(p1) &&
        p1.length == 6;
  }

  static isValidHTML(String? p1) {
    return p1 != null &&
        p1.trim().isNotEmpty &&
        RegExp(r"<([^\/][^\s]*?).*?(?:\/>|>(?:.|\n)*?<\/\1>)").hasMatch(p1);
  }
}
