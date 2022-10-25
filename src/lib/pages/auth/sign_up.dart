import 'package:flutter/material.dart' hide TextField;
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/route_manager.dart';
import 'package:src/common/color/colors.dart';
import 'package:src/controller/auth/sign_up_controller.dart';

import '../../common/color/spacer.dart';
import '../../common/style/text_style.dart';
import '../../common/widget/text_field.dart';

class SignUpPages extends StatefulWidget {
  const SignUpPages({Key? key}) : super(key: key);

  @override
  _SignUpPagesState createState() => _SignUpPagesState();
}

class _SignUpPagesState extends State<SignUpPages> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SignupController(),
      builder: (SignupController controller) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Clr.bluePrimary,
                    radius: 70,
                    child:
                        Image(image: AssetImage('asset/images/logo/logo.png')),
                  ),
                  SizedBox(height: Spacing.kSpacingHeight),
                  Text('SiSapi'),
                  SizedBox(height: Spacing.kSpacingHeight),
                  TextField(
                    controller: controller.nameController.value,
                    hintText: 'Full Name',
                  ),
                  SizedBox(height: Spacing.kSpacingHeight),
                  TextField(
                    controller: controller.emailController.value,
                    hintText: 'Email',
                  ),
                  SizedBox(height: Spacing.kSpacingHeight),
                  TextField(
                    controller: controller.passwordController.value,
                    hintText: 'Password',
                    isPassword: true,
                    maxLines: 1,
                    suffix: Icon(Icons.remove_red_eye),
                  ),
                  SizedBox(height: Spacing.kSpacingHeight),
                  TextField(
                    controller: controller.repeatPasswordController.value,
                    hintText: 'Ulangi Password',
                    formKey: _formKey,
                    isPassword: true,
                    maxLines: 1,
                  ),
                  SizedBox(height: Spacing.kSpacingHeight),
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(Size(double.infinity, 50)),
                      backgroundColor:
                          MaterialStateProperty.all(Clr.bluePrimary),
                    ),
                    onPressed: () {
                      controller.signUp();
                    },
                    child: Text('Daftar'),
                  ),
                  SizedBox(height: Spacing.kSpacingHeight),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: 'Sudah punya akun? Login ',
                          style: kText10Style.copyWith(color: Colors.black87),
                        ),
                        TextSpan(
                          text: 'disini',
                          style: kText10Style.copyWith(color: Colors.blue),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
