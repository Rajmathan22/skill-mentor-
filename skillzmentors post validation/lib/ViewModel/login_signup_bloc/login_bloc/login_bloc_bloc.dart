import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBlocBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  LoginBlocBloc() : super(LoginBlocInitial()) {
    on<LoginButtonClickedEvent>(initialFetchEvent);
  }

  FutureOr<void> initialFetchEvent(event, Emitter<LoginBlocState> emit) async {
    emit(LoginLoading());
    try {

      final response = await http.post(
        Uri.parse('https://skillzmentors.vercel.app/api/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': event.email,
          'password': event.password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final accessToken = data['access_token'];

        // Store the access token
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', accessToken);
        print('Access token: $accessToken');
        emit(LoginSuccess());
      } else {
        emit(LoginFailure());
      }
    } catch (e) {
      emit(LoginFailure());
    }
  }
}
