import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.black),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SocioCredz Admin',
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: double.maxFinite,
                child: Image.asset(
                  "assets/images/landing.gif",
                  fit: BoxFit.cover,
                ),
              ),
              Opacity(
                opacity: 0.3,
                child: Container(
                  color: Colors.black,
                ),
              ),
              Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Container(
                        child: SvgPicture.asset("assets/images/logo.svg"),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(horizontal: 48),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hey there!,\nReward your loyal clients.",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 56),
                          MaterialButton(
                            height: 55,
                            minWidth: double.maxFinite,
                            onPressed: () async {
                              var status = await Permission.camera.status;
                              if (status.isGranted) {
                                String userID = await scanner.scan();
                                if (userID != null) {
                                  print(userID);
                                }
                              } else {
                                var res = await Permission.camera.request();
                                if (res.isGranted) {
                                  String userID = await scanner.scan();
                                  if (userID != null) {
                                    print(userID);
                                  }
                                }
                              }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            color: Color(0xFFFC257E),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.qr_code,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Tap to Pay",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
