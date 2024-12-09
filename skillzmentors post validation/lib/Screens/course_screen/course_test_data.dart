const double appPadding = 25.0;
const double spacer = 50.0;
const double smallSpacer = 30.0;
const double miniSpacer = 10.0;
const UserProfile = {
  "image": "assets/images/user_profile.jpg",
  "full_name": "Robert Williams",
  "email": "robert.williams@email.com"
};
const String assetImg = 'assets/images/';

const List HomePageCategoryJson = [
  {
    'icon': 'assets/images/code_icon.svg',
    'title': 'Free Course',
  },
  {
    'icon': 'assets/images/brush_icon.svg',
    'title': 'Paid Course',
  },
  {
    'icon': 'assets/images/bag_icon.svg',
    'title': 'Offer Course',
  },
];

const Promotion = {
  'image': 'assets/images/dog_reading_vector.svg',
  'title': 'Get 60% Off',
  'subTitle': 'Exclusive for UI/UX Designing.'
};
const List coursesData = [
  {
    'id': 1,
    'image': 'https://images.unsplash.com/photo-1575089976121-8ed7b2a54265?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=987&q=80',
    'video': '20',
    'title': 'Web Apps with React and Firebase Introduction',
    'user_profile': 'https://images.unsplash.com/photo-1601582589907-f92af5ed9db8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
    'user_name': 'Jonathan',
    'instructor': 'Jonathan Smith',
    'price': '30.00',
    'rating': 4.5,
    'stars': 4.5,
    'reviews': 850,
    'enrolled': 1250,
    'description': 'Learn to build modern web applications using React and Firebase. Master front-end development and backend integration.',
    'what_you_learn': [
      'Build React applications from scratch',
      'Work with Firebase authentication',
      'Deploy web applications',
      'Implement real-time databases'
    ],
    'demo_video':'https://www.youtube.com/watch?v=ZK-rNEhJIDs',
    'course_syllabus': [
      'Introduction to React',
      'Firebase Setup',
      'Authentication',
      'Database Integration',
      'Final Project'
    ],
    'requirements': [
      'Basic JavaScript knowledge',
      'Understanding of HTML/CSS',
      'Computer with internet connection',
      'Code editor installed'
    ],
  },
  {
    'id': 2,
    'image': 'https://images.unsplash.com/photo-1618788372246-79faff0c3742?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=927&q=80',
    'video': '20',
    'title': 'Web Apps with React and Firebase Introduction',
    'user_profile': 'https://images.unsplash.com/photo-1601582589907-f92af5ed9db8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
    'user_name': 'Jonathan',
    'instructor': 'Jonathan Smith',
    'price': '30.00',
    'rating': 4.5,
    'stars': 4.5,
    'reviews': 850,
    'enrolled': 1250,
    'description': 'Learn to build modern web applications using React and Firebase. Master front-end development and backend integration.',
    'what_you_learn': [
      'Build React applications from scratch',
      'Work with Firebase authentication',
      'Deploy web applications',
      'Implement real-time databases'
    ],
    'demo_video':'https://www.youtube.com/watch?v=ZK-rNEhJIDs',
    'course_syllabus': [
      'Introduction to React',
      'Firebase Setup',
      'Authentication',
      'Database Integration',
      'Final Project'
    ],
    'requirements': [
      'Basic JavaScript knowledge',
      'Understanding of HTML/CSS',
      'Computer with internet connection',
      'Code editor installed'
    ],
  },{
    'id': 3,
    'image': 'https://images.unsplash.com/photo-1581287053822-fd7bf4f4bfec?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2101&q=80',
    'video': '20',
    'title': 'Web Apps with React and Firebase Introduction',
    'user_profile': 'https://images.unsplash.com/photo-1601582589907-f92af5ed9db8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
    'user_name': 'Jonathan',
    'instructor': 'Jonathan Smith',
    'price': '30.00',
    'rating': 4.5,
    'stars': 4.5,
    'reviews': 850,
    'enrolled': 1250,
    'description': 'Learn to build modern web applications using React and Firebase. Master front-end development and backend integration.',
    'what_you_learn': [
      'Build React applications from scratch',
      'Work with Firebase authentication',
      'Deploy web applications',
      'Implement real-time databases'
    ],
    'demo_video':'https://www.youtube.com/watch?v=ZK-rNEhJIDs',
    'course_syllabus': [
      'Introduction to React',
      'Firebase Setup',
      'Authentication',
      'Database Integration',
      'Final Project'
    ],
    'requirements': [
      'Basic JavaScript knowledge',
      'Understanding of HTML/CSS',
      'Computer with internet connection',
      'Code editor installed'
    ],
  },{
    'id': 4,
    'image': 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2072&q=80',
    'video': '20',
    'title': 'Web Apps with React and Firebase Introduction',
    'user_profile': 'https://images.unsplash.com/photo-1601582589907-f92af5ed9db8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
    'user_name': 'Jonathan',
    'instructor': 'Jonathan Smith',
    'price': '30.00',
    'rating': 4.5,
    'stars': 4.5,
    'reviews': 850,
    'enrolled': 1250,
    'description': 'Learn to build modern web applications using React and Firebase. Master front-end development and backend integration.',
    'what_you_learn': [
      'Build React applications from scratch',
      'Work with Firebase authentication',
      'Deploy web applications',
      'Implement real-time databases'
    ],
    'demo_video':'https://www.youtube.com/watch?v=ZK-rNEhJIDs',
    'course_syllabus': [
      'Introduction to React',
      'Firebase Setup',
      'Authentication',
      'Database Integration',
      'Final Project'
    ],
    'requirements': [
      'Basic JavaScript knowledge',
      'Understanding of HTML/CSS',
      'Computer with internet connection',
      'Code editor installed'
    ],
  },{
    'id': 5,
    'image':  'https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2015&q=80',
    'video': '20',
    'title': 'Web Apps with React and Firebase Introduction',
    'user_profile': 'https://images.unsplash.com/photo-1601582589907-f92af5ed9db8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
    'user_name': 'Jonathan',
    'instructor': 'Jonathan Smith',
    'price': '30.00',
    'rating': 4.5,
    'stars': 4.5,
    'reviews': 850,
    'enrolled': 1250,
    'description': 'Learn to build modern web applications using React and Firebase. Master front-end development and backend integration.',
    'what_you_learn': [
      'Build React applications from scratch',
      'Work with Firebase authentication',
      'Deploy web applications',
      'Implement real-time databases'
    ],
    'demo_video':'https://www.youtube.com/watch?v=ZK-rNEhJIDs',
    'course_syllabus': [
      'Introduction to React',
      'Firebase Setup',
      'Authentication',
      'Database Integration',
      'Final Project'
    ],
    'requirements': [
      'Basic JavaScript knowledge',
      'Understanding of HTML/CSS',
      'Computer with internet connection',
      'Code editor installed'
    ],
  },{
    'id': 6,
    'image': 'https://images.unsplash.com/photo-1626785774573-4b799315345d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2071&q=80',
    'video': '20',
    'title': 'Web Apps with React and Firebase Introduction',
    'user_profile': 'https://images.unsplash.com/photo-1601582589907-f92af5ed9db8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
    'user_name': 'Jonathan',
    'instructor': 'Jonathan Smith',
    'price': '30.00',
    'rating': 4.5,
    'stars': 4.5,
    'reviews': 850,
    'enrolled': 1250,
    'description': 'Learn to build modern web applications using React and Firebase. Master front-end development and backend integration.',
    'what_you_learn': [
      'Build React applications from scratch',
      'Work with Firebase authentication',
      'Deploy web applications',
      'Implement real-time databases'
    ],
    'demo_video':'https://www.youtube.com/watch?v=ZK-rNEhJIDs',
    'course_syllabus': [
      'Introduction to React',
      'Firebase Setup',
      'Authentication',
      'Database Integration',
      'Final Project'
    ],
    'requirements': [
      'Basic JavaScript knowledge',
      'Understanding of HTML/CSS',
      'Computer with internet connection',
      'Code editor installed'
    ],
  },{
    'id': 7,
    'image':   'https://images.unsplash.com/photo-1558655146-9f40138edfeb?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1064&q=80',
    'video': '20',
    'title': 'Web Apps with React and Firebase Introduction',
    'user_profile': 'https://images.unsplash.com/photo-1601582589907-f92af5ed9db8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
    'user_name': 'Jonathan',
    'instructor': 'Jonathan Smith',
    'price': '30.00',
    'rating': 4.5,
    'stars': 4.5,
    'reviews': 850,
    'enrolled': 1250,
    'description': 'Learn to build modern web applications using React and Firebase. Master front-end development and backend integration.',
    'what_you_learn': [
      'Build React applications from scratch',
      'Work with Firebase authentication',
      'Deploy web applications',
      'Implement real-time databases'
    ],
    'demo_video':'https://www.youtube.com/watch?v=ZK-rNEhJIDs',
    'course_syllabus': [
      'Introduction to React',
      'Firebase Setup',
      'Authentication',
      'Database Integration',
      'Final Project'
    ],
    'requirements': [
      'Basic JavaScript knowledge',
      'Understanding of HTML/CSS',
      'Computer with internet connection',
      'Code editor installed'
    ],
  },{
    'id': 8,
    'image': 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2015&q=80',
    'video': '20',
    'title': 'Web Apps with React and Firebase Introduction',
    'user_profile': 'https://images.unsplash.com/photo-1601582589907-f92af5ed9db8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
    'user_name': 'Jonathan',
    'instructor': 'Jonathan Smith',
    'price': '30.00',
    'rating': 4.5,
    'stars': 4.5,
    'reviews': 850,
    'enrolled': 1250,
    'description': 'Learn to build modern web applications using React and Firebase. Master front-end development and backend integration.',
    'what_you_learn': [
      'Build React applications from scratch',
      'Work with Firebase authentication',
      'Deploy web applications',
      'Implement real-time databases'
    ],
    'demo_video':'https://www.youtube.com/watch?v=ZK-rNEhJIDs',
    'course_syllabus': [
      'Introduction to React',
      'Firebase Setup',
      'Authentication',
      'Database Integration',
      'Final Project'
    ],
    'requirements': [
      'Basic JavaScript knowledge',
      'Understanding of HTML/CSS',
      'Computer with internet connection',
      'Code editor installed'
    ],
  },{
    'id': 9,
    'image': 'https://images.unsplash.com/photo-1626785774573-4b799315345d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2071&q=80',
    'video': '20',
    'title': 'Web Apps with React and Firebase Introduction',
    'user_profile': 'https://images.unsplash.com/photo-1601582589907-f92af5ed9db8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
    'user_name': 'Jonathan',
    'instructor': 'Jonathan Smith',
    'price': '30.00',
    'rating': 4.5,
    'stars': 4.5,
    'reviews': 850,
    'enrolled': 1250,
    'description': 'Learn to build modern web applications using React and Firebase. Master front-end development and backend integration.',
    'what_you_learn': [
      'Build React applications from scratch',
      'Work with Firebase authentication',
      'Deploy web applications',
      'Implement real-time databases'
    ],
    'demo_video':'https://www.youtube.com/watch?v=ZK-rNEhJIDs',
    'course_syllabus': [
      'Introduction to React',
      'Firebase Setup',
      'Authentication',
      'Database Integration',
      'Final Project'
    ],
    'requirements': [
      'Basic JavaScript knowledge',
      'Understanding of HTML/CSS',
      'Computer with internet connection',
      'Code editor installed'
    ],
  },{
    'id': 10,
    'image':   'https://images.unsplash.com/photo-1558655146-9f40138edfeb?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1064&q=80',
    'video': '20',
    'title': 'Web Apps with React and Firebase Introduction',
    'user_profile': 'https://images.unsplash.com/photo-1601582589907-f92af5ed9db8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
    'user_name': 'Jonathan',
    'instructor': 'Jonathan Smith',
    'price': '30.00',
    'rating': 4.5,
    'stars': 4.5,
    'reviews': 850,
    'enrolled': 1250,
    'description': 'Learn to build modern web applications using React and Firebase. Master front-end development and backend integration.',
    'what_you_learn': [
      'Build React applications from scratch',
      'Work with Firebase authentication',
      'Deploy web applications',
      'Implement real-time databases'
    ],
    'demo_video':'https://www.youtube.com/watch?v=ZK-rNEhJIDs',
    'course_syllabus': [
      'Introduction to React',
      'Firebase Setup',
      'Authentication',
      'Database Integration',
      'Final Project'
    ],
    'requirements': [
      'Basic JavaScript knowledge',
      'Understanding of HTML/CSS',
      'Computer with internet connection',
      'Code editor installed'
    ],
  },
  
];

