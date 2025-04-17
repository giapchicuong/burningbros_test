import 'package:bloc/bloc.dart';
import 'package:burningbros_test/features/products/domain/usecases/remove_save_favorite_products.dart';
import 'package:burningbros_test/features/products/domain/usecases/save_favorite_products.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/product.dart';
import '../../../../domain/usecases/get_save_favorite_products.dart';

part 'local_products_event.dart';
part 'local_products_state.dart';

class LocalProductsBloc extends Bloc<LocalProductsEvent, LocalProductsState> {
  final GetSaveFavoriteProductsUseCase getSaveFavoriteProductsUseCase;
  final SaveFavoriteProductsUseCase saveFavoriteProductsUseCase;
  final RemoveSaveFavoriteProductsUseCase removeSaveFavoriteProduct;

  LocalProductsBloc({
    required this.getSaveFavoriteProductsUseCase,
    required this.saveFavoriteProductsUseCase,
    required this.removeSaveFavoriteProduct,
  }) : super(LocalProductsInitial()) {
    on<GetSaveFavoriteProducts>(_onGetSaveFavoriteProducts);
    on<SaveFavoriteProduct>(_onSaveFavoriteProduct);
    on<RemoveSaveFavoriteProduct>(_onRemoveFavoriteProduct);
  }
  void _onGetSaveFavoriteProducts(
      GetSaveFavoriteProducts event, Emitter<LocalProductsState> emit) async {
    emit(LocalProductsLoading());
    final result = await getSaveFavoriteProductsUseCase();
    result.fold(
      (failure) => emit(LocalProductsError(failure.toString())),
      (products) => emit(LocalProductsLoaded(products: products)),
    );
  }

  void _onSaveFavoriteProduct(
      SaveFavoriteProduct event, Emitter<LocalProductsState> emit) async {
    final currentState = state;
    if (currentState is LocalProductsLoaded) {
      final result = await saveFavoriteProductsUseCase(event.productEntity);
      result.fold(
        (failure) => emit(LocalProductsError(failure.toString())),
        (_) {
          final updatedProducts =
              List<ProductEntity>.from(currentState.products)
                ..add(event.productEntity);
          emit(LocalProductsLoaded(products: updatedProducts));
        },
      );
    }
  }

  void _onRemoveFavoriteProduct(
      RemoveSaveFavoriteProduct event, Emitter<LocalProductsState> emit) async {
    final currentState = state;
    if (currentState is LocalProductsLoaded) {
      final result = await removeSaveFavoriteProduct(event.id);
      result.fold(
        (failure) => emit(LocalProductsError(failure.toString())),
        (_) => emit(LocalProductsLoaded(
            products: currentState.products
                .where(
                  (e) => e.id != event.id,
                )
                .toList())),
      );
    }
  }
}
