import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:jotter_mapper/controllers/auth_controller.dart';
import 'package:jotter_mapper/widgets/general-widgets/back_button.dart';
import 'package:jotter_mapper/widgets/general-widgets/custom_button.dart';
import 'package:jotter_mapper/widgets/general-widgets/waiting_dialog.dart';
import 'package:jotter_mapper/widgets/general-widgets/text_field_with_label.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static const String name = "Registration Screen";
  static const String route = "/route";

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController nickname, email, password, confirmPassword;
  late FocusNode nicknameFn, emailFn, passwordFn, confirmPasswordFn;
  bool obfuscate = false;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();

    nickname = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();

    nicknameFn = FocusNode();
    emailFn = FocusNode();
    passwordFn = FocusNode();
    confirmPasswordFn = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    nickname.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();

    nicknameFn.dispose();
    emailFn.dispose();
    passwordFn.dispose();
    confirmPasswordFn.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: CustomBackButton(
          func: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Sign up",
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
                "Sign up with one of the following options.",
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
                      label: "Nickname",
                      icon: const Icon(Icons.person_2_outlined),
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: 'Please fill out your Nickname'),
                        MaxLengthValidator(32,
                            errorText:
                                "Email Address cannot exceed 32 characters"),
                      ]).call,
                      controller: nickname,
                      fn: nicknameFn,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                      icon: Icon(Icons.lock_outline_rounded),
                      keyboardType: TextInputType.visiblePassword,
                      controller: password,
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
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWithLabel(
                        label: "Confirm Password",
                        icon: Icon(Icons.lock_outline_rounded),
                        controller: confirmPassword,
                        fn: confirmPasswordFn,
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
                        validator: (v) {
                          String? doesMatchPasswords =
                              password.text == confirmPassword.text
                                  ? null
                                  : "Passwords doesn't match";
                          if (doesMatchPasswords != null) {
                            return doesMatchPasswords;
                          } else {
                            return MultiValidator([
                              RequiredValidator(
                                  errorText: "Password is required"),
                              MinLengthValidator(12,
                                  errorText:
                                      "Password must be at least 12 characters long"),
                              MaxLengthValidator(128,
                                  errorText:
                                      "Password cannot exceed 72 characters"),
                              PatternValidator(
                                  r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+?\-=[\]{};':,.<>]).*$",
                                  errorText:
                                      'Password must contain at least one symbol, one uppercase letter, one lowercase letter, and one number.'),
                            ]).call(v);
                          }
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                  func: () {
                    if (formKey.currentState!.validate()) {
                      WaitingDialog.show(context,
                          future: AuthController.I.register(email.text.trim(),
                              password.text.trim(), nickname.text.trim()));
                    }
                  },
                  text: "Create Account"),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
