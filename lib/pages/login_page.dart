import 'package:chat_app/components/custom_circular_button.dart';
import 'package:chat_app/components/custom_form_text_field.dart';
import 'package:chat_app/components/custom_snack_bar.dart';
import 'package:chat_app/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubit/login_cubit/login_cubit.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/constants.dart';

class LoginPage extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  static String id = 'login page';

  String? email, password;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          isLoading = true;
        } else if (state is LoginSuccessState) {
          BlocProvider.of<ChatCubit>(context).receiveMessage();
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          isLoading = false;
        } else if (state is LoginFailureState) {
          ShowSnackBar(context, state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(11),
                    child: Image.asset('assets/images/scholar.png'),
                  ), //image
                  const Text('Scholar Chat ',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontFamily: 'pacifico')),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: const [
                      Text('Sign in',
                          style: TextStyle(fontSize: 30, color: Colors.white)),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomFormTextField(
                    onChange: (data) {
                      email = data;
                    },
                    hintText: 'Enter your email',
                    hintColor: Colors.white,
                    label: 'Email',
                    labelColor: Colors.white,
                    prefixIcon: Icons.email,
                    prefixIconColor: Colors.white,
                    borderColor: Colors.white,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormTextField(
                    isHidden: true,
                    onChange: (data) {
                      password = data;
                    },
                    hintText: 'Enter your password',
                    hintColor: Colors.white,
                    label: 'Password',
                    labelColor: Colors.white,
                    prefixIcon: Icons.lock,
                    prefixIconColor: Colors.white,
                    borderColor: Colors.white,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomCircularButtom(
                    label: 'Sign in',
                    height: 35,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        // isLoading = true;
                        // try {
                        //   await signInWithEmailAndPassword();
                        //   Navigator.pushNamed(context, ChatPage.id,
                        //       arguments: email);
                        // } on FirebaseAuthException catch (exception) {
                        //   if (exception.code == 'user-not-found') {
                        //     ShowSnackBar(
                        //         context, 'No user found for that email.');
                        //   } else if (exception.code == 'wrong-password') {
                        //     ShowSnackBar(context,
                        //         'Wrong password provided for that user.');
                        //   }
                        // }
                        // isLoading = false;
                        BlocProvider.of<LoginCubit>(context)
                            .signInWithEmailAndPassword(
                                email: email!, password: password!);
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have a Account ??... ",
                          style: TextStyle(color: Colors.white)),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white70),
                        ),
                        child: const Text('   SIGN UP',
                            style: TextStyle(
                              color: Color(0xffC4E7E8),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
