import 'package:course_hotelio/config/app_asset.dart';
import 'package:course_hotelio/config/app_color.dart';
import 'package:course_hotelio/config/app_route.dart';
import 'package:course_hotelio/source/user_source.dart';
import 'package:course_hotelio/widget/button_custom.dart';
import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  login(BuildContext context) {
    if (formKey.currentState!.validate()) {
      UserSource.signIn(controllerEmail.text, controllerPassword.text)
          .then((response) {
        if (response['success']) {
          DInfo.dialogSuccess(context, response['message']);
          DInfo.closeDialog(
            context,
            actionAfterClose: () {
              Navigator.pushReplacementNamed(context, AppRoute.home);
            },
          );
        } else {
          DInfo.toastError(response['message']);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAsset.logo,
                      width: 100,
                      fit: BoxFit.fitWidth,
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sign In\nTo Your Account',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: controllerEmail,
                      validator: (value) =>
                          value == '' ? "Please input your email" : null,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        hintText: "example@email.com",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: AppColor.secondary),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: controllerPassword,
                      validator: (value) =>
                          value == '' ? "Please input your password" : null,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        hintText: "Your password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: AppColor.secondary),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        labelText: 'Password',
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonCustom(
                      label: 'Sign In',
                      isExpanded: true,
                      onTap: () => login(context),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      'Create a new account',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    ));
  }
}
