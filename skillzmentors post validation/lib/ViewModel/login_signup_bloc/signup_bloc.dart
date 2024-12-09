import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:skillzmentors/ViewModel/login_signup_bloc/signup_event.dart';
import 'package:skillzmentors/ViewModel/login_signup_bloc/signup_state.dart';
import 'package:http/http.dart' as http;

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  List<String> _alldetails = [];
  SignupBloc() : super(PersonalDetailsState()) {
    on<SignupInitialEvent>(signupInitialEvent);
    on<NextStepEvent>((event, emit) {});

    on<FetchCollegeAndDegreeEvent>(_fetchCollegeAndDegree);

    on<PreviousStepEvent>((event, emit) {});

    on<GoToPhoneVerificationEvent>((event, emit) {
      emit(PhoneVerificationState());
    });

    on<PreviousEducationEvent>((event, emit) {});
    on<VerifyPhoneEvent>(_verificationphone);

    on<PasswordCreateEvent>((event, emit) {
      emit(PasswordCreateState());
    });

    on<SubmitFormEvent>((event, emit) {
      emit(CompletedState());
    });

    on<PersonalDeteilsSubmissionEvent>(personalDeteilsSubmissionEvent);
    on<EducationDetilsEvent>(educationDetilsEvent);
    on<PasswordEvent>(_passwordstore);

    //fixme: under implementation

    on<FetchDepartmentEvent>(_fetchDepartments);
    on<AllSignupDetailsFetchedEvent>(allSignupDetailsFetchedEvent);

    on<SubmitFormEventFinal>(_submitFormfinal);
  }

  FutureOr<void> signupInitialEvent(
      SignupInitialEvent event, Emitter<SignupState> emit) {
    emit(PersonalDetailsState());
  }

  //fixme: under implementation
  FutureOr<void> _fetchCollegeAndDegree(
      FetchCollegeAndDegreeEvent event, Emitter<SignupState> emit) async {
    final response = await http.get(
      Uri.parse('https://skillzmentors.vercel.app/api/api/register'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final colleges = (data['colleges'] as List)
          .map((college) => college['name'] as String)
          .toList();
      final collegeIds = (data['colleges'] as List)
        .map((college) => college['id'].toString())
        .toList(); 
      final degrees = (data['degrees'] as List)
          .map((degree) => degree['name'] as String)
          .toList();
      final degreesid = (data['degrees'] as List)
          .map((degree) => degree['id'].toString())
          .toList();
      emit(LoadingState());
      await Future.delayed(const Duration(seconds: 1));
      emit(CollegeAndDegreeFetchedState(
          colleges: colleges, degrees: degrees, degreesid: degreesid , collegeIds: collegeIds));
    } else {
      print("erro is occuring in the fetching the college and degree");
    }
  }

  FutureOr<void> _fetchDepartments(
      FetchDepartmentEvent event, Emitter<SignupState> emit) async {
    final response = await http.get(
      Uri.parse(
          'https://skillzmentors.vercel.app/api/api/register/get-departments/${event.degreeid}'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final departments = (data['departments'] as List)
          .map((department) => department['name'] as String)
          .toList();
      final departmentid = (data['departments'] as List)
          .map((department) => department['id'].toString())
          .toList();

      emit(DepartmentsFetchedState(departments: departments , departmentid: departmentid));
    } else {
      emit(CourseFetchingErrorState());
    }
  }

  FutureOr<void> personalDeteilsSubmissionEvent(
      PersonalDeteilsSubmissionEvent event, Emitter<SignupState> emit) {
    _alldetails.add(event.firstName.toString());
    _alldetails.add(event.lastName.toString());
    _alldetails.add(event.gender.toString());
    _alldetails.add(event.email.toString());
    _alldetails.add(event.dob.toString());
    _alldetails.add(event.phone.toString());
    print("Personal details added: $_alldetails");
    //fixme: in the list now the element is 5
  }

  FutureOr<void> educationDetilsEvent(
      EducationDetilsEvent event, Emitter<SignupState> emit) {
    _alldetails.add(event.collegeid.toString());
    _alldetails.add(event.departmentid.toString());
    _alldetails.add(event.role.toString());
    _alldetails.add(event.rollnumebr.toString());
    _alldetails.add(event.year.toString());
    print("Education details added: $_alldetails");
    emit(PhoneVerificationState());
  }

  FutureOr<void> _verificationphone(
      VerifyPhoneEvent event, Emitter<SignupState> emit) {
    emit(OtpVerificationState());
  }

  FutureOr<void> _passwordstore(
      PasswordEvent event, Emitter<SignupState> emit) {
    _alldetails.add(event.password.toString());
    print("Password added : $_alldetails");
    Future.delayed(const Duration(seconds: 1));
    emit(CompletedState());
  }

  FutureOr<void> allSignupDetailsFetchedEvent(
      AllSignupDetailsFetchedEvent event, Emitter<SignupState> emit) {
    emit(CompletedState());
  }


  FutureOr<void> _submitFormfinal(SubmitFormEventFinal event, Emitter<SignupState> emit) async {
    final Map<String, dynamic> payload = {
      "first_name": _alldetails[0],
      "last_name": _alldetails[1],
      "gender": _alldetails[2],
      "email": _alldetails[3],
      "dob": (_alldetails[4]),
      "phone_number": _alldetails[5],
      "college_id": int.parse(_alldetails[6]),
      "department_id": int.parse(_alldetails[7]),
      "role": int.parse(_alldetails[8]),
      "roll_no": _alldetails[9],
      "year": _alldetails[10],
      "password": _alldetails[11],
      "password_confirmation": _alldetails[11],
      "profile_pic": null, 
      "id_card": null 
    };
    emit(LoadingState());
    final response = await http.post(
      Uri.parse('https://skillzmentors.vercel.app/api/api/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(payload),
      
    );
    print("Payload: $payload"); 
    if (response.statusCode == 200) {
      
      print("Signup successful: ${response.body}");
      emit(CompletedState());
    } else {
      print("Signup failed: ${response.body}");
      emit(LoginErrorState(message: response.body.toString()));
    }
  }
}
