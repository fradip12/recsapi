import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide TextField;
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:src/common/color/spacer.dart';
import 'package:src/common/services/firebase_auth.dart';
import 'package:src/common/style/text_style.dart';
import 'package:src/controller/auth/sign_in_controller.dart';

import '../../common/color/colors.dart';
import '../../common/widget/text_field.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  void initState() {
    super.initState();
  }

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
                radius: 70,
                child: Image(image: AssetImage('asset/images/logo/logo.png')),
              ),
              SizedBox(height: Spacing.kSpacingHeight),
              Text('SiSapi'),
              SizedBox(height: Spacing.kSpacingHeight),
              TextField(
                controller: controller.usernameController.value,
                hintText: 'Username',
              ),
              SizedBox(height: Spacing.kSpacingHeight),
              StreamBuilder<bool>(
                  stream: controller.obsecure,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: controller.passwordController.value,
                      hintText: 'Password',
                      isPassword: snapshot.data ?? false,
                      maxLines: 1,
                      suffix: InkWell(
                        onTap: () {
                          controller.obsecureSink.add(!snapshot.data!);
                        },
                        child: Icon(
                          (snapshot.data ?? false)
                              ? FontAwesome5.eye
                              : FontAwesome5.eye_slash,
                          size: 18,
                        ),
                      ),
                    );
                  }),
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
              ),
              SizedBox(height: Spacing.kSpacingHeight),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/signup');
                },
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: 'Belum Punya Akun? Daftar ',
                      style: kText10Style.copyWith(color: Colors.black87),
                    ),
                    TextSpan(
                      text: 'disini',
                      style: kText10Style.copyWith(color: Colors.blue),
                    ),
                  ]),
                ),
              ),
              SizedBox(height: 5),
              Text('atau', style: kText10Style.copyWith(color: Colors.black87)),
              SizedBox(height: 5),
              SignInButton(
                Buttons.google,
                text: 'Masuk dengan Google',
                onPressed: () {
                  controller.loginGoogle(context);
                },
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom))
            ],
          ),
        );
      },
    );
  }
}
