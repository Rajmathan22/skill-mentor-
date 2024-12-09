class UserReport {
  final String name;
  final String email;
  final String report;

  UserReport({required this.name, required this.email, required this.report});

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'report': report,
      };

  static UserReport fromJson(Map<String, dynamic> json) => UserReport(
        name: json['name'],
        email: json['email'],
        report: json['report'],
      );
}
