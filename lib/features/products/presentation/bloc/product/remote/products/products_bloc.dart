import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/product.dart';
import '../../../../../domain/usecases/get_product.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProducts getProducts;

  ProductsBloc({required this.getProducts}) : super(ProductsInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductsLoading());
      final result = await getProducts();
      result.fold(
          (failure) => emit(
                ProductsError(failure.toString()),
              ),
          (products) => emit(ProductsLoaded(products)));
    });
  }
}
