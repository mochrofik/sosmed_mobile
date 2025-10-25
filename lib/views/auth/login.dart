import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yure_connect_apps/components/buttons/buttoncustom.dart';
import 'package:yure_connect_apps/components/text_form/passwordcard.dart';
import 'package:yure_connect_apps/components/text_form/textformcard.dart';
import 'package:yure_connect_apps/components/yuretext.dart';
import 'package:yure_connect_apps/provider/auth_provider.dart';
import 'package:yure_connect_apps/utils/AppColors.dart';
import 'package:yure_connect_apps/utils/app_key.dart';
import 'package:yure_connect_apps/views/auth/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    print("dispose login");
    emailC.dispose();
    passwordC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(builder: (
        context,
        authProvider,
        child,
      ) {
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            YureText(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const SizedBox(
                        child: Text(
                          "Login to your Account",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Robot",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormCard(
                        controller: emailC,
                        hintText: "Email...",
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty || !p0.contains("@")) {
                            return "input email correctly";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PasswordCard(
                        onTapIcon: () => authProvider.obscureText(),
                        hintText: "Password",
                        controller: passwordC,
                        obscureText: authProvider.isObscureText,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "input password correctly";
                          }
                          return null;
                        },
                      ),
                      if (authProvider.errorMessage != null) ...[
                        Text(
                          authProvider.errorMessage ?? "",
                          style: const TextStyle(color: Colors.red),
                        )
                      ],
                      if (authProvider.isLoggedIn) ...[
                        const Text(
                          "Login Berhasil",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        )
                      ],
                      const SizedBox(height: 10),
                      ButtonCustom(
                        onPressed: authProvider.isLoading
                            ? null
                            : () async {
                                if (!_formKey.currentState!.validate()) {
                                  showSnackbar("Ops.. something wrong!");
                                } else {
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .login(emailC.text, passwordC.text);
                                }
                              },
                        backgroundColor: Appcolors.primaryColor,
                        child: authProvider.isLoading
                            ? const CircularProgressIndicator(
                                strokeWidth: 1,
                              )
                            : const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                InkWell(
                  onTap: () {
                    _formKey.currentState!.reset();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Register(),
                      ),
                    );
                  },
                  child: const Text(
                    " Register",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        );
      }),
    );
  }
}
