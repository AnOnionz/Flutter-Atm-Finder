import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 1,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue[400],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('images/logo.png', height: MediaQuery.of(context).size.height*0.1,width: MediaQuery.of(context).size.width*0.06,),
                  Text("ATM FINDER", style: TextStyle(color: Colors.black54),),
                  Text("v1.0.0", style: TextStyle(color: Colors.black54)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Một ứng dụng cho phép tìm kiếm các máy Atm xung quanh bạn nhanh chóng và dễ dàng", style: GoogleFonts.exo(),),
                SizedBox(height: 10,),
                Text("Developed by Jh98", style: GoogleFonts.exo()),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop) ,
            title: Text("Đánh giá trên Google Play"),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_mail) ,
            title: Text("Phản hòi với chúng tôi"),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.assistant_photo),
            title: Text("Chính sách và đièu khoản"),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text("Giới thiệu"),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
