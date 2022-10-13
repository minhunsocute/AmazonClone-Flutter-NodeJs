import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/admin/screens/add_product.dart';
import 'package:amazon_clone/features/auth/services/admin_services.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/view_item.dart';
import '../../../models/product.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<Product>? products;
  final AdminService adminServices = AdminService();
  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllData(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? Center(
            child: CircularProgressIndicator(
                color: GlobalVariables.selectedNavBarColor),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AddProduct.routeName),
              backgroundColor: GlobalVariables.selectedNavBarColor,
              child: const Icon(Icons.add),
            ),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: AppBar(
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: Column(
              children: [
                for (int i = 0; i < products!.length; i++)
                  (i % 2 == 0)
                      ? SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                child: ViewItem(
                                  product: products![i],
                                  delete: () => deleteProduct(products![i], i),
                                ),
                              ),
                              (i + 1 < products!.length)
                                  ? Expanded(
                                      child: ViewItem(
                                        product: products![i + 1],
                                        delete: () => deleteProduct(
                                            products![i + 1], i + 1),
                                      ),
                                    )
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
