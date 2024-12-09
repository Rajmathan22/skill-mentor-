abstract class SignupState {}

class PersonalDetailsState extends SignupState {}

class AddressDetailsState extends SignupState {}

class PreviousEducationState extends SignupState {}

class PhoneVerificationState extends SignupState {}

class CourseFetchingErrorState extends SignupState {}

class LoadingState extends SignupState {}

class OtpVerificationState extends SignupState {}

class PasswordCreateState extends SignupState {}

class CompletedState extends SignupState {

}

class CollegeAndDegreeFetchedState extends SignupState {
  final List<String> colleges;
  final List<String> degrees;
  final List<String> degreesid;
  final List<String> collegeIds;

  CollegeAndDegreeFetchedState(
      {required this.colleges,
      required this.degrees,
      required this.degreesid,
      required this.collegeIds});
}

//info: this is for fetching the course based on the degree

class CourseFetchedState extends SignupState {
  final String degreeid;
  CourseFetchedState({required this.degreeid});
}

class CollegeIdFetchState extends SignupState {
  final List<String> collegeId;
  CollegeIdFetchState({required this.collegeId});
}

class DepartmentsFetchedState extends SignupState {
  final List<String> departments;
  final List<String> departmentid;
  DepartmentsFetchedState(
      {required this.departments, required this.departmentid});
}

class LoginErrorState extends SignupState {
  final String message;
  LoginErrorState({required this.message});
}


