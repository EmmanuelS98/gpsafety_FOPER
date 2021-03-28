import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';



import 'package:gpsafety2/routes/iconsNavigationBar.dart';
import 'package:gpsafety2/sources/peges/UserManual.dart';
import 'package:gpsafety2/sources/peges/devises.dart';
import 'package:gpsafety2/sources/peges/newDevise.dart';
import 'package:gpsafety2/sources/peges/userProfile.dart';//ayudaaaaaa




class HomePage extends StatefulWidget {
  
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  int _page = 1;

  @override
  Widget build(BuildContext context) {  
    //final bloc = Provider.of(context);
    //devises sera el homepageScreen
    final List<Widget> _tabItems = [UserProfile(),Devises(),UserManual(),NewDevise()];

    return Scaffold(
      
      body:_tabItems[_page],      
      bottomNavigationBar: CurvedNavigationBar(
        index: _page,
        items: getIcon(),
        color: Color.fromRGBO(72, 172, 77,1),
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.green,
        height: 50,
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.bounceInOut,
        onTap:  (index){
          setState(() {
            _page = index;
          });
        } , 
      ),
      
    );

  }


  
}  