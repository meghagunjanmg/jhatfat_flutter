import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/Themes/colors.dart';
import 'package:user/Themes/style.dart';
import 'package:user/baseurlp/baseurl.dart';
import 'package:user/bean/currencybean.dart';

class VerificationPage extends StatelessWidget {
  final VoidCallback onVerificationDone;

  VerificationPage(this.onVerificationDone);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Verification',
          style: headingStyle,
        ),
      ),
      body: OtpVerify(onVerificationDone),
    );
  }
}

//otp verification class
class OtpVerify extends StatefulWidget {
  final VoidCallback onVerificationDone;

  OtpVerify(this.onVerificationDone);

  @override
  _OtpVerifyState createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  final TextEditingController _controller = TextEditingController();
  FirebaseMessaging messaging;
  bool isDialogShowing = false;
  dynamic token = '';
  var showDialogBox = false;
  var verificaitonPin = "";
  String phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  String contact = '+911234567890';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Timer _timer;

  @override
  void initState() {
    messaging = FirebaseMessaging();
    messaging.getToken().then((value) {
      token = value;
    });
    super.initState();

   /// generateOtp(contact);

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    MobileNumberArg mobileNumberArg = ModalRoute.of(context).settings.arguments;

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height - 100,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: 10, bottom: 5, right: 80, left: 80),
                      child: Center(
                        child: Text(
                          'Verify your phone number',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: kMainTextColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                        "Enter your otp code here.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 20.0, left: 20.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          PinCodeTextField(
                            autofocus: true,
                            controller: _controller,
                            hideCharacter: false,
                            highlight: true,
                            highlightColor: kHintColor,
                            defaultBorderColor: kMainColor,
                            hasTextBorderColor: kMainColor,
                            maxLength: 4,
                            pinBoxRadius: 20,
                            onDone: (text) {
                              SystemChannels.textInput
                                  .invokeMethod('TextInput.hide');
                              verificaitonPin = text;
                              smsOTP = text as String;
                            },
                            pinBoxWidth: 40,
                            pinBoxHeight: 40,
                            hasUnderline: false,
                            wrapAlignment: WrapAlignment.spaceAround,
                            pinBoxDecoration: ProvidedPinBoxDecoration
                                .roundedPinBoxDecoration,
                            pinTextStyle: TextStyle(fontSize: 22.0),
                            pinTextAnimatedSwitcherTransition:
                                ProvidedPinBoxTextAnimation.scalingTransition,
                            pinTextAnimatedSwitcherDuration:
                                Duration(milliseconds: 300),
                            highlightAnimationBeginColor: Colors.black,
                            highlightAnimationEndColor: Colors.white12,
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 15.0),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Didn't you receive any code?",
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 10.0),
                      new InkWell(
                        onTap: () {
                          ///generateOtp(contact);
                        },
                        child: new Padding(
                          padding: new EdgeInsets.all(10.0),
                          child: new Text("Resend Code"),
                        ),
                      ),
                          SizedBox(height: 10.0),

