import 'package:bloc_games/repository/models/genre_model.dart';
import 'package:equatable/equatable.dart';

enum CategoryStatus { initial, loading, success, error, selected }

extension CategoryStatusX on CategoryStatus {
  bool get isInitial => this == CategoryStatus.initial;
  bool get isLoading => this == CategoryStatus.loading;
  bool get isSuccess => this == CategoryStatus.success;
  bool get isError => this == CategoryStatus.error;
  bool get isSelected => this == CategoryStatus.selected;
}

class CategoryState extends Equatable {
  const CategoryState(
      {this.status = CategoryStatus.initial,
      List<Genre>? categories,
      idSelected = 0})
      : idSelected = idSelected,
        categories = categories ?? const [];

  final CategoryStatus status;
  final List<Genre>? categories;
  final int idSelected;

  @override
  List<Object?> get props => [status, idSelected];

  CategoryState copyWith(
      {CategoryStatus? status, List<Genre>? categories, int? idSelected}) {
    return CategoryState(
        status: status ?? this.status,
        categories: categories ?? this.categories,
        idSelected: idSelected ?? this.idSelected);
  }
}
