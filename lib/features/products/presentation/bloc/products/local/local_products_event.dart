part of 'local_products_bloc.dart';

abstract class LocalProductsEvent {}

class SaveFavoriteProduct extends LocalProductsEvent {
  final ProductEntity productEntity;

  SaveFavoriteProduct({required this.productEntity});
}

class RemoveSaveFavoriteProduct extends LocalProductsEvent {
  final int id;

  RemoveSaveFavoriteProduct({required this.id});
}

class GetSaveFavoriteProducts extends LocalProductsEvent {}
