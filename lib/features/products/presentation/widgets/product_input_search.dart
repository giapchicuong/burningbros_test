import 'package:burningbros_test/core/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/functions/debounce.dart';
import '../../../../core/constants/sizes.dart';
import '../bloc/products/remote/remote_products_bloc.dart';

class ProductInputSearch extends StatelessWidget {
  const ProductInputSearch({
    super.key,
    required TextEditingController textController,
  }) : _textController = textController;

  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    final debouncer = AppDebouncer(milliseconds: 500);

    final bloc = context.read<RemoteProductsBloc>();

    void onChangedSearch(String contentSearch) {
      debouncer.run(
        () => bloc.add(
          FetchSearchProducts(query: contentSearch, isLoading: true),
        ),
      );
    }

    return TextFormField(
      controller: _textController,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        hintText: AppTexts.searchProductsByName,
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.base),
        ),
      ),
      onChanged: onChangedSearch,
    );
  }
}
