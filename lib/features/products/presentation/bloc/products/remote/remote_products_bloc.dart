import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/product_pagination_query.dart';
import '../../../../data/models/product_search_query.dart';
import '../../../../domain/entities/product.dart';
import '../../../../domain/usecases/get_products.dart';
import '../../../../domain/usecases/search_products.dart';

part 'remote_products_event.dart';
part 'remote_products_state.dart';

class RemoteProductsBloc extends Bloc<RemoteProductsEvent, RemoteProductsState> {
  final GetProducts getProducts;
  final SearchProducts searchProducts;

  RemoteProductsBloc({
    required this.getProducts,
    required this.searchProducts,
  }) : super(RemoteProductsInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<FetchSearchProducts>(_onFetchSearchProducts);
  }
  int skip = 0;
  final int limit = 20;
  bool hasReachedEnd = false;
  bool isFetching = false;
  int searchSkip = 0;
  bool hasReachedSearchEnd = false;
  bool isSearching = false;

  List<ProductEntity> allProducts = [];
  List<ProductEntity> allProductsSearch = [];

  void _onFetchProducts(
      FetchProducts event, Emitter<RemoteProductsState> emit) async {
    if (hasReachedEnd || isFetching) return;

    _handleFetching();

    if (event.isLoading) emit(RemoteProductsLoading());

    final result = await getProducts(
        ProductPaginationQueryModel(limit: limit, skip: skip));

    result.fold((failure) {
      _handleCancelFetching();
      emit(RemoteProductsError(failure.toString()));
    }, (newProducts) {
      _handleUpdatePagination(allProducts, newProducts);
      emit(RemoteProductsLoaded(
          products: allProducts, hasReachedEnd: hasReachedEnd));
    });
  }

  void _onFetchSearchProducts(
      FetchSearchProducts event, Emitter<RemoteProductsState> emit) async {
    if (event.query.trim().isEmpty) {
      emit(RemoteProductsLoaded(
          products: allProducts, hasReachedEnd: hasReachedEnd));
      return;
    }

    if (hasReachedSearchEnd || isFetching) return;

    _handleFetching();

    if (event.isLoading) {
      emit(RemoteProductsLoading());
      _handleResetSearchPagination();
    }

    final result = await searchProducts(
      ProductSearchQueryModel(
          query: event.query, limit: limit, skip: searchSkip),
    );

    result.fold(
      (failure) {
        _handleCancelFetching();
        emit(RemoteProductsError(failure.toString()));
      },
      (newProducts) {
        _handleUpdateSearchPagination(allProductsSearch, newProducts);
        emit(RemoteProductsLoaded(
            products: allProductsSearch, hasReachedEnd: hasReachedSearchEnd));
      },
    );
  }

  void _handleUpdateSearchPagination(
      List<ProductEntity> oldProducts, List<ProductEntity> newProducts) {
    hasReachedSearchEnd = newProducts.length < limit;
    allProductsSearch = [...oldProducts, ...newProducts];
    searchSkip += limit;
    _handleCancelFetching();
  }

  void _handleUpdatePagination(
      List<ProductEntity> oldProducts, List<ProductEntity> newProducts) {
    hasReachedEnd = newProducts.length < limit;
    allProducts = [...oldProducts, ...newProducts];
    skip += limit;
    _handleCancelFetching();
  }

  void _handleResetSearchPagination() {
    searchSkip = 0;
    hasReachedSearchEnd = false;
    isFetching = false;
    allProductsSearch = [];
  }

  void _handleCancelFetching() {
    isFetching = false;
  }

  void _handleFetching() {
    isFetching = true;
  }
}
