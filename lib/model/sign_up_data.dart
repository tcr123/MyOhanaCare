class SignUpData {
  String email;
  String password;
  String name;
  String role;
  int age;
  String married;
  String children;
  String menstrual;

  SignUpData ({
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    required this.age,
    this.married = "",
    this.children = "",
    this.menstrual = ""
  });
}