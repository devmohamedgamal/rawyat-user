import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_view_body_widget.dart';
import 'user_info.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({Key? key}) : super(key: key);

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  late StreamSubscription<User?> _authSubscription;
  @override
  void initState() {
    super.initState();
    _authSubscription = _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  @override
  void dispose() {
    // Cancel the subscription in the dispose method.
    _authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_user != null ? 'البروفايل' : 'تسجيل الدخول'),
        centerTitle: true,
      ),
      body: _user != null
          ? UserInfoWidget(
              user: _user!,
            )
          : const LoginViewBodyWidget(),
    );
  }
}
