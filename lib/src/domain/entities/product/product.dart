// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/domain/entities/product/image_product.dart';
import 'package:nanoshop/src/domain/entities/product/product_info.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends Equatable {
  final String? id;
  final String? name;
  final String? price;
  @JsonKey(name: "price_market")
  final String? priceMarket;
  @JsonKey(name: "price_sell")
  final String? priceSell;
  @JsonKey(name: "includeVat")
  final String? includeVat;
  final String? quantity;
  final String? status;
  final String? state;
  final String? position;
  @JsonKey(name: "product_sortdesc_bk")
  final String? productSortdescBk;
  @JsonKey(name: "product_desc_bk")
  final String? productDescBk;
  @JsonKey(name: "avatar_path")
  final String? avatarPath;
  @JsonKey(name: "avatar_name")
  final String? avatarName;
  final String? currency;
  final String? avatarId;
  @JsonKey(name: "product_category_id")
  final String? productCategoryId;
  final String? ishot;
  final String? issale;
  final String? ispriceday;
  final String? alias;
  final String? viewed;
  final String? isnew;
  final String? isselling;
  final String? iswaitting;
  final String? weight;
  final String? capacity;
  @JsonKey(name: "is_configurable")
  final String? isConfigurable;
  @JsonKey(name: "bonus_point")
  final String? bonusPoint;
  final String? donate;
  @JsonKey(name: "province_id")
  final String? provinceId;
  @JsonKey(name: "total_sell")
  final String? totalSell;
  @JsonKey(name: "rate_info")
  final String? rateInfo;
  final String? rate;
  @JsonKey(name: "rate_count")
  final String? rateCount;
  @JsonKey(name: "discount_has")
  final String? discountHas;
  @JsonKey(name: "discount_percent")
  final String? discountPercent;
  @JsonKey(name: "product_sortdesc")
  final String? productSortdesc;
  @JsonKey(name: "product_desc")
  final String? productDesc;
  final String? link;
  @JsonKey(name: "price_text")
  final String? priceText;
  @JsonKey(name: "price_market_text")
  final String? priceMarketText;
  @JsonKey(name: "price_save_text")
  final String? priceSaveText;
  @JsonKey(name: "is_liked")
  final int? isLiked;
  @JsonKey(name: "product_info")
  final ProductInfo? productInfo;
  @JsonKey(name: "product_qty")
  final String? productQty;
  @JsonKey(name: "total_rating")
  final String? totalRating;
  final List<ImageProduct>? images;

  const Product({
    this.id,
    this.totalRating,
    this.productQty,
    this.productInfo,
    this.images,
    this.name,
    this.price,
    this.priceMarket,
    this.priceSell,
    this.includeVat,
    this.quantity,
    this.status,
    this.state,
    this.position,
    this.productSortdescBk,
    this.productDescBk,
    this.avatarPath,
    this.avatarName,
    this.currency,
    this.avatarId,
    this.productCategoryId,
    this.ishot,
    this.issale,
    this.ispriceday,
    this.alias,
    this.viewed,
    this.isnew,
    this.isselling,
    this.iswaitting,
    this.weight,
    this.capacity,
    this.isConfigurable,
    this.bonusPoint,
    this.donate,
    this.provinceId,
    this.totalSell,
    this.rateInfo,
    this.rate,
    this.rateCount,
    this.discountHas,
    this.discountPercent,
    this.productSortdesc,
    this.productDesc,
    this.link,
    this.priceText,
    this.priceMarketText,
    this.priceSaveText,
    this.isLiked,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return _$ProductFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      name,
      isLiked,
    ];
  }

  static String encode(List<Product> products) => json.encode(
        products.map<Map<String, dynamic>>((e) => e.toJson()).toList(),
      );

  static List<Product> decode(String jsonString) =>
      (json.decode(jsonString) as List<dynamic>)
          .map<Product>(
            (item) => Product.fromJson(item),
          )
          .toList();

  Product copyWith({
    String? id,
    String? name,
    String? price,
    String? priceMarket,
    String? priceSell,
    String? includeVat,
    String? quantity,
    String? status,
    String? state,
    String? position,
    String? productSortdescBk,
    String? productDescBk,
    String? avatarPath,
    String? avatarName,
    String? currency,
    String? avatarId,
    String? productCategoryId,
    String? ishot,
    String? issale,
    String? ispriceday,
    String? alias,
    String? viewed,
    String? isnew,
    String? isselling,
    String? iswaitting,
    String? weight,
    String? capacity,
    String? isConfigurable,
    String? bonusPoint,
    String? donate,
    String? provinceId,
    String? totalSell,
    String? rateInfo,
    String? rate,
    String? rateCount,
    String? discountHas,
    String? discountPercent,
    String? productSortdesc,
    String? productDesc,
    String? link,
    String? priceText,
    String? priceMarketText,
    String? priceSaveText,
    int? isLiked,
    int? total,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      priceMarket: priceMarket ?? this.priceMarket,
      priceSell: priceSell ?? this.priceSell,
      includeVat: includeVat ?? this.includeVat,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      state: state ?? this.state,
      position: position ?? this.position,
      productSortdescBk: productSortdescBk ?? this.productSortdescBk,
      productDescBk: productDescBk ?? this.productDescBk,
      avatarPath: avatarPath ?? this.avatarPath,
      avatarName: avatarName ?? this.avatarName,
      currency: currency ?? this.currency,
      avatarId: avatarId ?? this.avatarId,
      productCategoryId: productCategoryId ?? this.productCategoryId,
      ishot: ishot ?? this.ishot,
      issale: issale ?? this.issale,
      ispriceday: ispriceday ?? this.ispriceday,
      alias: alias ?? this.alias,
      viewed: viewed ?? this.viewed,
      isnew: isnew ?? this.isnew,
      isselling: isselling ?? this.isselling,
      iswaitting: iswaitting ?? this.iswaitting,
      weight: weight ?? this.weight,
      capacity: capacity ?? this.capacity,
      isConfigurable: isConfigurable ?? this.isConfigurable,
      bonusPoint: bonusPoint ?? this.bonusPoint,
      donate: donate ?? this.donate,
      provinceId: provinceId ?? this.provinceId,
      totalSell: totalSell ?? this.totalSell,
      rateInfo: rateInfo ?? this.rateInfo,
      rate: rate ?? this.rate,
      rateCount: rateCount ?? this.rateCount,
      discountHas: discountHas ?? this.discountHas,
      discountPercent: discountPercent ?? this.discountPercent,
      productSortdesc: productSortdesc ?? this.productSortdesc,
      productDesc: productDesc ?? this.productDesc,
      link: link ?? this.link,
      priceText: priceText ?? this.priceText,
      priceMarketText: priceMarketText ?? this.priceMarketText,
      priceSaveText: priceSaveText ?? this.priceSaveText,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
