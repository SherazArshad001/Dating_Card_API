import 'dart:async';
import 'package:dating_card_api/bloc/user_state.dart';
import 'package:dating_card_api/model/user_model.dart';
import 'package:dating_card_api/service/api_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService _userService;
  int page = 1;
  bool isFetching = false;

  UserBloc(this._userService) : super(UserInitial()) {
    on<FetchUser>(_onFetchUser);
  }

  FutureOr<void> _onFetchUser(FetchUser event, Emitter<UserState> emit) async {
    if (isFetching) {}
    isFetching = true;
    try {
      if (state is UserInitial) {
        emit(UserLoading());
      }
      final List<UserModel> users = await _userService.fetchUsers(page);
      final currentUsers =
          state is UserLoaded ? (state as UserLoaded).users : [];
      emit(UserLoaded(
          users: [...currentUsers, ...users], hasReachedMax: users.isEmpty));
      page++;
    } catch (e) {
      emit(UserError(message: e.toString()));
    } finally {
      isFetching = false;
    }
  }
}
