import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:jotter_mapper/controllers/auth_controller.dart';
import 'package:jotter_mapper/routing/router.dart';
import 'package:jotter_mapper/screens/auth/registration_screen.dart';
import 'package:jotter_mapper/widgets/general-widgets/custom_button.dart';
import 'package:jotter_mapper/widgets/general-widgets/text_field_with_label.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';
import 'package:jotter_mapper/widgets/general-widgets/waiting_dialog.dart';

class LoginScreen extends StatefulWidget {
  static const String name = "Login Screen";
  static const String route = "/login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController email, password;
  late FocusNode emailFn, passwordFn;
  bool obfuscate = false;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    email = TextEditingController();
    password = TextEditingController();
    emailFn = FocusNode();
    passwordFn = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
    emailFn.dispose();
    passwordFn.dispose();
  }

  void toggleObfuscate() {
    setState(() {
      obfuscate = !obfuscate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leadingWidth: 80,
        // leading: BackButton(),
        title: Text(
          "Login",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                "Log in with one of the following options.",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: ColorPalette.dark600),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    decoration: BoxDecoration(
                        color: ColorPalette.dark200,
                        border: Border.all(
                          color: ColorPalette.dark300,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: SvgPicture.asset(
                      "assets/icons/google_logo.svg",
                      width: 30,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    decoration: BoxDecoration(
                        color: ColorPalette.dark200,
                        border: Border.all(
                          color: ColorPalette.dark300,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: SvgPicture.asset(
                      "assets/icons/facebook_logo.svg",
                      width: 30,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFieldWithLabel(
                      label: "Email",
                      icon: const Icon(Icons.email_outlined),
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: 'Please fill out the email'),
                        MaxLengthValidator(32,
                            errorText:
                                "Email Address cannot exceed 32 characters"),
                        EmailValidator(
                            errorText: "Please select a valid email"),
                      ]).call,
                      controller: email,
                      fn: emailFn,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFieldWithLabel(
                      label: "Password",
                      icon: const Icon(Icons.lock_outline_rounded),
                      controller: password,
                      keyboardType: TextInputType.visiblePassword,
                      fn: passwordFn,
                      isPassword: true,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Password is required"),
                        MinLengthValidator(12,
                            errorText:
                                "Password must be at least 12 characters long"),
                        MaxLengthValidator(128,
                            errorText: "Password cannot exceed 128 characters"),
                        PatternValidator(
                          r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+?\-=[\]{};':,.<>]).*$",
                          errorText:
                              'Password must contain at least one symbol, one uppercase letter, one lowercase letter, and one number.',
                        ),
                      ]).call,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                  func: () async {
                    if (formKey.currentState!.validate()) {
                      WaitingDialog.show(context,
                          future: AuthController.I
                              .login(email.text.trim(), password.text.trim()));
                    }
                  },
                  text: "Log in"),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: ColorPalette.mixed600),
                  ),
                  GestureDetector(
                    onTap: () {
                      GlobalRouter.I.router.push(RegistrationScreen.route);
                    },
                    child: Text(
                      "Sign up",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: ColorPalette.washedWhite),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