const List MyCoursesJson = [
  {
    'image':
        'https://images.unsplash.com/photo-1575089976121-8ed7b2a54265?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=987&q=80',
    'video': '20',
    'title': 'Web Apps with React and Firebase Introduction',
    'user_profile':
        'https://images.unsplash.com/photo-1601582589907-f92af5ed9db8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
    'user_name': 'Jonathan',
    'price': '30.00',
    'percentage': 30.0,
  },
  {
    'image':
        'https://images.unsplash.com/photo-1618788372246-79faff0c3742?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=927&q=80',
    'video': '15',
    'title': 'Getting start with UX Flow design',
    'user_profile':
        'https://images.unsplash.com/photo-1558507652-2d9626c4e67a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=987&q=80',
    'user_name': 'Ormid',
    'price': '22.00',
    'percentage': 70.0,
  },
];

const List CategoryJson = [
  {
    'icon': 'assets/images/code_icon.svg',
    'title': 'Code',
  },
  {
    'icon': 'assets/images/bag_icon.svg',
    'title': 'DSA',
  },
  {
    'icon': 'assets/images/brush_icon.svg',
    'title': 'Design',
  },
  {
    'icon': 'assets/images/bag_icon.svg',
    'title': 'Development',
  },
  {
    'icon': 'assets/images/bag_icon.svg',
    'title': 'Business',
  },
  {
    'icon': 'assets/images/bag_icon.svg',
    'title': 'IT & Software',
  },
];

