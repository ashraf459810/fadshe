// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  BannerModel({
    this.azsvr,
    this.items,
  });

  String azsvr;
  Items items;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        azsvr: json["AZSVR"],
        items: Items.fromJson(json["Items"]),
      );

  Map<String, dynamic> toJson() => {
        "AZSVR": azsvr,
        "Items": items.toJson(),
      };
}

class Items {
  Items({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  String nextPageUrl;
  String path;
  String perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.description,
    this.internalNotes,
    this.images,
    this.quantity,
    this.deliveryTypesId,
    this.categoriesId,
    this.cost,
    this.price,
    this.active,
    this.usersId,
    this.discount,
    this.lastPushTime,
    this.cashOnDelivery,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.ratesAvg,
    this.comments,
  });

  int id;
  String title;
  String description;
  String internalNotes;
  String images;
  int quantity;
  int deliveryTypesId;
  int categoriesId;
  double cost;
  String price;
  int active;
  int usersId;
  int discount;
  String lastPushTime;
  int cashOnDelivery;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int ratesAvg;
  List<dynamic> comments;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"] == null ? null : json["description"],
        internalNotes:
            json["internal_notes"] == null ? null : json["internal_notes"],
        images: json["images"],
        quantity: json["quantity"],
        deliveryTypesId: json["delivery_types_id"],
        categoriesId: json["categories_id"],
        cost: json["cost"].toDouble(),
        price: json["price"],
        active: json["active"],
        usersId: json["users_id"],
        discount: json["discount"],
        lastPushTime: json["last_push_time"],
        cashOnDelivery: json["cash_on_delivery"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        ratesAvg: json["RatesAvg"],
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description == null ? null : description,
        "internal_notes": internalNotes == null ? null : internalNotes,
        "images": images,
        "quantity": quantity,
        "delivery_types_id": deliveryTypesId,
        "categories_id": categoriesId,
        "cost": cost,
        "price": price,
        "active": active,
        "users_id": usersId,
        "discount": discount,
        "last_push_time": lastPushTime,
        "cash_on_delivery": cashOnDelivery,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "RatesAvg": ratesAvg,
        "comments": List<dynamic>.from(comments.map((x) => x)),
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String url;
  String label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label,
        "active": active,
      };
}
