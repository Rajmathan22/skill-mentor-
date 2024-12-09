import 'package:flutter/material.dart';
import 'package:skillzmentors/Components/appbar/app_bar.dart';
import 'package:skillzmentors/Models/proflie_model/job_model.dart';
import 'package:skillzmentors/config/Colors/colors.dart';
import 'package:skillzmentors/Screens/jobs_screen/filter_screen.dart';
import 'package:skillzmentors/Screens/jobs_screen/recent_job_details.dart';

class RecentJobsSeemore extends StatefulWidget {
  final List<Job> company;

  const RecentJobsSeemore({super.key, required this.company});

  @override
  State<RecentJobsSeemore> createState() => _RecentJobsSeemoreState();
}

class _RecentJobsSeemoreState extends State<RecentJobsSeemore> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  List<Job>? filteredCompanies;
  List<Job> allcompany = [];
  List<String> searchSuggestions = [
    "Apple Inc",
    "Amazon Web Services",
    "Accenture",
    "Boeing",
    "Bank of America",
    "Cisco Systems",
    "Deloitte",
    "Dell Technologies",
    "Ernst & Young",
    "Facebook (Meta)",
    "Ford Motors",
    "Google",
    "Goldman Sachs",
    "HP Enterprise",
    "IBM",
    "Intel Corporation",
    "JPMorgan Chase",
    "Johnson & Johnson",
    "KPMG",
    "LinkedIn",
    "Microsoft",
    "Morgan Stanley",
    "Netflix",
    "Nike",
    "Oracle Corporation",
    "PwC",
    "Qualcomm",
    "Salesforce",
    "Tesla",
    "Twitter",
    "Uber",
    "Visa Inc",
    "Walmart",
    "Xerox",
    "Yahoo",
    "Zoom"
  ];
  List<String> filteredSuggestions = [];
  bool showSuggestions = false;

  @override
  void initState() {
    super.initState();
    allcompany = widget.company;
    filteredCompanies = widget.company;
  }

  // void _performSearch(String searchTerm) {
  //   setState(() {
  //     if (searchTerm.isEmpty) {
  //       filteredCompanies = widget.company;
  //       filteredSuggestions = [];
  //       showSuggestions = false;
  //     } else {
  //       showSuggestions = true;
  //       // Filter suggestions based on search term
  //       filteredSuggestions = searchSuggestions
  //           .where((suggestion) =>
  //               suggestion.toLowerCase().contains(searchTerm.toLowerCase()))
  //           .toList();

  //       // Filter companies
  //       filteredCompanies = widget.company?.where((company) {
  //         return company.companyName!
  //             .toLowerCase()
  //             .contains(searchTerm.toLowerCase());
  //       }).toList();
  //     }
  //   });
  // }

  Widget _buildSuggestionTile(String suggestion) {
    final searchTerm = _searchController.text.toLowerCase();
    final suggestionLower = suggestion.toLowerCase();
    final matchIndex = suggestionLower.indexOf(searchTerm);

    return ListTile(
      leading: const Icon(Icons.search, color: Colors.grey),
      title: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          children: [
            if (matchIndex > 0)
              TextSpan(
                text: suggestion.substring(0, matchIndex),
                style: const TextStyle(color: Colors.grey),
              ),
            TextSpan(
              text: suggestion.substring(
                  matchIndex, matchIndex + searchTerm.length),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (matchIndex + searchTerm.length < suggestion.length)
              TextSpan(
                text: suggestion.substring(matchIndex + searchTerm.length),
                style: const TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
      onTap: () => _onSuggestionSelected(suggestion),
    );
  }

  void _onSuggestionSelected(String suggestion) {
    setState(() {
      _searchController.text = suggestion;
      showSuggestions = false;
     // _performSearch(suggestion);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBack(scaffoldKey: scaffoldKey),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: TextField(
                      controller: _searchController,
                      cursorColor: white,
                     // onChanged: _performSearch,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.search,
                          size: 25.0,
                          color: Colors.blue,
                        ),
                        border: InputBorder.none,
                        hintText: "Search by company name",
                        hintStyle: TextStyle(
                            color: Colors.white, fontFamily: 'TimesNewRoman'),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  margin: const EdgeInsets.only(left: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const JobFilterScreen()));
                    },
                    icon: const Icon(
                     Icons.filter_alt_outlined,
                      color: Colors.blue, 
                    ),
                  ),
                )
              ],
            ),
          ),

          // Suggestions and Results
          Expanded(
            child: Column(
              children: [
                // Suggestions Container
                if (showSuggestions && filteredSuggestions.isNotEmpty)
                  Container(
                    color: Colors.white,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.3,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Suggestions',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: filteredSuggestions.length,
                            itemBuilder: (context, index) {
                              return _buildSuggestionTile(
                                  filteredSuggestions[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                // Results List
                Expanded(
                  child: ListView.builder(
                    itemCount: allcompany.length,
                    padding: const EdgeInsets.only(bottom: 16),
                    itemBuilder: (context, index) {
                      var recent = allcompany[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecentJobDetails(
                                  recentcompany: recent,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              const SizedBox(height: 6),
                             // RecentJobCard(company: recent),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
