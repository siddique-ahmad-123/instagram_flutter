
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/utilitise/colors.dart';
import 'package:instagram_flutter/utilitise/global_variable.dart';

class mobileScreenLayout extends StatefulWidget {
  const mobileScreenLayout({super.key});

  @override
  State<mobileScreenLayout> createState() => _mobileScreenLayoutState();
}

// ignore: camel_case_types
class _mobileScreenLayoutState extends State<mobileScreenLayout> {
 int _page = 0;
 late PageController pageController;

 @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    pageController=PageController();
  }

 void navigationTapped(int page){
   pageController.jumpToPage(page);
 }
 void onPageChanged(int page){
  setState(() {
    _page=page;
  });
 }


  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _page==0? primaryColor:secondaryColor,),
            label: '',
            backgroundColor: primaryColor,
            ),
             BottomNavigationBarItem(
            icon: Icon(Icons.search, color: _page==1? primaryColor:secondaryColor,),
            label: '',
            backgroundColor: primaryColor,
            ),
             BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, color: _page==2? primaryColor:secondaryColor,),
            label: '',
            backgroundColor: primaryColor,
            ),
             BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline_outlined, color: _page==3? primaryColor:secondaryColor,),
            label: '',
            backgroundColor: primaryColor,
            ),
             BottomNavigationBarItem(
            icon: Icon(Icons.person, color: _page==4? primaryColor:secondaryColor,),
            label: '',
            backgroundColor: primaryColor,
            ),
        ],
            onTap: navigationTapped,
            

      ),
    );
  }
}