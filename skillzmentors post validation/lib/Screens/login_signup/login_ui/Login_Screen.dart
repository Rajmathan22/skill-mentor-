import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillzmentors/Screens/login_signup/utils/Forget_password_Screen.dart';
import 'package:skillzmentors/Screens/login_signup/sign_up_ui/signup_selection.dart';
import 'package:skillzmentors/Screens/splash_screen/splash_screen.dart';
import 'package:skillzmentors/ViewModel/login_signup_bloc/login_bloc/login_bloc_bloc.dart';
class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final LoginBlocBloc loginbloc = LoginBlocBloc();
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<LoginBlocBloc, LoginBlocState>(
        bloc: loginbloc,
        listener: (context, state) {
          if (state is LoginLoading) {
            const snackBar = SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: AwesomeSnackbarContent(
                title: 'Login Loading!',
                message: 'Please wait while we log you in.😉',
                contentType: ContentType.help,
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is LoginSuccess) {
            const snackBar = SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: AwesomeSnackbarContent(
                title: 'Login Successful!',
                message: 'You have logged in successfully.',
                contentType: ContentType.success,
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SplashScreen()),
            );
          } else if (state is LoginFailure) {
            const snackBar = SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: AwesomeSnackbarContent(
                title: 'Login Failed!',
                message: 'Please check your email and password and try again.',
                contentType: ContentType.failure,
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            print("error in building");
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/logo_image.jpeg',
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10.0,
                      ),
                    ],
                    color: Colors.white,
                  ),
                  width: 300,
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Login",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontFamily: 'TimesNewRoman',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: const Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>const ForgetPassword()),
                                  );
                                },
                                child: const Text('Forgot password?'),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient:const LinearGradient(
                                    colors: [
                                      Colors.blue,
                                       Color.fromARGB(255, 114, 174, 223),

                                      Color.fromARGB(255, 255, 215, 0), // Gold
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 80, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    backgroundColor: Colors
                                        .transparent, // Make the button background transparent
                                    shadowColor: Colors
                                        .transparent, // Remove the button shadow
                                  ),
                                  onPressed: () {
                                    loginbloc.add(LoginButtonClickedEvent(
                                        email: emailController.text,
                                        password: passwordController.text));
                                  },
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      color: Colors.blue[900],
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'TimesNewRoman',
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Other Social Login'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.facebook,
                        color: Colors.blue,
                        size: 40,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon:const Icon(
                        Icons.mail,
                        color: Colors.red,
                        size: 40,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.apple,
                        color: Colors.black,
                        size: 40,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupSelection()),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                RichText(
                  text:const TextSpan(
                    text: 'By continuing, you agree to our \n',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Terms of Service',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      TextSpan(
                        text: ' and ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}