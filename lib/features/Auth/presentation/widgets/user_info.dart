import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/functions/login_with_gmail.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key, required this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Handle loading state
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Handle error state
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            // Handle document not found
            return const Text('Document not found');
          } else {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      user!.email.toString(),
                      style: const TextStyle(fontSize: 24),
                    ),
                    const Spacer(),
                    !snapshot.hasData
                        ? Container()
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Authentication.signOutFromGoogle(onSignIn: () {
                                context.pushReplacement('/');
                              });
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.login_outlined),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'تسجيل  خروج',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
