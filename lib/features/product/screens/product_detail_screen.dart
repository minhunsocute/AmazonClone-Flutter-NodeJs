import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = "/product-detail";
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double rating = (product.rating != null)
        ? (product.rating!.isNotEmpty)
            ? product.rating!
                    .fold<double>(0, (double sum, item) => sum + item.rating) /
                product.rating!.length
            : 0
        : 0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios, color: Colors.black),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 10),
              child: Image.asset(
                'assets/images/amazon_in.png',
                width: 120,
                height: 45,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {},
              child: const Icon(Icons.settings, color: Colors.black),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            const SizedBox(height: 10),
            Hero(
              tag: "product image",
              child: Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 5,
                      offset: const Offset(-4, 4),
                    ),
                  ],
                  border: Border.all(
                    width: 1,
                    color: GlobalVariables.selectedNavBarColor,
                  ),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      product.images[0],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red.withOpacity(0.2),
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              '\$${product.price.toString()}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: GlobalVariables.selectedNavBarColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Row(
              children: [
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                Text(
                  '  ($rating)',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: GlobalVariables.selectedNavBarColor.withOpacity(0.2),
                  ),
                  child: Icon(
                    Icons.comment,
                    color: GlobalVariables.selectedNavBarColor,
                    size: 18,
                  ),
                ),
              ],
            ),
            const Text(
              'Description',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              product.description,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),
            CustomButton(text: 'Buy Now', onTap: () {}),
            const SizedBox(height: 10),
            CustomButton(text: 'Add to Cart', onTap: () {}),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
