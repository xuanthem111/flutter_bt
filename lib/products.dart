// https://fakestoreapi.com/products
import 'dart:convert';

import 'package:http/http.dart' as http;

class Product {
  final int id;
  final String title;
  final dynamic price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.rating
      });

  factory Product.fromJson(Map<String, dynamic> json) {
    return new Product(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        description: json['description'],
        category: json['category'],
        image: json['image'],
        rating: Rating.fromJson(json['rating']));
  }
}
class Rating {
  final dynamic rate;
  final dynamic count;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return new Rating(
      rate: json['rate'],
      count: json['count']
    );
  }
}

  // static Future<List<Product>> fetchData() async {
  //   String url = "https://fakestoreapi.com/products";
  //   var client = http.Client();
  //   var response = await client.get(Uri.parse(url));
  //   if(response.statusCode == 200) {
  //     print('Tai du lieu thanh cong');
  //     var result = response.body;
  //     var jsonData = jsonDecode(result);
  //     print(jsonData);

  //     // print(jsonData[0].runtimeType);
  //     List<Product> ls = [];
  //     for (var item in jsonData) {
  //       dynamic rate = item["rating"]["rate"];
  //       dynamic count = item["rating"]["count"];
  //       var title = item['title'];
  //       var id = item['id'];
  //       var price = item['price'];
  //       var description = item['description'];
  //       var category = item['category'];
  //       var image = item['image'];
  //       Rating rating = new Rating(rate: rate, count: count);
  //       Product p = new Product(id, title, price, description, category, image,rate,count);
  //       print(p.title);
  //       print(rating.count);
  //       ls.add(p);
  //     }
  //     return ls;
  //   } else {
  //     print('Tai du lieu that bai');
  //     throw Exception("Loi lay du lieu ,chi tiet : ${response.statusCode}");
  //   }
  // }