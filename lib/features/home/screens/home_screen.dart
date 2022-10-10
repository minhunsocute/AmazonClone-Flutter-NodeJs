import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              user.toJson()['email'] ?? '',
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Show',
              onTap: () {
                print(user.toJson());
              },
            ),
          ],
        ),
      ),
    );
  }
}
