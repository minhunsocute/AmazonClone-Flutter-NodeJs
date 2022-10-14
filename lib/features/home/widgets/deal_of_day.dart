import 'package:amazon_clone/features/product/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../../../models/product.dart';
import '../services/home_services.dart';
import 'package:get/get.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  final HomeServices homeServices = HomeServices();
  Rx<Product> product = Product(
          name: '',
          description: '',
          quantity: 1,
          images: [],
          category: '',
          price: 0)
      .obs;
  @override
  void initState() {
    super.initState();
    fetchProductDealDay();
  }

  fetchProductDealDay() async {
    product.value = await homeServices.fetchProductDayDeal(context);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => product.value.name != ''
        ? InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              ProductDetailScreen.routeName,
              arguments: product,
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                    width: 2, color: GlobalVariables.selectedNavBarColor),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      // border: Border.all(
                      //     width: 2, color: GlobalVariables.selectedNavBarColor),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          product.value.images[0],
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 5,
                          offset: const Offset(-4, 4),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${product.value.price}',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 29, 201, 192),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Text(
                              product.value.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 28, 201, 192),
                            ),
                            child: const Icon(
                              Icons.shopping_bag,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Divider(),
                  const SizedBox(height: 5),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'More Image',
                      style: TextStyle(
                        color: Color.fromARGB(255, 29, 201, 192),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product.value.images
                            .map(
                              (e) => Container(
                                height: 100,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                width: 100,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      blurRadius: 5,
                                      offset: const Offset(-4, 4),
                                    ),
                                  ],
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(e)),
                                ),
                              ),
                            )
                            .toList()),
                  ),
                ],
              ),
            ),
          )
        : Center(
            child: CircularProgressIndicator(
                color: GlobalVariables.selectedNavBarColor),
          ));
  }
}
