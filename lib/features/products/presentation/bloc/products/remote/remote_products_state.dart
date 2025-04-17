part of 'remote_products_bloc.dart';

abstract class RemoteProductsState extends Equatable {
  const RemoteProductsState();

  @override
  List<Object?> get props => [];
}

class RemoteProductsInitial extends RemoteProductsState {}

class RemoteProductsLoading extends RemoteProductsState {}

class RemoteProductsLoaded extends RemoteProductsState {
  final List<ProductEntity> products;
  final bool hasReachedEnd;

  const RemoteProductsLoaded(
      {required this.products, required this.hasReachedEnd});
  @override
  List<Object?> get props => [products, hasReachedEnd];
}

class RemoteProductsError extends RemoteProductsState {
  final String message;

  const RemoteProductsError(this.message);

  @override
  List<Object?> get props => [message];
}
