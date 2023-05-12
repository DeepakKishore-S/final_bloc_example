import 'package:final_bloc_example/extension/if_debugging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginView extends HookWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(
      text: "sdk@gmail.com".ifDebugging,
    );
    final passwordController = useTextEditingController(
      text: "123456".ifDebugging,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log in"),
      ),
      body: Column(
         children: [
           TextField(controller: emailController,
           decoration: const InputDecoration(hintText: "Enter your email"),
           keyboardType: TextInputType.emailAddress,),
           TextField(controller: passwordController,
           decoration: const InputDecoration(hintText: "Enter your password"),
           obscureText: true,)
         ],
      ),
    );
  }
}
