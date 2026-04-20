import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grey_matter/model/users/userDetails_model.dart';
import 'package:grey_matter/repositories/authentication_repositories.dart';
import 'package:grey_matter/viewmodel/bloc/users/userDetails/userdetails_event.dart';
import 'package:grey_matter/viewmodel/bloc/users/userDetails/userdetails_state.dart';
import 'package:meta/meta.dart';

class UserdetailsBloc extends Bloc<UserdetailsEvent, UserdetailsState> {
  final FirebaseFirestore _firestore;
  UserdetailsBloc({FirebaseFirestore? firestore})
    : _firestore= firestore?? FirebaseFirestore.instance,
      super(UserdetailsState.initial()) {
    on<UserdetailsEvent>(_getUserDetails);
  }

  Future<void> _getUserDetails(
    UserdetailsEvent event,
    Emitter<UserdetailsState> emit,
  ) async {
    await event.when(
      userDetails: (uid) async {
        emit(UserdetailsState.loading());
        try {
          final doc = await _firestore.collection('Users').doc(uid).get();
          if(doc.exists){
            final userDetails = UserdetailsModel.fromJson(doc.data()!);
            emit(UserdetailsState.loaded(userDetails));
          }
          else {
            emit(UserdetailsState.error('User not found'));
          }
        } catch (e) {
          emit(UserdetailsState.error('${e}'));
        }
      },
    );
  }
}
