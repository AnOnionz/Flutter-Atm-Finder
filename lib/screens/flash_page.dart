import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(child: Image.asset('images/logo.png', height: MediaQuery.of(context).size.height*0.4,width: MediaQuery.of(context).size.width*0.3,)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("ATMFINDER",
                  style: GoogleFonts.exo(
                      textStyle: TextStyle(
                    color: Colors.black54,
                    letterSpacing: 2.0,
                    fontSize: 30,
                  ))),
            ),
          ],
        ),
      ),
    );
  }
}
