import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/state/pagination_state.dart';
import '../../../../data/models/product_pagination_query.dart';
import '../../../../data/models/product_search_query.dart';
import '../../../../domain/entities/product.dart';
import '../../../../domain/usecases/get_products.dart';
import '../../../../domain/usecases/search_products.dart';

part 'remote_products_event.dart';
part 'remote_products_state.dart';

class RemoteProductsBloc
    extends Bloc<RemoteProductsEvent, RemoteProductsState> {
  final GetProducts getProducts;
  final SearchProducts searchProducts;

  RemoteProductsBloc({
    required this.getProducts,
    required this.searchProducts,
  }) : super(RemoteProductsInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<FetchSearchProducts>(_onFetchSearchProducts);
  }

  final int limit = 20;

  final PaginationState<ProductEntity> pagination =
      PaginationState<ProductEntity>();
  final PaginationState<ProductEntity> searchPagination =
      PaginationState<ProductEntity>();

  Future<void> _onFetchProducts(
      FetchProducts event, Emitter<RemoteProductsState> emit) async {
    if (pagination.hasReachedEnd || pagination.isFetching) return;

    pagination.startFetching();
    if (event.isLoading) emit(RemoteProductsLoading());

    final result = await getProducts(
        ProductPaginationQueryModel(limit: limit, skip: pagination.skip));

    result.fold(
      (failure) {
        pagination.stopFetching();
        emit(RemoteProductsError(failure.toString()));
      },
      (newProducts) {
        pagination.update(newProducts, limit);
        emit(RemoteProductsLoaded(
          products: pagination.items,
          hasReachedEnd: pagination.hasReachedEnd,
        ));
      },
    );
  }

  Future<void> _onFetchSearchProducts(
      FetchSearchProducts event, Emitter<RemoteProductsState> emit) async {
    if (event.query.trim().isEmpty) {
      searchPagination.reset();
      emit(RemoteProductsLoaded(
        products: pagination.items,
        hasReachedEnd: pagination.hasReachedEnd,
      ));
      return;
    }

    if (event.isLoading) {
      emit(RemoteProductsLoading());
      searchPagination.reset();
    }

    if (searchPagination.hasReachedEnd || searchPagination.isFetching) return;

    searchPagination.startFetching();

    final result = await searchProducts(ProductSearchQueryModel(
      query: event.query,
      limit: limit,
      skip: searchPagination.skip,
    ));

    result.fold(
      (failure) {
        searchPagination.stopFetching();
        emit(RemoteProductsError(failure.toString()));
      },
      (newProducts) {
        searchPagination.update(newProducts, limit);
        emit(RemoteProductsLoaded(
          products: searchPagination.items,
          hasReachedEnd: searchPagination.hasReachedEnd,
        ));
      },
    );
  }
}
