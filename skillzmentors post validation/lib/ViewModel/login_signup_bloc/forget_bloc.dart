import 'package:bloc/bloc.dart';
import 'package:skillzmentors/ViewModel/login_signup_bloc/forget_event.dart';
import 'package:skillzmentors/ViewModel/login_signup_bloc/forget_state.dart';

class ForgetBloc extends Bloc<ForgetEvent, ForgetState> {
  ForgetBloc() : super(PhoneVerificationState()) {
    on<NextStepEvent>((event, emit) {
      if (state is PhoneVerificationState) {
        emit(OtpVerificationState());
      } else if (state is OtpVerificationState) {
        emit(PasswordCreateState());
      }
    });

    on<PreviousStepEvent>((event, emit) {
      if (state is OtpVerificationState) {
        emit(PhoneVerificationState());
      } else if (state is PasswordCreateState) {
        emit(OtpVerificationState());
      }
    });

    on<VerifyPhoneEvent>((event, emit) {
      emit(OtpVerificationState());
    });

    on<VerifyOtpEvent>((event, emit) {
      emit(PasswordCreateState());
    });

    on<CreatePasswordEvent>((event, emit) {
      emit(PasswordCreateState());
    });
    on<CompletedEvent>((event, emit) {
      emit(CompletedState());
    });
  }
}
