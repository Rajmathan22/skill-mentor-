// import 'package:flutter/material.dart';

// class AvailableJobs {
//   final String imagepath;
//   final int availabilitycount;
//   final String availabilityname;
//   final Color textcolor;

//   AvailableJobs({
//     required this.imagepath,
//     required this.availabilitycount,
//     required this.availabilityname,
//     required this.textcolor,
//   });

//   Widget buildAvailability() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         width: 120,
//         height: 160,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12.0),
//           color: Colors.blue,
//           image: DecorationImage(
//             image: AssetImage(imagepath),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12.0),
//                   color: Colors.black.withOpacity(0.8)),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   availabilityname,
//                   style: TextStyle(
//                       color: textcolor,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500 , fontFamily: 'TimesNewRoman'),
//                 ),
//                 Text(
//                   availabilitycount.toString(),
//                   style: TextStyle(
//                       color: textcolor,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//info: this is for Recent Company
class RecentCompany {
  final String? companyName;
  final String? job;
  final String? city;
  final String? sallary;
  final String? image;
  final String? jobtype;
  final String? jobOpportunity;
  final String? aboutCompany;
  final String? experiencelevel;
  final String? workplace;
  final String? level;
  final String? discription;
  final String? qualifications;
  final List<String>? skillsneed;
  final List<String>? jobResponsbilities;

  final List<String>? tag;
  final String? location;
  RecentCompany(
      {this.city,
      this.job,
      this.companyName,
      this.sallary,
      this.discription,
      this.workplace,
      this.level,
      this.tag,
      this.image,
      this.qualifications,
      this.jobtype,
      this.skillsneed,
      this.jobOpportunity,
      this.jobResponsbilities,
      this.aboutCompany,
      this.experiencelevel,
      this.location});
}
