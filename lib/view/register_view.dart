import 'package:final_bloc_example/bloc/app_Bloc.dart';
import 'package:final_bloc_example/bloc/app_event.dart';
import 'package:final_bloc_example/extension/if_debugging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RegistrationView extends HookWidget {
  const RegistrationView({Key? key}) : super(key: key);

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
        title: const Text("Registration"),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(hintText: "Enter your email"),
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(hintText: "Enter your password"),
            obscureText: true,
          ),
          TextButton(
            onPressed: () {
              final email = emailController.text;
              final password = passwordController.text;
              context.read<AppBloc>().add(
                    AppEventRegister(
                      email: email,
                      password: password,
                    ),
                  );
            },
            child: const Text("Register"),
          ),
          TextButton(
            onPressed: () {
              context.read<AppBloc>().add(
                    const AppEventGoToLogin(),
                  );
            },
            child: const Text("Already Registered yet? Login here"),
          ),
        ],
      ),
    );
  }
}
