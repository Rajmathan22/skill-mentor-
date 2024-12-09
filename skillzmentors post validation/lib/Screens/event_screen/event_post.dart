import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skillzmentors/Screens/event_screen/events_model.dart';
import 'package:skillzmentors/ViewModel/event_bloc/event_bloc.dart';
import 'package:skillzmentors/ViewModel/event_bloc/event_bloc_events.dart';
import 'package:skillzmentors/ViewModel/event_bloc/event_bloc_states.dart';
import 'package:skillzmentors/config/Theme/text_theme.dart';
import 'dart:io';

class EventPostScreen extends StatefulWidget {
  const EventPostScreen({super.key});

  @override
  _EventPostScreenState createState() => _EventPostScreenState();
}

class _EventPostScreenState extends State<EventPostScreen> {
  final _formKey = GlobalKey<FormState>();

  final List eventType = ['Hackathon', 'Sports', 'Academics'];
  final List visibility = ['public', 'private'];

  int selectedType = 0;
  String selectedVisibility = 'public';

  late PostEventModel event;

  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _topicsController = TextEditingController();
  final TextEditingController _eligibilityController = TextEditingController();
  final TextEditingController _eventStartTimeController = TextEditingController();
  final TextEditingController _eventEndTimeController = TextEditingController();
  final TextEditingController _aboutThisEventController = TextEditingController();
  final TextEditingController _eventDescriptionController = TextEditingController();
  final TextEditingController _brochureController = TextEditingController();
  final TextEditingController _collegeNameController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _collegeAddressController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  DateTime? _selectedEventStartDate;
  DateTime? _selectedEventEndDate;
  DateTime? _selectedEventRegStartDate;
  DateTime? _selectedEventRegEndDate;
  File? _eventPoster;
  File? _eventBrochure;
  List<File> _selectedImages = [];
  TimeOfDay _selectedEventStartTime = TimeOfDay.now();
  TimeOfDay _selectedEventEndTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Event"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedTick02, color: Color(0xFF4A4A4A)),
            onPressed: () {
              _validate().then((isValid) {
                if (isValid) {
                  event = get_event();
                  BlocProvider.of<EventBloc>(context).add(PostEvent(event));
                  // print("Event Posted");
                }
              });
            },
          ),
        ],
      ),
      body: BlocBuilder<EventBloc, EventBlocStates>(
        bloc: EventBloc(),
        builder: (context,state) {
          if (state is PostEventLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is PostEventState) {
            return const Center(
              child: Text("Event Posted Successfully"),
            );
          }

          if (state is PostEventErrorState) {
            return const Center(
              child: Text("Error Posting Event"),
            );
          }

          else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event Poster
                      buildImagePicker("Event Poster", _eventPoster, (file) {
                        setState(() {
                          _eventPoster = file;
                        });
                      }),
                      const SizedBox(height: 16),
                      const Text(
                        'General Details',
                        style: MyTextTheme.headline,
                      ),
                      const SizedBox(height: 16),

                      //Event Name
                      buildTextField(
                          "Event Name",
                          _eventNameController,
                          HugeIcon(
                              icon: HugeIcons.strokeRoundedPencilEdit02,
                              color: Color(0xFF4A4A4A))),
                      const SizedBox(height: 16),

                      // Event Type
                      const Text(
                        'Event Type',
                        style: MyTextTheme.body,
                      ),
                      Row(
                        children: [
                          for (final type in eventType)
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: FilterChip(
                                label: Text(type),
                                selected: selectedType ==
                                    eventType.indexOf(type),
                                onSelected: (selected) {
                                  setState(() {
                                    selectedType = eventType.indexOf(type);
                                  });
                                },
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Visibility
                      const Text(
                        'Visibility',
                        style: MyTextTheme.body,
                      ),
                      Row(
                        children: [
                          for (final visiblity in visibility)
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: FilterChip(
                                label: Text(visiblity),
                                selected: selectedVisibility == visiblity,
                                onSelected: (selected) {
                                  setState(() {
                                    selectedVisibility = visiblity;
                                  });
                                },
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      //Topics
                      buildTextField(
                          "Topics",
                          _topicsController,
                          HugeIcon(
                              icon: HugeIcons.strokeRoundedPencilEdit02,
                              color: Color(0xFF4A4A4A))),
                      const SizedBox(height: 16),

                      // Eligibility
                      buildTextField(
                          "Eligibility",
                          _eligibilityController,
                          HugeIcon(
                              icon: HugeIcons.strokeRoundedPencilEdit02,
                              color: Color(0xFF4A4A4A))),
                      const SizedBox(height: 16),

                      const Text(
                        'Date and Timing Details',
                        style: MyTextTheme.headline,
                      ),
                      const SizedBox(height: 16),

                      //Registration Start Date
                      buildDatePicker(
                          "Registration Start Date",
                          _selectedEventRegStartDate,
                              () =>
                              _pickDate(
                                  context,
                                      (date) =>
                                      setState(() {
                                        _selectedEventRegStartDate = date;
                                      }))),
                      const SizedBox(height: 16),

                      //Registration End Date
                      buildDatePicker(
                          "Registration End Date",
                          _selectedEventRegEndDate,
                              () =>
                              _pickDate(
                                  context,
                                      (date) =>
                                      setState(() {
                                        _selectedEventRegEndDate = date;
                                      }))),
                      const SizedBox(height: 16),

                      //Event Start Date
                      buildDatePicker(
                          "Event Start Date",
                          _selectedEventStartDate,
                              () =>
                              _pickDate(
                                  context,
                                      (date) =>
                                      setState(() {
                                        _selectedEventStartDate = date;
                                      }))),
                      const SizedBox(height: 16),

                      //Event End Date
                      buildDatePicker(
                          "Event End Date",
                          _selectedEventEndDate,
                              () =>
                              _pickDate(
                                  context,
                                      (date) =>
                                      setState(() {
                                        _selectedEventEndDate = date;
                                      }))),
                      const SizedBox(height: 16),

                      //Event Start Time
                      buildTimePicker(
                        "Event Start Time",
                        _selectedEventStartTime,
                        _eventStartTimeController,
                            () =>
                            _pickTime(
                                context,
                                    (time) =>
                                    setState(() {
                                      _selectedEventStartTime = time;
                                    }),
                                _eventStartTimeController),
                      ),
                      const SizedBox(height: 16),

                      //Event End Time
                      buildTimePicker(
                        "Event End Time",
                        _selectedEventEndTime,
                        _eventEndTimeController,
                            () =>
                            _pickTime(
                                context,
                                    (time) =>
                                    setState(() {
                                      _selectedEventEndTime = time;
                                    }),
                                _eventEndTimeController),
                      ),
                      const SizedBox(height: 16),

                      const Text(
                        'Event Details',
                        style: MyTextTheme.headline,
                      ),
                      const SizedBox(height: 16),

                      // About This Event
                      buildTextField(
                          "About This Event",
                          _aboutThisEventController,
                          HugeIcon(
                              icon: HugeIcons.strokeRoundedMenu04,
                              color: Color(0xFF4A4A4A)),
                          maxLines: 5),
                      const SizedBox(height: 16),

                      // Event Description
                      buildTextField(
                          "Event Description",
                          _eventDescriptionController,
                          HugeIcon(
                              icon: HugeIcons.strokeRoundedMenu04,
                              color: Color(0xFF4A4A4A)),
                          maxLines: 5),
                      const SizedBox(height: 16),

                      // College Name
                      buildTextField(
                          "College Name",
                          _collegeNameController,
                          HugeIcon(
                              icon: HugeIcons.strokeRoundedUniversity,
                              color: Color(0xFF4A4A4A))),
                      const SizedBox(height: 16),

                      // Venue
                      buildTextField(
                          "Venue",
                          _venueController,
                          HugeIcon(
                              icon: HugeIcons.strokeRoundedBuilding02,
                              color: Color(0xFF4A4A4A))),
                      const SizedBox(height: 16),

                      // College Address
                      buildTextField(
                          "College Address",
                          _collegeAddressController,
                          HugeIcon(
                              icon: HugeIcons.strokeRoundedLocation01,
                              color: Color(0xFF4A4A4A))),
                      const SizedBox(height: 16),

                      // Price
                      buildTextField(
                          "Ticket Price",
                          _priceController,
                          HugeIcon(
                              icon: HugeIcons.strokeRoundedTicket02,
                              color: Color(0xFF4A4A4A))),
                      const SizedBox(height: 16),

                      const Text(
                        'Event Brochure',
                        style: MyTextTheme.headline,
                      ),
                      const SizedBox(height: 16),
                      buildFilePicker("Event Brochure", _brochureController),
                      const SizedBox(height: 16),

                      // Media Picker (Images and Poster)
                      const Text(
                        'Additional Images',
                        style: MyTextTheme.headline,
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildImagesPicker(
                            "Event Images", _selectedImages,
                                (files) {
                              setState(() {
                                _selectedImages = files;
                              });
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }
      ),
    );
  }

  Future<void> _pickDate(
      BuildContext context, Function(DateTime) onSelect) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) onSelect(pickedDate);
  }

  Future<void> _pickTime(BuildContext context, Function(TimeOfDay) onSelect,
      TextEditingController controller) async {
    // Reset the controller before showing the time picker
    controller.clear();
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      // Update the controller text with the newly selected time
      controller.text =
          '${pickedTime.hourOfPeriod}:${pickedTime.minute.toString().padLeft(2, '0')} ${pickedTime.period == DayPeriod.am ? 'AM' : 'PM'}';
      onSelect(pickedTime);
    }
  }

  Future<void> _pickImage(Function(File?) onSelect) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      onSelect(File(pickedFile.path));
    }
  }

  // Pick PDF files
  Future<void> _pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Restrict to PDF files
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _eventBrochure = File(result.files.single.path!);
      });
    }
  }

  Future<bool> _validate() async {
    return true;
    if (_formKey.currentState!.validate() && _eventPoster != null) {
      return true;
    }
    if (_eventPoster == null) {
      //Snackbar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('PLease Select a Event Poster'),
        backgroundColor: Colors.red,
      ));
      return false;
    }
    if (_eventBrochure == null) {
      //Snackbar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('PLease Select a Event Brouchure'),
        backgroundColor: Colors.red,
      ));
      return false;
    } else {
      return false;
    }
  }

  PostEventModel get_event() {
    //Format the registration start date embedded with the start time like in the format 2024-12-01T09:00:00
    final String formattedRegStartDate =
        '${_selectedEventRegStartDate!.year}-${_selectedEventRegStartDate!.month.toString().padLeft(2, '0')}-${_selectedEventRegStartDate!.day.toString().padLeft(2, '0')}T${_selectedEventStartTime.hour}:${_selectedEventStartTime.minute.toString().padLeft(2, '0')}:00';

    //Format the registration end date embedded with the end time like in the format 2024-12-01T09:00:00
    final String formattedRegEndDate =
        '${_selectedEventRegEndDate!.year}-${_selectedEventRegEndDate!.month.toString().padLeft(2, '0')}-${_selectedEventRegEndDate!.day.toString().padLeft(2, '0')}T${_selectedEventEndTime.hour}:${_selectedEventEndTime.minute.toString().padLeft(2, '0')}:00';

    //Format the start date embedded with the start time like in the format 2024-12-01T09:00:00
    final String formattedStartDate =
        '${_selectedEventStartDate!.year}-${_selectedEventStartDate!.month.toString().padLeft(2, '0')}-${_selectedEventStartDate!.day.toString().padLeft(2, '0')}T${_selectedEventStartTime.hour}:${_selectedEventStartTime.minute.toString().padLeft(2, '0')}:00';

    //Format the end date embedded with the end time like in the format 2024-12-01T09:00:00
    final String formattedEndDate =
        '${_selectedEventEndDate!.year}-${_selectedEventEndDate!.month.toString().padLeft(2, '0')}-${_selectedEventEndDate!.day.toString().padLeft(2, '0')}T${_selectedEventEndTime.hour}:${_selectedEventEndTime.minute.toString().padLeft(2, '0')}:00';

    return PostEventModel(
      event_name: _eventNameController.text,
      event_type_id: (selectedType + 1).toString(),
      visibility: selectedVisibility,
      topics: _topicsController.text,
      eligibility: _eligibilityController.text,
      registration_start_date: formattedRegStartDate,
      registration_end_date: formattedRegEndDate,
      event_start_date: formattedStartDate,
      event_end_date: formattedEndDate,
      about_this_event: _aboutThisEventController.text,
      event_description: _eventDescriptionController.text,
      registration_fee: _priceController.text,
      venue: _venueController.text,
    );

    // //default data for testing
    // return PostEventModel(
    //       event_name: "Event Name",
    //       event_type_id: "1",
    //       visibility: "private",
    //       topics: "Topics",
    //       eligibility: "Eligibility",
    //       registration_start_date: "2024-12-01T09:00:00",
    //       registration_end_date: "2024-12-01T09:00:00",
    //       event_start_date: "2024-12-01T09:00:00",
    //       event_end_date: "2024-12-01T09:00:00",
    //       about_this_event: "About This Event",
    //       event_description: "Event Description",
    //       registration_fee: "100",
    //       venue: "Venue"
    // );
  }

  Widget buildTextField(
      String label, TextEditingController controller, HugeIcon icon,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: MyTextTheme.body,
        suffixIcon: icon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      maxLines: maxLines,
      validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
    );
  }

  Widget buildDatePicker(
      String label, DateTime? selectedDate, VoidCallback onPickDate) {
    return GestureDetector(
      onTap: onPickDate,
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            labelStyle: MyTextTheme.body,
            suffixIcon: HugeIcon(
                icon: HugeIcons.strokeRoundedCalendar01,
                color: Color(0xFF4A4A4A)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          controller: TextEditingController(
              text: selectedDate == null
                  ? ""
                  : '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
          validator: (value) =>
              selectedDate == null ? 'Please pick a date for $label' : null,
        ),
      ),
    );
  }

  Widget buildTimePicker(String label, TimeOfDay selectedTime,
      TextEditingController controller, VoidCallback onPickTime) {
    return GestureDetector(
      onTap: onPickTime,
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            labelStyle: MyTextTheme.body,
            suffixIcon: HugeIcon(
                icon: HugeIcons.strokeRoundedClock01, color: Color(0xFF4A4A4A)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          controller: controller,
          validator: (value) =>
              value!.isEmpty ? 'Please select a valid time' : null,
        ),
      ),
    );
  }

  // Reusable File Picker for Event Poster
  Widget buildImagePicker(String label, File? file, Function(File?) onSelect) {
    return GestureDetector(
      onTap: () => _pickImage(onSelect),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.transparent,
            width: 2,
          ),
          image: file != null
              ? DecorationImage(
                  image: FileImage(file),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: file == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedPlusSignCircle,
                      size: 48,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Add Event Poster",
                      style: MyTextTheme.body.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }

  // Reusable Images Picker for Event Images
  Widget buildImagesPicker(
      String label, List<File> files, Function(List<File>) onSelect) {
    return GestureDetector(
      onTap: () async {
        final pickedFiles = await ImagePicker().pickMultiImage();
        if (pickedFiles != null) {
          onSelect(pickedFiles.map((file) => File(file.path)).toList());
        }
      },
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.transparent,
            width: 2,
          ),
        ),
        child: files.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedPlusSignCircle,
                      size: 48,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Add Event Images",
                      style: MyTextTheme.body.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Carousel for Event Images
                  SizedBox(
                    height: 150,
                    child: PageView.builder(
                      controller: PageController(viewportFraction: 0.8),
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: FileImage(files[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.red),
                              onPressed: () => onSelect(files..removeAt(index)),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  // Reusable File Picker for Event Brochure
  Widget buildFilePicker(String label, TextEditingController controller) {
    return GestureDetector(
      onTap: _pickPdf, // Trigger PDF picking
      child: _eventBrochure == null
          ? Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.picture_as_pdf, size: 50, color: Colors.grey),
                    SizedBox(height: 8),
                    Text(
                      'Upload Event Brochure (PDF)',
                      style: MyTextTheme.body.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green, width: 1),
              ),
              child: Row(
                children: [
                  const Icon(Icons.picture_as_pdf,
                      color: Colors.green, size: 40),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      _eventBrochure!.path.split('/').last, // Show file name
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontFamily: 'TimesNewRoman'),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () => setState(() => _eventBrochure = null),
                  ),
                ],
              ),
            ),
    );
  }
}
