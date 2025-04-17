import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/product.dart';

part 'product.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class ProductModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String thumbnail;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  ProductEntity toEntity() => ProductEntity(
        id: id,
        title: title,
        price: price,
        thumbnail: thumbnail,
      );
  factory ProductModel.fromEntity(ProductEntity entity) => ProductModel(
        id: entity.id,
        title: entity.title,
        price: entity.price,
        thumbnail: entity.thumbnail,
      );
}
