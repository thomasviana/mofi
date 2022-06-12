import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/user/application.dart';
import '../../../../core/user/domain.dart';
import '../../../utils/observer.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

@injectable
class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final GetProfileInfo _getProfileInfo;

  HomeScreenBloc(
    this._getProfileInfo,
  ) : super(HomeScreenState.initial()) {
    on<HomeScreenInfoRequested>(_onHomeScreenInfoRequested);
  }

  Future<void> _onHomeScreenInfoRequested(
    HomeScreenInfoRequested event,
    Emitter<HomeScreenState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    await emit.onEach<Option<UserEntity>>(
      _getProfileInfo(),
      onData: (user) {
        user.fold(
          () => emit(
            state.copyWith(
              status: Status.failure,
            ),
          ),
          (user) => emit(
            state.copyWith(
              user: user,
              status: Status.success,
            ),
          ),
        );
      },
    );
  }
}
