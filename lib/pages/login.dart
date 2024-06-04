import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

GetStorage box = GetStorage();

class LoginPage extends StatelessWidget {
  final LoginController loginCtrl = Get.put(LoginController());
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: mobileController,
              decoration: const InputDecoration(labelText: 'Mobile'),
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Perform login logic here
                // For simplicity, let's assume login is successful
                //Get.offNamed('/home');
                loginCtrl.loginVerify(mobileController.text.trim(),
                    passwordController.text.trim());
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Get.toNamed('/register');
              },
              child: const Text('Create an account'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginController extends GetxController {
  //var url = box.read('apiurl');
  String url = "your ip address:5000";
  void loginVerify(mob, pwd) async {
    Get.dialog(
      loading(), barrierDismissible: false,
      //useRootNavigator: false
    );
    Uri uri;
    const path = "/api/users/login";
    uri = Uri.http(url, path);
    var res = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"mobile": mob, "password": pwd}));

    if (res.statusCode == 200) {
      //Redirect to LoginOtpVerify Page
      Get.close(1);
      Get.offNamed('/home', arguments: mob);
    }
    if (res.statusCode == 400) {
      //Open Server error Dialog
      Get.close(1);
      Get.snackbar('Error', 'Server Error, Please try again later',
          margin: const EdgeInsets.all(8),
          backgroundColor: Colors.red,
          icon: const Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white);
    }
  }

  loading() {
    return PopScope(
      canPop: false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
