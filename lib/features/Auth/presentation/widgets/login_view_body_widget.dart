import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/functions/login_with_gmail.dart';
import '../../../../core/utils/assets_manger.dart';

class LoginViewBodyWidget extends StatelessWidget {
  const LoginViewBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Authentication authMetods = Authentication();
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          children: [
            Image.asset(
              AssetsManger.loginImage,
              height: 300,
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                authMetods.signInWithGoogle(onSignIn: () {
                  context.pushReplacement('/');
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetsManger.gmailIcon,
                    height: 30,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'تسجيل بحساب جوجل',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
