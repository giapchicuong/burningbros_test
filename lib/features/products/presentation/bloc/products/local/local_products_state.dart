part of 'local_products_bloc.dart';

abstract class LocalProductsState extends Equatable {
  const LocalProductsState();

  @override
  List<Object?> get props => [];
}

class LocalProductsInitial extends LocalProductsState {}

class LocalProductsLoading extends LocalProductsState {}

class LocalProductsLoaded extends LocalProductsState {
  final List<ProductEntity> products;

  const LocalProductsLoaded({required this.products});
  @override
  List<Object?> get props => [products];
}

class LocalProductsError extends LocalProductsState {
  final String message;

  const LocalProductsError(this.message);

  @override
  List<Object?> get props => [message];
}
