import 'package:amazon_clone/features/cart/services/cart_services.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../constants/global_variables.dart';
import '../../../models/cart.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  // static const String routeName =
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartServices cartServices = CartServices();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    double sum = 0;
    user.cart.map((e) => sum += e.quantity * e.product.price).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: (stringQuery) {},
                        decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                left: 6,
                              ),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black38,
                              width: 1,
                            ),
                          ),
                          hintText: 'Search Amazon.in',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Icon(Icons.mic, color: Colors.black, size: 25),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          Container(
            height: 40,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 114, 226, 221),
                  Color.fromARGB(255, 162, 236, 233),
                ],
                stops: [0.5, 1.0],
              ),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_rounded,
                  color: Colors.black,
                  size: 20,
                ),
                Expanded(
                  child: Text(
                    ' Delivery to ${user.name} - ${user.address}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_drop_down,
                    color: Colors.black, size: 20),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 20),
                  children: [
                    const TextSpan(
                      text: 'Subtotal: ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: '\$$sum',
                      style: TextStyle(
                          color: GlobalVariables.selectedNavBarColor,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomButton(
              text: 'Procced to buy(${user.cart.length} items)',
              onTap: () {},
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: Colors.black),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(children: [
                for (int i = 0; i < user.cart.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ViewCartItem(
                      index: i,
                    ),
                  ),
              ])),
        ],
      ),
    );
  }
}

class ViewCartItem extends StatefulWidget {
  final int index;
  const ViewCartItem({
    super.key,
    required this.index,
  });

  @override
  State<ViewCartItem> createState() => _ViewCartItemState();
}

class _ViewCartItemState extends State<ViewCartItem> {
  final CartServices cartServices = CartServices();

  void decreasingQuatinity(Product product) async {
    cartServices.removeCart(context: context, product: product);
    setState(() {});
  }

  void increasingQuantity(Product product) async {
    cartServices.addToCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final item = context.watch<UserProvider>().user.cart[widget.index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 130,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    width: 2, color: GlobalVariables.selectedNavBarColor),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    item.product.images[0],
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
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  '\$${item.product.price}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Eligible for FREE shipping',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  'In Stock',
                  style: TextStyle(
                    color: GlobalVariables.selectedNavBarColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: 80,
          height: 30,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                width: 1, color: GlobalVariables.selectedNavBarColor),
          ),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => decreasingQuatinity(item.product),
                  child: Container(
                    height: 26,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:
                          GlobalVariables.selectedNavBarColor.withOpacity(0.7),
                    ),
                    child:
                        const Icon(Icons.remove, color: Colors.white, size: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  item.quantity.toString(),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => increasingQuantity(item.product),
                  child: Container(
                    height: 26,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:
                          GlobalVariables.selectedNavBarColor.withOpacity(0.7),
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
