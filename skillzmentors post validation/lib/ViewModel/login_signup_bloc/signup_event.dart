abstract class SignupEvent {}

class SignupInitialEvent extends SignupEvent {}

class NextStepEvent extends SignupEvent {}

class PreviousStepEvent extends SignupEvent {}

class GoToPhoneVerificationEvent extends SignupEvent {}

class PreviousEducationEvent extends SignupEvent {}

class VerifyPhoneEvent extends SignupEvent {
  final String phonenumber;
  VerifyPhoneEvent({required this.phonenumber});
}

class OtpVerificationEvent extends SignupEvent {}

class PasswordCreateEvent extends SignupEvent {}
//fixme: under the implementation

class SubmitFormEvent extends SignupEvent {}

class SubmitFormEventFinal extends SignupEvent {}

class PersonalDeteilsSubmissionEvent extends SignupEvent {
  final String firstName;
  final String lastName;
  final String gender;
  final String dob;
  final String phone;
  final String email;

  PersonalDeteilsSubmissionEvent({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.email,
    required this.gender,
    required this.phone,
  });
}

class EducationDetilsEvent extends SignupEvent {
  final String collegeid;
  final String departmentid;
  final String role = '3';
  final String rollnumebr;
  final String year;
  EducationDetilsEvent(
      {required this.collegeid,
      required this.departmentid,
      required this.rollnumebr,
      required this.year});
}

class PasswordEvent extends SignupEvent {
  final String password;
  PasswordEvent({required this.password});
}

//fixme: under implemenation
class FetchCollegeAndDegreeEvent extends SignupEvent {}

class FetchDepartmentEvent extends SignupEvent {
  final String degreeid;

  FetchDepartmentEvent({required this.degreeid});
}


class AllSignupDetailsFetchedEvent extends SignupEvent{}


