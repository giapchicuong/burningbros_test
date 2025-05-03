// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_search_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSearchQueryModel _$ProductSearchQueryModelFromJson(
        Map<String, dynamic> json) =>
    ProductSearchQueryModel(
      query: json['q'] as String,
      limit: (json['limit'] as num).toInt(),
      skip: (json['skip'] as num).toInt(),
    );

Map<String, dynamic> _$ProductSearchQueryModelToJson(
        ProductSearchQueryModel instance) =>
    <String, dynamic>{
      'q': instance.query,
      'limit': instance.limit,
      'skip': instance.skip,
    };
