class Job {
  final int id;
  final String jobTitle;
  final String location;
  final String salary;
  final String qualification;
  final String jobType;
  final String positionLevel;
  final String jobDescription;
  final String link;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Company company;
  final List<String> skills;

  Job({
    required this.id,
    required this.jobTitle,
    required this.location,
    required this.salary,
    required this.qualification,
    required this.jobType,
    required this.positionLevel,
    required this.jobDescription,
    required this.link,
    required this.createdAt,
    required this.updatedAt,
    required this.company,
    required this.skills,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      jobTitle: json['job_title'],
      location: json['location'],
      salary: json['salary'],
      qualification: json['qualification'],
      jobType: json['job_type'],
      positionLevel: json['position_level'],
      jobDescription: json['job_description'],
      link: json['link'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      company: Company.fromJson(json['company']),
      skills: List<String>.from(json['skills']),
    );
  }
}

class Company {
  final int id;
  final String companyName;
  final String? companyLogo;
  final String? companyWebsite;

  Company({
    required this.id,
    required this.companyName,
    required this.companyLogo,
    this.companyWebsite,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      companyName: json['company_name'],
      companyLogo: json['company_logo'],
      companyWebsite: json['company_website'],
    );
  }
}