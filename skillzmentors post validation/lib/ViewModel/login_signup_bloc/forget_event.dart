abstract class ForgetEvent {}

class NextStepEvent extends ForgetEvent {}

class PreviousStepEvent extends ForgetEvent {}

class VerifyPhoneEvent extends ForgetEvent {}

class VerifyOtpEvent extends ForgetEvent {}

class CreatePasswordEvent extends ForgetEvent {}

class CompletedEvent extends ForgetEvent {}
