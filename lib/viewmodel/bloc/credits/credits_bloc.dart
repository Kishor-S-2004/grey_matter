import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grey_matter/repositories/movie_repositories.dart';
import 'package:meta/meta.dart';

import '../../../model/movie/credits_model.dart';

part 'credits_event.dart';
part 'credits_state.dart';

class CredtisBloc extends Bloc<CredtisEvent, CredtisState> {
  final MovieRepositories repositories;
  CredtisBloc(this.repositories) : super(CredtisInitial()) {

    on<FetchCreditDetails>((event, emit) async{
      log('Credit bloc created');
     emit(CredtisLoading());
      try {
        log('try block start');
        final Credits credits = await repositories.getCreditDetails(event.movieId);
        log('after await');
        emit(CredtisLoaded(credits.cast,credits.crew));
      } catch (e, s) {
        log('ERROR: $e');
        log('STACKTRACE: $s');
        emit(CredtisError('$e'));
      }
    });
  }
}
