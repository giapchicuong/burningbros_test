import 'package:json_annotation/json_annotation.dart';

part 'product_search_query.g.dart';

@JsonSerializable()
class ProductSearchQueryModel {
  @JsonKey(name: 'q')
  final String query;
  final int limit;
  final int skip;

  ProductSearchQueryModel({
    required this.query,
    required this.limit,
    required this.skip,
  });

  Map<String, dynamic> toJson() => _$ProductSearchQueryModelToJson(this);
}
