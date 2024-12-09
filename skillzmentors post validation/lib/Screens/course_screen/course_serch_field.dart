import 'package:flutter/material.dart';
import 'package:skillzmentors/Screens/course_screen/course_details.dart';
import 'course_test_data.dart';

// Search Category Model
class SearchCategory {
  final String title;
  final List<String> items;

  SearchCategory({required this.title, required this.items});

  factory SearchCategory.fromJson(Map<String, dynamic> json) {
    return SearchCategory(
      title: json['title'],
      items: List<String>.from(json['items']),
    );
  }
}

class CourseSearchField extends StatelessWidget {
  const CourseSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey[600]),
              const SizedBox(width: 12),
              Text(
                'Search for anything',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Search Screen
class SearchScreen extends StatefulWidget {
  final String? initialSearchTerm;

  const SearchScreen({
    Key? key,
    this.initialSearchTerm,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> topSearches = [];
  List<SearchCategory> categories = [];
  bool isLoading = true;
  List<Map<String, dynamic>> filteredCourses = [];
  List<String> suggestions = [];

  final List<String> allTitles = [
    'Advanced Web Development',
  'Android App Development',
  'Artificial Intelligence Basics',
  
  // B
  'Backend Development with Node.js',
  'Business Analytics',
  
  // C
  'Cloud Computing Fundamentals',
  'Cyber Security Essentials',
  
  // D
  'Data Science Fundamentals',
  'Digital Marketing',
  
  // E
  'Ethical Hacking',
  'E-commerce Development',
  
  // F
  'Flutter Development',
  'Frontend Development',
  
  // G
  'Game Development with Unity',
  'Graphic Design Masterclass',
  
  // H
  'HTML & CSS Fundamentals',
  'Human Resource Management',
  
  // I
  'iOS App Development',
  'Information Security',
  
  // J
  'Java Programming',
  'JavaScript Fundamentals',
  
  // K
  'Kotlin for Android',
  'Kubernetes Essentials',
  
  // L
  'Linux Administration',
  'Leadership Skills',
  
  // M
  'Machine Learning Basics',
  'Mobile App Design',
  
  // N
  'Network Security',
  'Node.js Development',
  
  // O
  'Object-Oriented Programming',
  'Operating Systems',
  
  // P
  'Python Programming',
  'Project Management',
  
  // Q
  'Quality Assurance Testing',
  'Quantum Computing Basics',
  
  // R
  'React Development',
  'Ruby Programming',
  
  // S
  'Software Engineering',
  'SQL Database Design',
  
  // T
  'Technical Writing',
  'TypeScript Essentials',
  
  // U
  'UI/UX Design',
  'Unity Game Development',
  
  // V
  'Version Control with Git',
  'Virtual Reality Development',
  
  // W
  'Web Development Bootcamp',
  'WordPress Development',
  
  // X
  'XML Programming',
  'Xamarin Development',
  
  // Y
  'YouTube Content Creation',
  'Yarn Package Manager',
  
  // Z
  'Zero to Hero in Python',
  'Zen of Programming'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialSearchTerm != null) {
      _searchController.text = widget.initialSearchTerm!;
      _performSearch(widget.initialSearchTerm!);
    }
    _searchController.addListener(() {
      _performSearch(_searchController.text);
    });
    loadSearchData();
  }

  void getSuggestions(String query) {
    setState(() {
      if (query.isEmpty) {
        suggestions = [];
      } else {
        suggestions = allTitles
            .where((title) => title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _performSearch(String searchTerm) {
    setState(() {
      if (searchTerm.isEmpty) {
        filteredCourses = [];
      } else {
        filteredCourses = coursesData
            .where((course) => (course as Map<String, dynamic>)['title']
                .toString()
                .toLowerCase()
                .contains(searchTerm.toLowerCase()))
            .map((course) => course as Map<String, dynamic>)
            .toList();
      }
    });
  }

  void loadSearchData() {
    try {
      // Load data from CourseSearchData
      setState(() {
        topSearches =
            List<String>.from(CourseSearchData['topSearches'] as List);
        categories = (CourseSearchData['categories'] as List)
            .map((category) =>
                SearchCategory.fromJson(category as Map<String, dynamic>))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error loading search data: $e');
      setState(() {
        isLoading = false;
        topSearches = [];
        categories = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: getSuggestions,
              autofocus: widget.initialSearchTerm == null,
              decoration: InputDecoration(
                hintText: 'Search for anything',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onSubmitted: (value) {
                _performSearch(value);
              },
            ),
          ),
          Expanded(
          child: suggestions.isNotEmpty
              // Show suggestions if available
              ? ListView.builder(
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final suggestion = suggestions[index];
                    return ListTile(
                      leading: const Icon(Icons.search),
                      title: Text(
                        suggestion,
                        style: const TextStyle(fontSize: 16),
                      ),
                      onTap: () {
                        setState(() {
                          _searchController.text = suggestion;
                          suggestions = [];
                        });
                      },
                      subtitle: RichText(
                        text: TextSpan(
                          children: highlightOccurrences(
                            suggestion,
                            _searchController.text,
                          ),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  },
                )
              // Show either search results or default content
              : _searchController.text.isEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSection('Top Searches', topSearches),
                          const SizedBox(height: 24),
                          _buildCategories(),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredCourses.length,
                      itemBuilder: (context, index) {
                        final course = filteredCourses[index];
                        return _buildCourseCard(course);
                      },
                    ),
        ),
          Expanded(
            child: _searchController.text.isEmpty
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSection('Top Searches', topSearches),
                        const SizedBox(height: 24),
                        _buildCategories(),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredCourses.length,
                    itemBuilder: (context, index) {
                      final course = filteredCourses[index];
                      return _buildCourseCard(course);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  List<TextSpan> highlightOccurrences(String text, String query) {
    if (query.isEmpty) return [TextSpan(text: text)];

    List<TextSpan> spans = [];
    int start = 0;
    int indexOfHighlight;
    String textLower = text.toLowerCase();
    String queryLower = query.toLowerCase();

    while ((indexOfHighlight = textLower.indexOf(queryLower, start)) != -1) {
      if (indexOfHighlight > start) {
        spans.add(TextSpan(
          text: text.substring(start, indexOfHighlight),
        ));
      }

      spans.add(TextSpan(
        text: text.substring(indexOfHighlight, indexOfHighlight + query.length),
        style: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ));

      start = indexOfHighlight + query.length;
    }

    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
      ));
    }

    return spans;
  }

  Widget _buildCourseCard(Map<String, dynamic> course) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            course['image'],
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 80,
                height: 80,
                color: Colors.grey[300],
                child: const Icon(Icons.error),
              );
            },
          ),
        ),
        title: Text(
          course['title'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'By ${course['user_name']}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Text(
              '\$${course['price']}',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        onTap: () {
          // Navigate to course details
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDetails(id: course['id']),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((item) => _buildChip(item)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Browse Categories',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...categories.map((category) => _buildCategorySection(category)),
        ],
      ),
    );
  }

  Widget _buildCategorySection(SearchCategory category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            category.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: category.items.map((item) => _buildChip(item)).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildChip(String label) {
    return GestureDetector(
      onTap: () {
        _searchController.text = label;
        // Implement search functionality here
      },
      child: Chip(
        label: Text(label),
        backgroundColor: Colors.grey[100],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
