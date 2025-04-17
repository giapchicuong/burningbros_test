import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final String thumbnail;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
  });
  ProductEntity copyWith({
    int? id,
    String? title,
    double? price,
    String? thumbnail,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  @override
  List<Object> get props => [id, title, price, thumbnail];
}
