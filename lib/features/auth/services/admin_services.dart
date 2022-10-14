import 'dart:convert';

import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../constants/error_handling.dart';
import '../../../models/product.dart';
import 'package:provider/provider.dart';

import '../../../models/rating.dart';
import '../../../providers/user_provider.dart';

class AdminService {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String desception,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('ddopvilpr', 'evzte9pr');
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse imageRes = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrls.add(
          imageRes.secureUrl,
        );

        Product product = Product(
          name: name,
          description: desception,
          quantity: quantity,
          images: imageUrls,
          category: category,
          price: price,
        );

        http.Response res = await http.post(
          Uri.parse(
              'https://amazon-clone-hung.herokuapp.com/admin/add-product'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.user.token,
          },
          body: product.toJson(),
        );
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Post is success!');
          },
        );
      }
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  //Get all data of product
  Future<List<Product>> fetchAllData(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> producList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('https://amazon-clone-hung.herokuapp.com/admin/get-products'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              Map<String, dynamic> map = jsonDecode(res.body)[i];
              producList.add(Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return producList;
  }

  //delete products
  void deleteProduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
          Uri.parse(
            'https://amazon-clone-hung.herokuapp.com/admin/delete-product',
          ),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'id': product.id,
          }));
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
