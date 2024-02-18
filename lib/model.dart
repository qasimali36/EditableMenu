import 'dart:convert';
import 'package:flutter/material.dart';

MenuData menuDataFromJson(String str) => MenuData.fromJson(json.decode(str));

String menuDataToJson(MenuData data) => json.encode(data.toJson());

class MenuData {
  bool? success;
  List<MenuDataDatum>? data;
  List<VendorSize>? vendorSize;
  String? uncategorized; // Add this property

  MenuData({
    this.success,
    this.data,
    this.vendorSize,
    this.uncategorized,
  });

  factory MenuData.fromJson(Map<String, dynamic> json) => MenuData(
    success: json["success"],
    data: json["data"] == null
        ? []
        : List<MenuDataDatum>.from(json["data"].map(
            (x) => MenuDataDatum.fromJson(x as Map<String, dynamic>))),
    vendorSize: json["vendor_size"] == null
        ? []
        : List<VendorSize>.from(json["vendor_size"].map(
            (x) => VendorSize.fromJson(x as Map<String, dynamic>))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "vendor_size": vendorSize == null
        ? []
        : List<dynamic>.from(vendorSize!.map((x) => x.toJson())),
  };
}

class MenuDataDatum {
  MenuCategory? menuCategory;
  SingleMenuData? singleMenuData;

  MenuDataDatum({
    this.menuCategory,
    this.singleMenuData,
  });

  factory MenuDataDatum.fromJson(Map<String, dynamic> json) => MenuDataDatum(
    menuCategory: json["menu_category"] == null
        ? null
        : MenuCategory.fromJson(
        json["menu_category"] as Map<String, dynamic>),
    singleMenuData: json["single_menu_data"] == null
        ? null
        : SingleMenuData.fromJson(
        json["single_menu_data"] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    "menu_category": menuCategory?.toJson(),
    "single_menu_data": singleMenuData?.toJson(),
  };
}

class MenuCategory {
  int? id;
  int? vendorId;
  String? name;
  int? status;
  String? type;
  int? posStatus;
  int? frontendStatus;
  int? categoryOrder;
  DateTime? createdAt;
  DateTime? updatedAt;

