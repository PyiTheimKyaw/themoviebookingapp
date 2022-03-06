// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/pages/home_page.dart';
import 'package:the_movie_booking_app/rescources/colors.dart';
import 'package:the_movie_booking_app/rescources/dimens.dart';
import 'package:the_movie_booking_app/rescources/strings.dart';
import 'package:the_movie_booking_app/widgets/blur_title_text_view.dart';
import 'package:the_movie_booking_app/widgets/floating_action_button_view.dart';
import 'package:the_movie_booking_app/widgets/title_text_view.dart';
import 'dart:async';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController passwordController = TextEditingController();

bool isloginIn = false;

class LoginAndSignInPage extends StatefulWidget {
  @override
  _LoginAndSignInPageState createState() => _LoginAndSignInPageState();
}

class _LoginAndSignInPageState extends State<LoginAndSignInPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(
      text: LOGIN_TAB_TEXT,
    ),
    Tab(
      text: SIGN_IN_TAB_TEXT,
    ),
  ];
  MovieModel mMovieModel = MovieModelImpl();
  TabController? _tabController;
  Map<String, dynamic>? userDataInfo;
  AccessToken? _accessToken;
  bool isFacebook = true;
  bool isGoogle = true;
  String? googleId;

  Future<void> _login() async {
    final LoginResult result = await FacebookAuth.instance
        .login(); // by default we request the email and the public profile

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      // get the user data
      // by default we get the userId, email,name and picture
      // final userData = await FacebookAuth.instance.getUserData();
      final userData =
          await FacebookAuth.instance.getUserData(fields: "email,name");
      userDataInfo = userData;
    } else {
      print(result.status);
      print(result.message);
    }

    setState(() {});
  }

  @override
  void initState() {
    // mMovieModel.getLoginUserIfoDatabase();
    // mMovieModel.getRegisterUserInfoDatabase();
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void showAlertBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Warning!!"),
        content: Text("Please check your input data "),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Okay"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
          width: MediaQuery.of(context).size.width * 0.93,
          height: FLOATING_ACTION_BUTTON_HEIGHT,
          child: FloatingActionButton.extended(
            backgroundColor: PRIMARY_COLOR,
            onPressed: () {
              print('Tab index is ${_tabController?.index}');
              if (_tabController?.index == 0) {
                setState(() {
                  // mMovieModel.logoutUserFromDatabase();
                  mMovieModel
                      .loginWithEmail(
                          emailController.text, passwordController.text)
                      .then((value) {
                    mMovieModel.getLoginUserIfoDatabase();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                                userData: userDataInfo,
                                googleId: googleId ?? "",
                              )),
                    );
                  }).catchError((error) {
                    showAlertBox();
                  });
                });
              }
              if (_tabController?.index == 1) {
                setState(() {
                  // mMovieModel.logoutUserFromDatabase();
                  if (isFacebook == true) {
                    mMovieModel
                        .registerWithEmail(
                      nameController.text,
                      emailController.text,
                      phoneController.text,
                      passwordController.text,
                      "",
                      userDataInfo?["id"],
                    )
                        .then((value) {
                      print("Login with facebook successfully");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                  userData: userDataInfo,
                                  googleId: googleId ?? "",
                                )),
                      );
                      mMovieModel.getRegisterUserInfoDatabase();
                    }).catchError((errorr) {
                      showAlertBox();
                    });
                  } else if (isGoogle == true) {
                    mMovieModel
                        .registerWithEmail(
                      nameController.text,
                      emailController.text,
                      phoneController.text,
                      passwordController.text,
                      googleId,
                      "",
                    )
                        .then((value) {
                      print("sign with google successfully");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                  userData: userDataInfo,
                                  googleId: googleId ?? "",
                                )),
                      );
                      mMovieModel.getRegisterUserInfoDatabase();
                    }).catchError((error) {
                      showAlertBox();
                    });
                  } else {
                    mMovieModel
                        .registerWithEmail(
                      nameController.text,
                      emailController.text,
                      phoneController.text,
                      passwordController.text,
                      "",
                      "",
                    )
                        .then((value) {
                      print("Login without facebook and google successfully");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                  userData: userDataInfo,
                                  googleId: googleId ?? "",
                                )),
                      );
                      mMovieModel.getRegisterUserInfoDatabase();
                    }).catchError((errorr) {
                      showAlertBox();
                    });
                  }
                });

                // mMovieModel.getLoginUserIfoDatabase();
              }
            },
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            label: Text(
              'Confirm',
              style: TextStyle(
                fontSize: TEXT_REGULAR,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
          backgroundColor: Colors.white,
          elevation: 0,
          titleSpacing: MARGIN_MEDIUM_2,
          title: LoginAndSignInTitleSectionView(),
          bottom: TabBar(
            padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
            indicatorColor: PRIMARY_COLOR,
            unselectedLabelColor: Colors.black,
            labelColor: PRIMARY_COLOR,
            labelStyle: TextStyle(
              fontSize: MARGIN_MEDIUM_3,
              fontWeight: FontWeight.w500,
            ),
            controller: _tabController,
            tabs: myTabs,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            AccountLoginAndSignInSectionView(
              textFieldVisibility: false,
              name: nameController.text,
              email: emailController.text,
              phone: phoneController.text,
              password: passwordController.text,
              onTapFacebook: () async {
                final LoginResult result = await FacebookAuth.instance
                    .login(); // by default we request the email and the public profile

                if (result.status == LoginStatus.success) {
                  _accessToken = result.accessToken;

                  final userData = await FacebookAuth.instance
                      .getUserData(fields: "email,name");
                  userDataInfo = userData;
                  mMovieModel.loginWithFacebook(userData["id"]).then((value) {
                    if (value != null) {
                      print('User id ${userData["id"]}');

                      print("Login up with facebook successfully");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                  userData: userDataInfo,
                                  googleId: googleId ?? "",
                                )),
                      );
                    }
                  }).catchError((eror) {
                    showAlertBox();
                    print(eror.toString());
                  });
                } else {
                  noAccountDialog(context);
                }

                print('This is on tap facebook in sign in page');
              },
              onTapGoogle: () {
                GoogleSignIn _googleSignIn = GoogleSignIn(
                  scopes: [
                    'email',
                    'https://www.googleapis.com/auth/contacts.readonly',
                  ],
                );

                _googleSignIn.signIn().then((googleAccount) {
                  googleAccount?.authentication.then((authentication) {
                    isGoogle = true;

                    //googleId = googleAccount.id;
                    mMovieModel
                        .loginWithGoogle(googleAccount.id ?? "")
                        .then((value) {
                      print("Google id at login ${googleAccount.id}");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                  userData: userDataInfo,
                                  googleId: googleId ?? "",
                                )),
                      );
                    }).catchError((error) {
                      showAlertBox();
                    });
                  }).catchError((error) {
                    showAlertBox();
                  });
                }).catchError((error) {
                  noAccountDialog(context);
                });

                print('This is on tap google in sign in page');
              },
            ),
            AccountLoginAndSignInSectionView(
              name: nameController.toString(),
              email: emailController.toString(),
              phone: phoneController.toString(),
              password: passwordController.toString(),
              onTapFacebook: () {
                _login().then((value) {
                  isFacebook = true;
                  isGoogle = false;
                  emailController.text = userDataInfo?["email"] ?? "";
                  nameController.text = userDataInfo?["name"] ?? "";
                });

                print('This is on tap facebook in sign up page');
              },
              onTapGoogle: () {
                GoogleSignIn _googleSignIn = GoogleSignIn(
                  scopes: [
                    'email',
                    'https://www.googleapis.com/auth/contacts.readonly',
                  ],
                );
                _googleSignIn.signIn().then((googleAccount) {
                  googleAccount?.authentication.then((authentication) {
                    isGoogle = true;
                    isFacebook = false;
                    emailController.text = googleAccount.email;
                    nameController.text = googleAccount.displayName ?? "";

                    googleId = googleAccount.id;
                    print("Google id => ${authentication.accessToken}");
                    print("Google id state variable => $googleId");
                  });
                }).catchError((error) {
                  print(error.toString());
                });
                print('This is on tap google in sign up page');
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> noAccountDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Warning!!"),
        content: Text("There is no registered Account"),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Okay"),
          ),
        ],
      ),
    );
  }
}

