import 'package:flutter/material.dart';

import '../../../../common/widgets/cached_image.dart';
import '../../domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CachedImage(imageUrl: product.thumbnail),
        title: Text(product.title),
        subtitle: Text('Price: ${product.price}'),
        onTap: () {},
      ),
    );
  }
}
