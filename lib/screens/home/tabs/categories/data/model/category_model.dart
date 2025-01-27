

import 'dart:ui';

import '../../domain/entity/category_entity.dart';

class CategoryModel extends CategoryEntity{


  CategoryModel(
      {super.id = "",
        required super.color,
        required super.name,

        required super.date, required super.userId,
      });

  CategoryModel.fromJson(Map<String, dynamic> json)
      :this
      (
      name: json['name'],

      color: Color(json['color'] ?? 0xFF000000),
      date: json['date'],
      id: json['id'],
      userId: json['userId'],
    );


  Map<String,dynamic> toJson(){
    return {
      "id":id,
      "name":name,
      "color":color.value,
      "date":date,
      "userId":userId,
    };

  }


}