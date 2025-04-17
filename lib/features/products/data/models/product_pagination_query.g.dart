// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_pagination_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductPaginationQueryModel _$ProductPaginationQueryModelFromJson(
        Map<String, dynamic> json) =>
    ProductPaginationQueryModel(
      limit: (json['limit'] as num).toInt(),
      skip: (json['skip'] as num).toInt(),
    );

Map<String, dynamic> _$ProductPaginationQueryModelToJson(
        ProductPaginationQueryModel instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'skip': instance.skip,
    };
