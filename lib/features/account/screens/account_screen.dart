import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/services/auth_service.dart';
import '../widgets/account_button.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
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
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Icon(Icons.notifications_none_outlined,
                        color: Colors.black),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {},
                    child: const Icon(Icons.search, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 20.0, top: 0.0, left: 20.0),
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 20),
                children: [
                  const TextSpan(text: 'Hello ,'),
                  TextSpan(
                    text: user.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              Row(
                children: [
                  AccountButton(
                    text: 'Your Orders',
                    onTap: () {},
                  ),
                  AccountButton(
                    text: 'Turn Seller',
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  AccountButton(
                    text: 'Log Out',
                    onTap: () => authService.logOut(context),
                  ),
                  AccountButton(
                    text: 'Your Wish List',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Orders',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    'See more',
                    style: TextStyle(
                      color: Color.fromARGB(255, 29, 201, 192),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              SizedBox(
                height: 150,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        height: 100,
                        width: 200,
                        margin: const EdgeInsets.only(left: 10.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: GlobalVariables.backgroundColor,
                          border: Border.all(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'https://www.gannett-cdn.com/presto/2022/10/04/USAT/d4cd6d8a-d8a8-440f-82bc-c0c9561a1993-Apple_2020_MacBook_Air_Prime_Early_Access.jpg?width=660&height=372&fit=crop&format=pjpg&auto=webp'),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.attach_money_rounded,
                                  color: GlobalVariables.selectedNavBarColor,
                                  size: 20,
                                ),
                                Text(
                                  ' 20.0\$',
                                  style: TextStyle(
                                    color: GlobalVariables.selectedNavBarColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: GlobalVariables.selectedNavBarColor,
                                  size: 20,
                                ),
                                Text(
                                  ' 20/11/2002',
                                  style: TextStyle(
                                    color: GlobalVariables.selectedNavBarColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 200,
                        margin: const EdgeInsets.only(left: 10.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: GlobalVariables.backgroundColor,
                          border: Border.all(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'https://www.gannett-cdn.com/presto/2022/10/04/USAT/d4cd6d8a-d8a8-440f-82bc-c0c9561a1993-Apple_2020_MacBook_Air_Prime_Early_Access.jpg?width=660&height=372&fit=crop&format=pjpg&auto=webp'),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.attach_money_rounded,
                                  color: GlobalVariables.selectedNavBarColor,
                                  size: 20,
                                ),
                                Text(
                                  ' 20.0\$',
                                  style: TextStyle(
                                    color: GlobalVariables.selectedNavBarColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: GlobalVariables.selectedNavBarColor,
                                  size: 20,
                                ),
                                Text(
                                  ' 20/11/2002',
                                  style: TextStyle(
                                    color: GlobalVariables.selectedNavBarColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
