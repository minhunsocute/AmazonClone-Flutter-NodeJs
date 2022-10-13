import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../constants/error_handling.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';
import '../../../models/rating.dart';
import '../../../providers/user_provider.dart';

class SearchServices {
  Future<List<Product>> fetchSearchProducts({
    required BuildContext context,
    required String searchQuery,
  }) async {
    List<Product> listProduct = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.get(
          Uri.parse(
              'https://amazon-clone-hung.herokuapp.com/api/products/search/$searchQuery'),
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
}
