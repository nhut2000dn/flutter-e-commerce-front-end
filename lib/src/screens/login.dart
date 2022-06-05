import 'package:my_novel/blocs/authentication_bloc.dart';
import 'package:my_novel/blocs/login_bloc.dart';
import 'package:my_novel/events/authentication_event.dart';
import 'package:my_novel/events/login_event.dart';
import 'package:my_novel/services/user_service.dart';
import 'package:my_novel/states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_novel/components/no_account_text.dart';
import 'package:my_novel/components/socal_card.dart';
import 'package:my_novel/components/custom_surfix_icon.dart';
import 'package:my_novel/components/form_error.dart';
import 'package:my_novel/helper/keyboard.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class LoginWidget extends StatefulWidget {
  final UserService _userService;
  //constructor
  const LoginWidget({Key? key, required UserService userRepository})
      : _userService = userRepository,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool? remember = false;
  final List<String?> errors = [];
  late LoginBloc _loginBloc;
  UserService get _userService => widget._userService;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  void _onBackPressed() {
    myCallback(() {
      Navigator.pop(context, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        _onBackPressed();
        return Future.value(false);
      },
      child: Scaffold(
        body: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, loginState) {
            if (loginState.isFailure) {
              debugPrint('Login failed');
            } else if (loginState.isSubmitting) {
              debugPrint('Logging in');
            } else if (loginState.isSuccess) {
              //add event: AuthenticationEventLoggedIn ?
              BlocProvider.of<AuthenticationBloc>(context).add(
                AuthenticationEventLoggedIn(),
              );
              myCallback(() {});
            }
            return SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.screenHeight * 0.08),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 25,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.04),
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: getProportionateScreenWidth(28),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Sign in with your email and password  \nor continue with social media",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.08),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            buildEmailFormField(),
                            SizedBox(height: getProportionateScreenHeight(30)),
                            buildPasswordFormField(),
                            SizedBox(height: getProportionateScreenHeight(30)),
                            Row(
                              children: [
                                Checkbox(
                                  value: remember,
                                  activeColor: kPrimaryColor,
                                  onChanged: (value) {
                                    setState(() {
                                      remember = value;
                                    });
                                  },
                                ),
                                const Text("Remember me"),
                                const Spacer(),
                                GestureDetector(
                                  child: const Text(
                                    "Forgot Password",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  ),
                                )
                              ],
                            ),
                            FormError(errors: errors),
                            SizedBox(height: getProportionateScreenHeight(20)),
                            DefaultButton(
                              text: "Continue",
                              press: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  // if all are valid then go to success screen
                                  KeyboardUtil.hideKeyboard(context);
                                  _onLoginEmailAndPassword();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.08),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocalCard(
                            icon: "assets/icons/google-icon.svg",
                            press: () {},
                          ),
                          SocalCard(
                            icon: "assets/icons/facebook-2.svg",
                            press: () {},
                          ),
                          SocalCard(
                            icon: "assets/icons/twitter.svg",
                            press: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      NoAccountText(
                        userRepository: _userService,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return;
      },
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     addError(error: kPassNullError);
      //     return "";
      //   } else if (value.length < 8) {
      //     addError(error: kShortPassError);
      //     return "";
      //   }
      //   return null;
      // },
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return;
      },
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     addError(error: kEmailNullError);
      //     return "";
      //   } else if (!emailValidatorRegExp.hasMatch(value)) {
      //     addError(error: kInvalidEmailError);
      //     return "";
      //   }
      //   return null;
      // },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  void _onLoginEmailAndPassword() {
    _loginBloc.add(LoginEventWithEmailAndPasswordPressed(
        email: email, password: password));
    //Failed because user does not exist
  }

  void myCallback(Function callback) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      callback();
    });
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }
}
