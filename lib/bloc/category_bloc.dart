import 'dart:developer';

import 'package:bloc_games/bloc/category_state.dart';
import 'package:bloc_games/repository/game_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_event.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({required this.gameRepository}) : super(const CategoryState()) {
    on<GetCategories>(_mapGetCategoriesEventToState);
    on<SelectCategory>(_mapSelectCategoryEventToState);
  }
  final GameRepository gameRepository;

  void _mapGetCategoriesEventToState(
      GetCategories event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(status: CategoryStatus.loading));
    try {
      final genres = await gameRepository.service.getGenres();
      emit(state.copyWith(categories: genres, status: CategoryStatus.success));
    } catch (error, stackTrace) {
      log(stackTrace.toString());
      emit(state.copyWith(status: CategoryStatus.error));
    }
  }

  void _mapSelectCategoryEventToState(
      SelectCategory event, Emitter<CategoryState> emit) {
    emit(state.copyWith(idSelected: event.idSelected));
  }
}
