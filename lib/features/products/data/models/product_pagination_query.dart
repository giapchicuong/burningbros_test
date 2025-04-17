import 'package:json_annotation/json_annotation.dart';

part 'product_pagination_query.g.dart';

@JsonSerializable()
class ProductPaginationQueryModel {
  final int limit;
  final int skip;

  ProductPaginationQueryModel({required this.limit, required this.skip});

  Map<String, dynamic> toJson() => _$ProductPaginationQueryModelToJson(this);
}
