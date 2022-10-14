import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/utils.dart';
import '../../../models/cart.dart';
import '../../../models/product.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';

class CartServices {
  void addToCart(
      {required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('https://amazon-clone-hung.herokuapp.com/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
        }),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
              cart: (jsonDecode(res.body)['cart'].isNotEmpty)
                  ? jsonDecode(res.body)['cart']
                      .map((e) => Cart.fromMap({
                            'product': Product.fromMap(e['product']),
                            'quantity': e['quantity'],
                          }))
                      .toList()
                  : []);
          userProvider.setUserFromModel(user);
          showSnackBar(context, "Add to Cart is success");
        },
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  void removeCart(
      {required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(
        Uri.parse(
            'https://amazon-clone-hung.herokuapp.com/api/remove-to-cart/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
              cart: (jsonDecode(res.body)['cart'].isNotEmpty)
                  ? jsonDecode(res.body)['cart']
                      .map((e) => Cart.fromMap({
                            'product': Product.fromMap(e['product']),
                            'quantity': e['quantity'],
                          }))
                      .toList()
                  : []);
          userProvider.setUserFromModel(user);
          showSnackBar(context, "Delete Cart is success");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