const Code = {
  'feature_course': [
    {
      'image':
          'https://images.unsplash.com/photo-1575089976121-8ed7b2a54265?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=987&q=80',
      'video': '20',
      'title': 'Web Apps with React and Firebase Introduction',
      'user_profile':
          'https://images.unsplash.com/photo-1601582589907-f92af5ed9db8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
      'user_name': 'Jonathan',
      'price': '30.00',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1618788372246-79faff0c3742?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=927&q=80',
      'video': '15',
      'title': 'Getting start with UX Flow design',
      'user_profile':
          'https://images.unsplash.com/photo-1558507652-2d9626c4e67a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=987&q=80',
      'user_name': 'Ormid',
      'price': '22.00',
    },
  ],
  'popular_topic': [
    {'title': 'React'},
    {'title': 'Python'},
    {'title': 'Flutter'},
    {'title': 'Javascript'},
    {'title': 'Data Science'},
    {'title': 'Web Development'},
    {'title': 'Cloud Computiing'},
  ],
  'popular_lecturer': [
    {
      'user_profile':
          'https://images.unsplash.com/photo-1601582589907-f92af5ed9db8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
      'user_name': 'Jonathan',
      'course': 'Python, Data Science',
      'total_courses': '30',
      'total_students': '2,523,600',
    },
    {
      'user_profile':
          'https://images.unsplash.com/photo-1558507652-2d9626c4e67a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=987&q=80',
      'user_name': 'Ormid',
      'course': 'Web Development, MySQL',
      'total_courses': '50',
      'total_students': '1,345,679',
    },
    {
      'user_profile':
          'https://images.unsplash.com/photo-1525134479668-1bee5c7c6845?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=987&q=80',
      'user_name': 'Faruque',
      'course': 'Mobile Development, Flutter',
      'total_courses': '25',
      'total_students': '6,345,679',
    },
  ],
  'all_course': [
    {
      'image':
          'https://images.unsplash.com/photo-1575089976121-8ed7b2a54265?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=987&q=80',
      'video': '20',
      'title': 'Web Apps with React and Firebase Introduction',
      'user_profile':
          'https://images.unsplash.com/photo-1601582589907-f92af5ed9db8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
      'user_name': 'Jonathan',
      'price': '30.00',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1618788372246-79faff0c3742?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=927&q=80',
      'video': '15',
      'title': 'Getting start with UX Flow design',
      'user_profile':
          'https://images.unsplash.com/photo-1558507652-2d9626c4e67a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=987&q=80',
      'user_name': 'Ormid',
      'price': '22.00',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1581287053822-fd7bf4f4bfec?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2101&q=80',
      'video': '25',
      'title': 'Mobile Application Design User Interface',
      'user_profile':
          'https://images.unsplash.com/photo-1525134479668-1bee5c7c6845?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=987&q=80',
      'user_name': 'Faruque',
      'price': '54.00',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1498050108023-c5249f4df085?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2072&q=80',
      'video': '50',
      'title': 'Master class of Data Structure & Algorithms',
      'user_profile':
          'https://images.unsplash.com/photo-1572631382901-cf1a0a6087cb?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=982&q=80',
      'user_name': 'Wassim',
      'price': '70.00',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2015&q=80',
      'video': '30',
      'title': 'Introduction into Finance and Accounting',
      'user_profile':
          'https://images.unsplash.com/photo-1517530094915-500495b15ade?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=987&q=80',
      'user_name': 'Lucas',
      'price': '15.00',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1626785774573-4b799315345d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2071&q=80',
      'video': '20',
      'title': 'Introduction into the World of Creativity',
      'user_profile':
          'https://images.unsplash.com/photo-1531369201-4f7be267b1de?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=987&q=80',
      'user_name': 'Oliver',
      'price': '25.00',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1558655146-9f40138edfeb?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1064&q=80',
      'video': '40',
      'title': 'Where should I begin on UI/UX?',
      'user_profile':
          'https://images.unsplash.com/photo-1629747490241-624f07d70e1e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1035&q=80',
      'user_name': 'Paul',
      'price': '65.00',
    },
  ],
};

