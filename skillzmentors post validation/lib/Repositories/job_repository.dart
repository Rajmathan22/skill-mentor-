import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skillzmentors/Models/proflie_model/job_model.dart';

class JobRepository {
  final String apiUrl = 'https://skillzmentors.vercel.app/api/api/jobs/';
  final String bearerToken = '3|w6mdLaZZkR4P3ncTMtp3RWNBflWlNUqrXVR8wzM3b7e77c85';

  Future<Map<String, dynamic>> fetchJobs(int page) async {
    final response = await http.get(
      Uri.parse('$apiUrl?page=$page'),
      headers: {
        'Authorization': 'Bearer $bearerToken',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Job> jobs = (data['jobs']['data'] as List)
          .map((jobJson) => Job.fromJson(jobJson))
          .toList();
      return {
        'jobs': jobs,
        'nextPageUrl': data['jobs']['next_page_url'],
      };
    } else {
      throw Exception('Failed to load jobs');
    }
  }
}