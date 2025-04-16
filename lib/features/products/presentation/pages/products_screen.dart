import 'package:burningbros_test/features/products/domain/entities/product.dart';
import 'package:burningbros_test/features/products/presentation/bloc/product/remote/products/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/product_card.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final state = context.watch<ProductsBloc>().state;

    var widgets = (switch (state) {
      ProductsLoading() => _buildLoadingWidget(),
      ProductsLoaded(products: final products) =>
        products.isEmpty ? _buildEmptyWidget() : _buildInitialWidget(products),
      ProductsError(message: final msg) => _buildErrorWidget(msg),
      _ => Container(),
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Burning Bros'),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Tìm sản phẩm...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(child: widgets),
          ],
        ),
      ),
    );
  }

  ListView _buildInitialWidget(List<ProductEntity> products) {
    return ListView.separated(
      itemCount: products.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(product: product);
      },
    );
  }

  Center _buildEmptyWidget() {
    return const Center(child: Text('Không có sản phẩm nào.'));
  }

  Center _buildErrorWidget(String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Center _buildLoadingWidget() =>
      const Center(child: CircularProgressIndicator());
}
