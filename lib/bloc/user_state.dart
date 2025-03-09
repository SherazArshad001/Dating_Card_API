import 'package:dating_card_api/model/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<UserModel> users;
  final bool hasReachedMax;

  UserLoaded({required this.users, required this.hasReachedMax});

  @override
  List<Object?> get props => [users, hasReachedMax];
}

class UserError extends UserState {
  final String message;
  UserError({required this.message});

  @override
  List<Object?> get props => [message];
}