class LoginAndSignInTitleSectionView extends StatelessWidget {
  const LoginAndSignInTitleSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(
            WELCOME_SCREEN_WELCOME_TEXT,
            textColor: Colors.black,
          ),
          SizedBox(
            height: MARGIN_MEDIUM_1,
          ),
          BlurTitleText(
            LOGIN_SIGN_IN_PAGE_TEXT,
            LOGIN_SIGNIN_PAGE_TEXT_COLOR,
          ),
        ],
      ),
    );
  }
}

class AccountLoginAndSignInSectionView extends StatefulWidget {
  final bool textFieldVisibility;
  final Function onTapFacebook;
  final Function onTapGoogle;

  String name;
  String email;
  String phone;
  String password;

  AccountLoginAndSignInSectionView({
    this.textFieldVisibility = true,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.onTapFacebook,
    required this.onTapGoogle,
  });

  @override
  State<AccountLoginAndSignInSectionView> createState() =>
      _AccountLoginAndSignInSectionViewState();
}

class _AccountLoginAndSignInSectionViewState
    extends State<AccountLoginAndSignInSectionView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM_2,
        ),
        child: Column(
          children: [
            Visibility(
              visible: widget.textFieldVisibility,
              child: TextFieldView(
                USERNAME_TEXT,
                inputController: nameController,
                // input: name,
              ),
            ),
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            TextFieldView(
              EMAIL_TEXT,
              inputController: emailController,
              // input: email,
            ),
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            Visibility(
              visible: widget.textFieldVisibility,
              child: TextFieldView(
                PHONE_NUMBER_TEXT,
                isPhNumber: true,
                inputController: phoneController,
                // input: phone,
              ),
            ),
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            TextFieldView(
              PASSWORD_TEXT,
              isObscureText: true,
              inputController: passwordController,
              // input: password,
            ),
            SizedBox(
              height: MARGIN_MEDIUM_2,
            ),
            ForgotPasswordView(),
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            LoginAndSignInButtonView(
              text: SIGN_IN_WITH_FACEBOOK_TEXT,
              image: Image.asset(
                'images/facebook.png',
              ),
              onTap: widget.onTapFacebook,
            ),
            SizedBox(
              height: MARGIN_LARGE,
            ),
            LoginAndSignInButtonView(
              text: SIGN_IN_WITH_GOOGLE_TEXT,
              image: Image.asset('images/google.png'),
              onTap: widget.onTapGoogle,
            ),
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: MARGIN_MEDIUM_2),
      child: Align(
        alignment: Alignment.topRight,
        child: TextButton(
          onPressed: () {},
          child: Text(
            FORGOT_PASSWORD_TEXT,
            style: TextStyle(color: Colors.black26),
          ),
        ),
      ),
    );
  }
}

