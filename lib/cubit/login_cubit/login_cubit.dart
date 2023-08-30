import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      var auth = FirebaseAuth.instance;
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (exception) {
      if (exception.code == 'user-not-found') {
        emit(LoginFailureState(errorMessage: 'the email is not exist'));
      } else if (exception.code == 'wrong-password') {
        emit(LoginFailureState(errorMessage: 'the password is wrong'));
      } else {
        emit(LoginFailureState(errorMessage: 'something went wrong'));
      }
    }
  }
}
