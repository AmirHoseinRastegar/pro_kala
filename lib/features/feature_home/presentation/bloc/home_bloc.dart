import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../feature_bottom_nav/data/models/api_model.dart';
import '../../data/repository/home_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc(this.homeRepository) : super(HomeInitial()) {
    on<CallApiEvent>((event, emit) async {
      emit(HomeLoading());
      try {
        final HomeModel homeModel = await homeRepository.get();
        emit(HomeSuccess(homeModel));
      } catch (e) {
        throw Exception(e.toString());
      }
    });
  }
}
