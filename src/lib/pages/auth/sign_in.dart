import 'package:flutter/material.dart' hide TextField;
import 'package:get/get.dart';
import 'package:src/common/color/spacer.dart';
import 'package:src/controller/auth/sign_in_controller.dart';

import '../../common/color/colors.dart';
import '../../common/widget/text_field.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SignInController(),
      builder: (SignInController controller) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Clr.bluePrimary,
                radius: 55,
                child: Image(image: AssetImage('asset/images/logo.png')),
              ),
              SizedBox(height: Spacing.kSpacingHeight),
              Text('Recsapi'),
              SizedBox(height: Spacing.kSpacingHeight),
              TextField(
                hintText: 'Username',
              ),
              SizedBox(height: Spacing.kSpacingHeight),
              TextField(
                hintText: 'Password',
                isPassword: true,
                maxLines: 1,
                suffix: Icon(Icons.remove_red_eye),
              ),
              SizedBox(height: Spacing.kSpacingHeight),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    Size(double.infinity, 50),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                onPressed: () => controller.login(context),
                child: Text('Masuk'),
              )
            ],
          ),
        );
      },
    );
  }
}
