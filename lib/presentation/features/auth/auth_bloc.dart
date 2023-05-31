import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../service/firebase/auth/fir_auth_repo.dart';
import '../user/data/api/user_repository.dart';
import '../user/data/model/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(UnAuthenticatedState()) {
    on<AuthLoginEvent>((event, emitter) async {
      await FirAuthRepo.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
          // onFailure: (p0) {
          //   setState(() {
          //     feedbackType = FeedbackType.error;
          //     feedbackMessage = p0;
          //   });
          // },
          onSuccess: (p0) async {
            final id = p0.data?.user?.uid;

            await UserRepo.getUserData(id ?? "", (u) async {
              handleUser(u);
            });
          });
    });
    on<AuthLogoutEvent>((event, emit) {
      emit(UnAuthenticatedState());
    });
  }
  void handleUser(UserModel user) {
    emit(AuthenticatedState(
      user: user,
    ));
  }
}
