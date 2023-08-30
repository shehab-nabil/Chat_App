import 'package:chat_app/components/custom_circular_button.dart';
import 'package:chat_app/components/custom_form_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/constants.dart';
import '../components/custom_snack_bar.dart';
import '../cubit/register_cubit/register_cubit.dart';

class RegisterPage extends StatelessWidget {
  static String id = 'register page';

  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterloadingState) {
          isLoading = true;
        } else if (state is RegisterSuccessState) {
          Navigator.pop(context);
          ShowSnackBar(context, 'all is done ');
          isLoading = false;
        } else if (state is RegisterFailureState) {
          ShowSnackBar(context, state.errorMassage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              title: const Text('Scholar Chat ',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  )),
              backgroundColor: Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontFamily: 'pacifico'),
                    ),
                    const SizedBox(
                      height: 50,
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
                      label: 'Sign up',
                      width: 170,
                      height: 35,
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await BlocProvider.of<RegisterCubit>(context)
                              .registerWithEmailAndPassword(
                                  email: email!, password: password!);
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have account ??... ",
                            style: TextStyle(color: Colors.white)),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => Colors.white70),
                          ),
                          child: const Text('   SIGN IN',
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
        );
      },
    );
  }
}