const List CategoryJson2 = [
  {
    'icon': 'assets/images/bag_icon.svg',
    'title': 'Flutter',
  },
  {
    'icon': 'assets/images/bag_icon.svg',
    'title': 'Marketing',
  },
  {
    'icon': 'assets/images/bag_icon.svg',
    'title': 'Mern',
  },
  {
    'icon': 'assets/images/bag_icon.svg',
    'title': 'GitHub',
  },
  {
    'icon': 'assets/images/bag_icon.svg',
    'title': 'Data Science',
  },
  {
    'icon': 'assets/images/bag_icon.svg',
    'title': 'UI/UX',
  },
];



const CourseSearchData = {
  "topSearches": [
    "Flutter Development",
    "Python Programming",
    "Web Development",
    "Machine Learning",
    "JavaScript",
    "React Native",
    "UI/UX Design"
  ],
  "categories": [
    {
      "title": "Development",
      "items": [
        "Web Development",
        "Mobile Development",
        "Game Development",
        "Database Design",
        "Programming Languages"
      ]
    },
    {
      "title": "Business",
      "items": [
        "Entrepreneurship",
        "Marketing",
        "Finance",
        "Business Strategy",
        "Sales"
      ]
    },
    {
      "title": "Design",
      "items": [
        "Graphic Design",
        "UI/UX Design",
        "3D Modeling",
        "Animation",
        "Drawing"
      ]
    }
  ]
};
