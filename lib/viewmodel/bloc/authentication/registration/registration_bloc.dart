import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grey_matter/repositories/authentication_repositories.dart';
import 'registration_event.dart';
import 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthenticationRepositories _auth;

  RegistrationBloc({AuthenticationRepositories? auth})
      : _auth = auth ?? AuthenticationRepositories(),
        super(const RegistrationState.initial()) {
    on<RegistrationEvent>(_onRegistrationUser);
  }

  Future<void> _onRegistrationUser(
      RegistrationEvent event,
      Emitter<RegistrationState> emit,
      ) async {
    await event.when(
      registrationUser: (userName,email, password) async {
        emit(const RegistrationState.loading());
        try {
          await _auth.registerUser(
            userName: userName,
            email: email,
            password: password,
          );
          emit(const RegistrationState.success());
        } on FirebaseAuthException catch (e) {
          emit(RegistrationState.failure(_mapFirebaseError(e.code)));
        } catch (e) {
          emit(RegistrationState.failure(e.toString()));
        }
      },
    );
  }

  String _mapFirebaseError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'invalid-email':
        return 'Invalid email address.';
      default:
        return 'Registration failed. Please try again.';
    }
  }
}