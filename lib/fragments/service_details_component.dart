// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_adjacent_string_concatenation

// import 'package:cnssclaim/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../screens/demande_retraite.dart';
import '../utils/config.dart';

class ServiceDetails extends StatefulWidget {
 
  String title;

  // ignore: use_key_in_widget_constructors
  ServiceDetails(this.title);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> with SingleTickerProviderStateMixin {

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }



    aboutUs(){
      return Text(
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        style: secondaryTextStyle(),
        textAlign: TextAlign.start);
    }
    prerequistes(){
      return UL(
        symbolType: SymbolType.Bullet,
        children: [
          Text('Lorem of the printing and typesetting',style: primaryTextStyle()),
          Text('Lorem Ipsum is simply dummy text',style: primaryTextStyle()),
          Text('the printing and typesetting is simply dummy',style: primaryTextStyle()),
        ],
      );
    }
    openingHours(){
      return UL(
        symbolType: SymbolType.Numbered,
        edgeInsets: const EdgeInsets.only(bottom: 8),
        children: [
          Text('Lorem of the printing and typesetting',style: primaryTextStyle()),
          Text('Lorem Ipsum is simply dummy text',style: primaryTextStyle()),
          Text('the printing and typesetting is simply dummy', style: primaryTextStyle()),
          Text('Lorem of the printing and typesetting',style: primaryTextStyle()),
          Text('Lorem Ipsum is simply dummy text', style: primaryTextStyle()),
        ],
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      floatingActionButton: FloatingActionButton.extended(
       onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  const demandeautorisation (),
            
          ),
        );
      }, 
      label:  const Text(
        "ALLONS-Y!",
        style: TextStyle(fontSize: 16),
        maxLines: 1,
      ),
       icon: const Icon(Icons.east),
       backgroundColor: Colors.green,
      
      ),
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Container(
              height: fullHeight(context) * 0.1,
              width: fullWidth(context),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(70))),
              child: Column(
                children: [
                  25.height,
                  Row(children: [
                    IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.green)),
                    Text(widget.title,
                      style: const TextStyle(fontSize: 16),
                    )
                  ])
                ],
              )),
          SizedBox(
            height: fullHeight(context) * 0.07,
            child: TabBar(
              isScrollable: true ,
           padding: EdgeInsets.symmetric(horizontal: fullWidth(context) * 0.05),
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelStyle: const TextStyle(fontSize: 14),
              indicatorColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.white60,
              labelStyle:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              tabs: const [
                Tab(text: "About Us"),
                Tab(text: "Prerequistes"),
                Tab(text: "Opening Hours"),
              ],
            ),
          ),
          Container(
              height: fullHeight(context)*0.9,
              width: fullWidth(context),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                  )),
              child: Padding(
                 padding: EdgeInsets.symmetric(vertical: fullHeight(context) * 0.1 , horizontal:fullWidth(context) * 0.05),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    aboutUs(),
                    prerequistes(),
                    openingHours()
                  ],
                ),
              )),
         
      ]),
    );
  
  }
}
