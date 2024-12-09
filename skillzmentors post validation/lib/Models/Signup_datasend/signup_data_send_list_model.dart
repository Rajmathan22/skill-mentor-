class SignupDataSendListModel {
  final String firstname;
  final String lastname;
  final String gender;
  final String email;
  final String phonenumber;
  final String password;
  final int collegeid;
  final int departmentid;
  final int role;
  final String rollnumber;
  final String year;
  final DateTime dob;

  SignupDataSendListModel(
      {required this.firstname,
      required this.lastname,
      required this.gender,
      required this.email,
      required this.phonenumber,
      required this.password,
      required this.collegeid,
      required this.departmentid,
      required this.role,
      required this.rollnumber,
      required this.year,
      required this.dob});
}
