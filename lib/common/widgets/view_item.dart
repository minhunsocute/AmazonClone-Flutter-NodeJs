import 'package:flutter/material.dart';

import '../../constants/global_variables.dart';
import '../../models/product.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class ViewItem extends StatelessWidget {
  final Product product;
  final Function() delete;
  const ViewItem({super.key, required this.product, required this.delete});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Container(
      width: double.infinity,
      height: 270,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: const Color.fromARGB(255, 125, 221, 216),
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 5,
            offset: const Offset(-4, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  product.images[0],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.computer,
                            size: 15,
                            color: GlobalVariables.selectedNavBarColor),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            product.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.attach_money_rounded,
                            size: 15,
                            color: GlobalVariables.selectedNavBarColor),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            product.price.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              (userProvider.user.type == "admin")
                  ? InkWell(
                      onTap: delete,
                      child: const Icon(
                        Icons.delete_outline,
                      ),
                    )
                  : Container(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
