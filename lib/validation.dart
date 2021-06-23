// TODO: Change regex, so it will be the same as in google
// example
// here ok: aaaa@aaaa
// google bad: aaaa@aaaa
RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

bool validateEmail(String emailOrig) {
  String email = emailOrig.trim();
  // valid email regexp
  return emailRegex.hasMatch(email);
}

bool validatePhone(String phoneOrig) {
  String phone = phoneOrig.trim();
  // invalid phone length (UKR) only
  if (phone.length != 13) {
    return false;
  }
  // has to start from +380
  if (phone.startsWith("+380") == false) {
    return false;
  }
  // casts to int. Plus sign (+) casts
  if (int.tryParse(phone) == null) {
    return false;
  }
  return true;
}

bool validateName(String nameOrig) {
  // get rid of spaces
  String name = nameOrig.trim();
  // invalid name length
  if ((name.length < 2) || (name.length) > 256) {
    return false;
  }
  // name must be letter or space only
  return RegExp(r"[^a-z ]", caseSensitive: false).hasMatch(name) == false;
}

bool validatePassword(String passwordOrig) {
  String password = passwordOrig.trim();
  // invalid password length
  if ((password.length < 8) || (password.length > 256)) {
    return false;
  }
  return true;
}