class LoginAndSignInButtonView extends StatelessWidget {
  final String text;
  final Image image;
  final Function onTap;

  LoginAndSignInButtonView({
    required this.text,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.only(right: MARGIN_MEDIUM_2),
        width: MediaQuery.of(context).size.width,
        height: FLOATING_ACTION_BUTTON_HEIGHT,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.black12,
            width: 1,
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(left: MARGIN_LARGE),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 6,
                child: image,
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: TEXT_REGULAR,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldView extends StatelessWidget {
  final String label;
  final bool isObscureText;
  final bool isPhNumber;

  TextEditingController inputController = TextEditingController();

  // String input;

  // String email;
  // String phone;
  // String password;

  TextFieldView(
    this.label, {
    this.isObscureText = false,
    this.isPhNumber = false,
    required this.inputController,
    // required this.input,
    //required this.email, required this.phone, required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      // onChanged: (userInput) => input = userInput,
      obscureText: isObscureText,
      controller: inputController,
      keyboardType: isPhNumber ? TextInputType.number : null,
      inputFormatters: isPhNumber
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : null,
      decoration: InputDecoration(
        focusColor: Colors.red,
        labelText: label,
        labelStyle: TextStyle(color: Colors.black26, fontSize: 18),
      ),
    );
  }
}
