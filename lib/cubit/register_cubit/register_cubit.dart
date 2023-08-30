import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  Future<void> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(RegisterloadingState());
    try {
      var auth = FirebaseAuth.instance;
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (exception) {
      if (exception.code == 'weak-password') {
        emit(RegisterFailureState(errorMassage: 'the password is too weak'));
      } else if (exception.code == 'email-already-in-use') {
        emit(RegisterFailureState(errorMassage: 'email is already exist'));
      }
    } catch (e) {
      emit(RegisterFailureState(
          errorMassage: 'there was an error pls try again'));
    }
  }
}