                          Visibility(
                              visible: showDialogBox,
                              child: Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                )),
            Positioned(
              bottom: 12,
              left: 20,
              right: 20.0,
              child: InkWell(
                onTap: () {
                  if (!showDialogBox) {
                    setState(() {
                      showDialogBox = true;
                    });
                  }
                 /// verifyOtp();
                  widget.onVerificationDone();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: kMainColor),

                  child: Text(
                    'Verify',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: kWhiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void hitService(String verificaitonPin, BuildContext context) async {
    if (token != null && token.toString().length > 0) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var url = verifyPhone;
      await http.post(url, body: {
        'phone': prefs.getString('user_phone'),
        'otp': verificaitonPin,
        'device_id': '${token}'
      }).then((response) {
        print('Response Body: - ${response.body}');
        if (response.statusCode == 200) {
          print('Response Body: - ${response.body}');
          var jsonData = jsonDecode(response.body);
          if (jsonData['status'] == 1) {
            var userId = int.parse('${jsonData['data']['user_id']}');
            prefs.setInt("user_id", userId);
            prefs.setString("user_name", jsonData['data']['user_name']);
            prefs.setString("user_email", jsonData['data']['user_email']);
            prefs.setString("user_image", jsonData['data']['user_image']);
            prefs.setString("user_phone", jsonData['data']['user_phone']);
            prefs.setString("user_password", jsonData['data']['user_password']);
            prefs.setString(
                "wallet_credits", jsonData['data']['wallet_credits']);
            prefs.setString("first_recharge_coupon",
                jsonData['data']['first_recharge_coupon']);
            prefs.setBool("phoneverifed", true);
            prefs.setBool("islogin", true);
            prefs.setString("refferal_code", jsonData['data']['referral_code']);
            if (jsonData['currency'] != null) {
              CurrencyData currencyData =
                  CurrencyData.fromJson(jsonData['currency']);
              print('${currencyData.toString()}');
              prefs.setString("curency", '${currencyData.currency_sign}');
            }
            widget.onVerificationDone();
          } else {
            prefs.setBool("phoneverifed", false);
            prefs.setBool("islogin", false);
            setState(() {
              showDialogBox = false;
            });
          }
        } else {
          setState(() {
            showDialogBox = false;
          });
        }
      }).catchError((e) {
        print(e);
        setState(() {
          showDialogBox = false;
        });
      });
    } else {
      messaging.getToken().then((value) {
        token = value;
        hitService(verificaitonPin, context);
      });
    }
  }


  // //Method for generate otp from firebase
  // Future<void> generateOtp(String contact) async {
  //   final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
  //     verificationId = verId;
  //     print("** "+verificationId);
  //   };
  //   try {
  //     await _auth.verifyPhoneNumber(
  //         phoneNumber: contact,
  //         codeAutoRetrievalTimeout: (String verId) {
  //           verificationId = verId;
  //         },
  //         codeSent: smsOTPSent,
  //         timeout: const Duration(seconds: 60),
  //         verificationCompleted: (AuthCredential phoneAuthCredential) {},
  //         verificationFailed: (AuthException exception) {
  //           // Navigator.pop(context, exception.message);
  //         });
  //   } catch (e) {
  //     handleError(e as PlatformException);
  //     // Navigator.pop(context, (e as PlatformException).message);
  //   }
  // }
  //
  // //Method for verify otp entered by user
  // Future<void> verifyOtp() async {
  //   if (smsOTP == null || smsOTP == '') {
  //     showAlertDialog(context, 'please enter 6 digit otp');
  //     return;
  //   }
  //   try {
  //     final AuthCredential credential = PhoneAuthProvider.getCredential(
  //       verificationId: verificationId,
  //       smsCode: smsOTP,
  //     );
  //     final AuthResult user = await _auth.signInWithCredential(credential);
  //     final FirebaseUser currentUser = await _auth.currentUser();
  //     assert(user.user.uid == currentUser.uid);
  //     print("=="+currentUser.phoneNumber);
  //
  //     hitService(smsOTP, context);
  //
  //   } catch (e) {
  //     handleError(e as PlatformException);
  //   }
  // }
  //
  // //Method for handle the errors
  // void handleError(PlatformException error) {
  //   switch (error.code) {
  //     case 'ERROR_INVALID_VERIFICATION_CODE':
  //       FocusScope.of(context).requestFocus(FocusNode());
  //       setState(() {
  //         errorMessage = 'Invalid Code';
  //       });
  //       showAlertDialog(context, 'Invalid Code');
  //       break;
  //     default:
  //       showAlertDialog(context, error.message);
  //       break;
  //   }
  // }
  //
  // //Basic alert dialogue for alert errors and confirmations
  // void showAlertDialog(BuildContext context, String message) {
  //   // set up the AlertDialog
  //   final CupertinoAlertDialog alert = CupertinoAlertDialog(
  //     title: const Text('Error'),
  //     content: Text('\n$message'),
  //     actions: <Widget>[
  //       CupertinoDialogAction(
  //         isDefaultAction: true,
  //         child: const Text('Ok'),
  //         onPressed: () {
  //           Navigator.of(context).pop();
  //         },
  //       )
  //     ],
  //   );
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

}
