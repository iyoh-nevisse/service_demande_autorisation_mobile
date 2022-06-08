import 'package:demandeautorisation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../fragments/service_details_component.dart';
import 'demande_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // ignore: non_constant_identifier_names
  List<SampleListModel> SampleData = [];

  int selectedIndex = 0;

  @override
  void initState() {
    SampleData.add(
      SampleListModel(
        title: "Home",
        launchWidget: DemandesList(),
        icon: Icons.home,
        alternateIcon: Icons.home_outlined,
        
      ),
    );
/*     SampleData.add(
      SampleListModel(
        title: "Search",
        launchWidget: Text("Search View", style: boldTextStyle(size: 24)),
        icon: Icons.search,
        alternateIcon: Icons.search,
        colors: Colors.orange,
      ),
    ); */
 
    SampleData.add(
      SampleListModel(
        title: "Settings",
        launchWidget: ProfileScreen(),
        icon: Icons.settings,
        alternateIcon: Icons.settings,
      
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: appBar(context, ''),
      body: SampleData[selectedIndex].launchWidget.center(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ServiceDetails("Service Details")));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.hardEdge,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              ...List.generate(
                SampleData.length,
                (index) {
                  SampleListModel data = SampleData[index];
                  return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        selectedIndex == index ? Icon(data.icon, size: 24, color: Colors.blue) : Icon(data.alternateIcon, size: 24, color: Colors.blueGrey[300]),
                        Text(selectedIndex == index ? data.title.validate() : "", style: boldTextStyle(color: Colors.blue, size: 14)),
                      ],
                    ).onTap(() {
                    selectedIndex = index;
                    setState(() {});
                  }).expand();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class SampleListModel {
  Widget? leading;
  String? title;
  String? subTitle;
  Widget? trailing;
  IconData? icon;
  IconData? alternateIcon;
  Function? onTap;
  Color? colors;
  Widget? launchWidget;

  SampleListModel({this.leading, this.title, this.subTitle, this.colors, this.icon, this.alternateIcon, this.trailing, this.onTap, this.launchWidget});
}
