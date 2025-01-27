import 'dart:ui';

import 'package:trade_mate/screens/home/tabs/suppliers/data/model/supplier_model.dart';

import '../../data/model/category_model.dart';


class CategoryEntity{

  String id;
  String name;
  Color color;
  String date;
  String userId;

  CategoryEntity(
      {required this.id,
        required this.name,
        required this.color,

        required this.date, required this.userId,
      });


  factory CategoryEntity.fromJson(Map<String, dynamic> json) {
    return CategoryEntity(

      name: json['name'],
      color:  Color(json['color']),

      date: json['date'],
      id: json['id'],
      userId: json['userId'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color.value,
      'date': date,
      'userId': userId,
    };
  }
  CategoryEntity toEntity() {
    return CategoryEntity(
      color:color,

        id:id,

        name:name,
        userId:userId,
        date:date,

    );
  }
  CategoryModel fromEntity(CategoryEntity entity) {
    return CategoryModel(

        id:entity.id,
        name:entity.name,
        userId:entity.userId,
        date:entity.date,
        color:entity.color
    );
  }




}