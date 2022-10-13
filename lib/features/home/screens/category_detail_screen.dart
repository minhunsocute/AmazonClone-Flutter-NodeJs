import 'package:flutter/material.dart';

import '../../../common/widgets/view_item.dart';
import '../../../constants/global_variables.dart';
import '../../../models/product.dart';
import '../services/home_services.dart';

class CategoryDetailScreen extends StatefulWidget {
  static const String routeName = "/category-screen";
  final String category;
  const CategoryDetailScreen({super.key, required this.category});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  final HomeServices homeServices = HomeServices();
  List<Product>? products;
  @override
  void initState() {
    super.initState();
    fetchCategoryProduct();
  }

  fetchCategoryProduct() async {
    products = await homeServices.fetchCategoryProducts(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              const Text(
                'Admin',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )
            ],
          ),
        ),
      ),
      body: products == null
          ? Center(
              child: CircularProgressIndicator(
                  color: GlobalVariables.selectedNavBarColor))
          : ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        widget.category,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
                for (int i = 0; i < products!.length; i++)
                  (i % 2 == 0)
                      ? SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                child: ViewItem(
                                  product: products![i],
                                  delete: () {},
                                ),
                              ),
                              (i + 1 < products!.length)
                                  ? Expanded(
                                      child: ViewItem(
                                      product: products![i + 1],
                                      delete: () {},
                                    ))
                                  : Expanded(
                                      child: Container(),
                                    )
                            ],
                          ),
                        )
                      : Container(),
              ],
            ),
    );
  }
}
