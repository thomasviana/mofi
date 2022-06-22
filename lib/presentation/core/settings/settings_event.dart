part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
  @override
  List<Object> get props => [];
}

class GetUserAccounts extends SettingsEvent {}

class GetUserCategories extends SettingsEvent {}

class GetUserSubCategories extends SettingsEvent {}

class GetUserBudgets extends SettingsEvent {}

class ResetFromFactoryRequested extends SettingsEvent {}

class BackUpData extends SettingsEvent {}
