import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_player_admin/resources/firestore_methods.dart';
import 'package:video_player_admin/views/add_screen.dart';
import 'package:video_player_admin/widgets/custom_button.dart';
import 'package:video_player_admin/widgets/text_field.dart';

import '../resources/auth_methods.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await AuthMethods().signOut(context);

                Get.offAll(() => const LoginScreen());
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ))
        ],
        title: const Text(
          "Home",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Previously Uploaded Videos",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            16.heightBox,
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('uid', isEqualTo: FirestoreMethods().curUser)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.redAccent,
                    ),
                  );
                }

                var snap = snapshot.data!.docs[0]['videos'];

                return Text("Test ${snap[0]['title']}");
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          Get.to(() => const AddScreen());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
