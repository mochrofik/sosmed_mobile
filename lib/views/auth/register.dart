import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yure_connect_apps/components/buttons/buttoncustom.dart';
import 'package:yure_connect_apps/components/text_form/passwordcard.dart';
import 'package:yure_connect_apps/components/text_form/textformcard.dart';
import 'package:yure_connect_apps/components/yuretext.dart';
import 'package:yure_connect_apps/provider/auth_provider.dart';
import 'package:yure_connect_apps/utils/AppColors.dart';
import 'package:yure_connect_apps/utils/GlobalFunctions.dart';
import 'package:yure_connect_apps/utils/app_key.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController nameC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  final TextEditingController passwordConfirmC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    print("dispose register");

    nameC.dispose();
    emailC.dispose();
    passwordC.dispose();
    passwordConfirmC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height10 = SizedBox(
      height: 10,
    );
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) => PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          authProvider.setNull();
        },
        child: Scaffold(
          body: Column(
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
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          YureText(),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const SizedBox(
                        child: Text(
                          "Register your Account",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Robot",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (authProvider.statusResponse == '201') ...[
                        Text(
                          "Register successfully",
                          style: TextStyle(color: Appcolors.primaryColor),
                        ),
                      ] else if (authProvider.statusResponse != null &&
                          authProvider.statusResponse != "201") ...[
                        Text(
                          authProvider.errorMessage ?? "Error",
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        )
                      ],
                      TextFormCard(
                        controller: nameC,
                        hintText: "Name...",
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "input name correctly";
                          }
                          return null;
                        },
                      ),
                      height10,
                      TextFormCard(
                        controller: emailC,
                        hintText: "Email...",
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "input email correctly";
                          }
                          return null;
                        },
                      ),
                      height10,
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                decoration:
                                    GlobalFunctions.inputBorderForm("Gender"),
                                isExpanded: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "input gender correctly";
                                  }
                                  return null;
                                },
                                hint: const Text(
                                  "Gender...",
                                  style: TextStyle(
                                      color: Colors.black45, fontSize: 14),
                                ),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                                value: authProvider.valueGender,
                                items: ["Male", "Female"]
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  authProvider.changeGender(value!);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      height10,
                      PasswordCard(
                        onTapIcon: () {
                          authProvider.obscureText();
                        },
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "input password correctly";
                          }
                          return null;
                        },
                        controller: passwordC,
                        hintText: "Password...",
                        obscureText: authProvider.isObscureText,
                      ),
                      height10,
                      PasswordCard(
                        onTapIcon: () {
                          authProvider.obscureTextConfirm();
                        },
                        controller: passwordConfirmC,
                        hintText: "Password Confirm...",
                        obscureText: authProvider.isObscureTextConfirm,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "input password confirm correctly";
                          }
                          return null;
                        },
                      ),
                      height10,
                      ButtonCustom(
                        onPressed: authProvider.isLoading
                            ? null
                            : () async {
                                if (!_formKey.currentState!.validate()) {
                                  showSnackbar("Ops.. something wrong!");
                                } else {
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .register(
                                          nameC,
                                          emailC,
                                          authProvider.valueGender ?? "",
                                          passwordC,
                                          passwordConfirmC);
                                }
                              },
                        backgroundColor: Appcolors.primaryColor,
                        child: authProvider.isLoading
                            ? const CircularProgressIndicator(
                                strokeWidth: 1,
                              )
                            : const Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
