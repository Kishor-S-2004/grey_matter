import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grey_matter/repositories/authentication_repositories.dart';
import 'package:meta/meta.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepositories _auth;
  LoginBloc({AuthenticationRepositories? auth})
    : _auth = auth ?? AuthenticationRepositories(),
      super(LoginState.initial()) {
    on<LoginUser>(_onLoginUser);
  }

  Future<void> _onLoginUser(LoginEvent event, Emitter<LoginState> emit) async {
    await event.when(loginUsers: (email,password)async{
      emit(LoginState.loading());
      try{
        await _auth.loginUser(email: email, password: password);
        emit(LoginState.loaded());
      }on FirebaseAuthException catch(e){
        print("FIREBASE ERROR CODE: ${e.code}");
        print("FIREBASE ERROR MESSAGE: ${e.message}");
        emit(LoginState.error(_mapFirebaseError(e.code)));
      }catch (e){
        emit(LoginState.error(e.toString()));
      }
    }
    );
  }

  String _mapFirebaseError(String code) {
    switch (code) {
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'No internet connection.';
      default:
        return 'Login failed. Code: $code';
    }
  }
}
