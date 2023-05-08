// ignore_for_file: public_member_api_docs, sort_constructors_first
class SignUpData {
  String email;
  String fullname;
  SignUpData({
    required this.email,
    required this.fullname,
  });

  String get_email() {
    return this.email;
  }

  String get_fullname() {
    return this.fullname;
  }
}