  MenuCategory({
    this.id,
    this.vendorId,
    this.name,
    this.status,
    this.type,
    this.posStatus,
    this.frontendStatus,
    this.categoryOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory MenuCategory.fromJson(Map<String, dynamic> json) => MenuCategory(
    id: json["id"],
    vendorId: json["vendor_id"],
    name: json["name"],
    status: json["status"],
    type: json["type"],
    posStatus: json["pos_status"],
    frontendStatus: json["frontend_status"],
    categoryOrder: json["category_order"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"] as String),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"] as String),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "name": name,
    "status": status,
    "type": type,
    "pos_status": posStatus,
    "frontend_status": frontendStatus,
    "category_order": categoryOrder,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class SingleMenuData {
  bool? success;
  List<SingleMenuDataDatum>? data;

  SingleMenuData({
    this.success,
    this.data,
  });

  factory SingleMenuData.fromJson(Map<String, dynamic> json) =>
      SingleMenuData(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<SingleMenuDataDatum>.from(json["data"].map(
                (x) => SingleMenuDataDatum.fromJson(x as Map<String, dynamic>))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SingleMenuDataDatum {
  int? id;
  int? vendorId;
  int? menuCategoryId;
  int? menuId;
  int? status;
  int? menuOrder;
  DateTime? createdAt;
  DateTime? updatedAt;
  Menu? menu;
  List<SingleMenuItemCategory>? singleMenuItemCategory;

  SingleMenuDataDatum({
    this.id,
    this.vendorId,
    this.menuCategoryId,
    this.menuId,
    this.status,
    this.menuOrder,
    this.createdAt,
    this.updatedAt,
    this.menu,
    this.singleMenuItemCategory,
  });

  factory SingleMenuDataDatum.fromJson(Map<String, dynamic> json) =>
      SingleMenuDataDatum(
        id: json["id"],
        vendorId: json["vendor_id"],
        menuCategoryId: json["menu_category_id"],
        menuId: json["menu_id"],
        status: json["status"],
        menuOrder: json["menu_order"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"] as String),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"] as String),
        menu: json["menu"] == null
            ? null
            : Menu.fromJson(json["menu"] as Map<String, dynamic>),
        singleMenuItemCategory: json["single_menu_item_category"] == null
            ? []
            : List<SingleMenuItemCategory>.from(json["single_menu_item_category"].map(
                (x) => SingleMenuItemCategory.fromJson(x as Map<String, dynamic>))),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "menu_category_id": menuCategoryId,
    "menu_id": menuId,
    "status": status,
    "menu_order": menuOrder,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "menu": menu?.toJson(),
    "single_menu_item_category": singleMenuItemCategory == null
        ? []
        : List<dynamic>.from(singleMenuItemCategory!.map((x) => x.toJson())),
  };
}

class Menu {
  int? id;
  int? vendorId;
  String? name;
  String? image;
  String? description;
  String? price;
  String? displayPrice;
  String? diningPrice;
  String? displayDiscountPrice;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isAdded;
  List<MenuSize>? menuSize;

  Menu({
    this.id,
    this.vendorId,
    this.name,
    this.image,
    this.description,
    this.price,
    this.displayPrice,
    this.diningPrice,
    this.displayDiscountPrice,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.isAdded,
    this.menuSize,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    id: json["id"],
    vendorId: json["vendor_id"],
    name: json["name"],
    image: json["image"],
    description: json["description"],
    price: json["price"],
    displayPrice: json["display_price"],
    diningPrice: json["dining_price"],
    displayDiscountPrice: json["display_discount_price"],
    status: json["status"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"] as String),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"] as String),
    isAdded: json["is_added"],
    menuSize: json["menu_size"] == null
        ? []
        : List<MenuSize>.from(json["menu_size"].map(
            (x) => MenuSize.fromJson(x as Map<String, dynamic>))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "name": name,
    "image": image,
    "description": description,
    "price": price,
    "display_price": displayPrice,
    "dining_price": diningPrice,
    "display_discount_price": displayDiscountPrice,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "is_added": isAdded,
    "menu_size": menuSize == null
        ? []
        : List<dynamic>.from(menuSize!.map((x) => x.toJson())),
  };
}

class MenuSize {
  int? id;
  int? vendorId;
  int? menuId;
  int? itemSizeId;
  Color? color;
  String? price;
  String? sizeDiningPrice;
  String? displayPrice;
  dynamic displayDiscountPrice;
  DateTime? createdAt;
  DateTime? updatedAt;
  VendorSize? itemSize;
  String? name; // Add name property

  MenuSize({
    this.id,
    this.vendorId,
    this.menuId,
    this.itemSizeId,
    this.color,
    this.price,
    this.sizeDiningPrice,
    this.displayPrice,
    this.displayDiscountPrice,
    this.createdAt,
    this.updatedAt,
    this.itemSize,
    this.name,
  });

  factory MenuSize.fromJson(Map<String, dynamic> json) => MenuSize(
    id: json["id"],
    vendorId: json["vendor_id"],
    menuId: json["menu_id"],
    itemSizeId: json["item_size_id"],
    price: json["price"],
    sizeDiningPrice: json["size_dining_price"],
    displayPrice: json["display_price"],
    displayDiscountPrice: json["display_discount_price"],
    color: Colors.grey[200],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    itemSize: json["item_size"] == null
        ? null
        : VendorSize.fromJson(json["item_size"] as Map<String, dynamic>),
    name: json["name"], // Assign name property
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "menu_id": menuId,
    "item_size_id": itemSizeId,
    "price": price,
    "size_dining_price": sizeDiningPrice,
    "display_price": displayPrice,
    "display_discount_price": displayDiscountPrice,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "item_size": itemSize?.toJson(),
    "name": name, // Include name property in JSON serialization
  };
}

class VendorSize {
  int? id;
  int? vendorId;
  String? name;
  dynamic itemDiningPrice;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? image;

  VendorSize({
    this.id,
    this.vendorId,
    this.name,
    this.itemDiningPrice,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  factory VendorSize.fromJson(Map<String, dynamic> json) => VendorSize(
    id: json["id"],
    vendorId: json["vendor_id"],
    name: json["name"],
    itemDiningPrice: json["item_dining_price"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"] as String),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"] as String),
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "name": name,
    "item_dining_price": itemDiningPrice,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "image": image,
  };
}


class SingleMenuItemCategory {
  int? id;
  int? vendorId;
  int? singleMenuId;
  int? itemCategoryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  VendorSize? itemCategory;

  SingleMenuItemCategory({
    this.id,
    this.vendorId,
    this.singleMenuId,
    this.itemCategoryId,
    this.createdAt,
    this.updatedAt,
    this.itemCategory,
  });

  factory SingleMenuItemCategory.fromJson(Map<String, dynamic> json) =>
      SingleMenuItemCategory(
        id: json["id"],
        vendorId: json["vendor_id"],
        singleMenuId: json["single_menu_id"],
        itemCategoryId: json["item_category_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"] as String),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"] as String),
        itemCategory: json["item_category"] == null
            ? null
            : VendorSize.fromJson(json["item_category"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "single_menu_id": singleMenuId,
    "item_category_id": itemCategoryId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "item_category": itemCategory?.toJson(),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

bool isPizza(Menu selectedItem) {
  // Assuming pizzas have a specific category ID, adjust this condition accordingly
  return selectedItem.name == "Pizza";
}
