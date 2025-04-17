import 'package:burningbros_test/features/products/presentation/pages/products_favorite_screen.dart';
import 'package:burningbros_test/features/products/presentation/widgets/products_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/products/remote/remote_products_bloc.dart';
import '../widgets/product_input_search.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final bloc = context.read<RemoteProductsBloc>();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _textController.text.trim().isNotEmpty
            ? bloc.add(FetchSearchProducts(query: _textController.text))
            : bloc.add(FetchProducts());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Burning Bros'),
        backgroundColor: Colors.grey.withOpacity(0.2),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.redAccent,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductsFavoriteScreen()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProductInputSearch(textController: _textController),
            const SizedBox(height: 16),
            ProductsListCard(scrollController: _scrollController),
          ],
        ),
      ),
    );
  }
}
