import 'dart:convert';

import 'package:amazon_clone/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/error_handling.dart';
import '../../../models/product.dart';
import '../../../models/rating.dart';
import '../../../providers/user_provider.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    List<Product> listProduct = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.get(
          Uri.parse(
              'https://amazon-clone-hung.herokuapp.com/api/products?category=$category'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              Map<String, dynamic> map = jsonDecode(res.body)[i];
              print(map['ratings']);
              listProduct.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return listProduct;
  }

  Future<Product> fetchProductDayDeal(BuildContext context) async {
    Product result = Product(
      name: '',
      description: '',
      quantity: 0,
      images: [
        'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/6/7/637901982829761519_macbook-pro-m2-2022-xam-1.jpg'
      ],
      category: '',
      price: 0,
    );
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.get(
        Uri.parse('https://amazon-clone-hung.herokuapp.com/api/deal-of-day'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            result = Product.fromJson(res.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return result;
  }
}
