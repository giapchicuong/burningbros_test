part of 'remote_products_bloc.dart';

abstract class RemoteProductsEvent {}

class FetchProducts extends RemoteProductsEvent {
  final bool isLoading;

  FetchProducts({this.isLoading = false});
}

class FetchSearchProducts extends RemoteProductsEvent {
  final String query;
  final bool isLoading;
  FetchSearchProducts({required this.query, this.isLoading = false});
}
