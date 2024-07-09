import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groupiq_flutter/models/verif_props.dart';

class VerificationView extends StatelessWidget {
  VerifProps? props;
  VerificationView({super.key, this.props});

  @override
  Widget build(BuildContext context) {
    TextStyle customBodyMediumStyle =
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white);
    TextStyle customDisplayLargeStyle =
        Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.white);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 115, 248, 1),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: const AssetImage("assets/images/confirm-bg.png"),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "One More Step!",
                  style: customDisplayLargeStyle,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "We’ve sent an email to ${props?.email ?? "your email"}.  Before using Groupiq, you’ll need to verify your email through the link included in the email.",
                          style: customBodyMediumStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Haven’t received an email?  Press the button below to get a new confirmation link.  Remember to check your spam folder!",
                          style: customBodyMediumStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: ElevatedButton(
                            onPressed: () {
                              print("Hello World");
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 10.0),
                              child: Text('Resend Email',
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: const Color.fromRGBO(
                                          86, 144, 255, 1))),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
