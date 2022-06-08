// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:demandeautorisation/models/demande.dart';
import 'package:demandeautorisation/services/api/demande_api.dart';

import '../utils/config.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({Key? key}) : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails>
    with SingleTickerProviderStateMixin {
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

  info(title, value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
          style: const TextStyle(
           fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w400)),
        10.height,
        Text("$value"),
        20.height,
      ],
    );
  }

  //38395016

  general(demande) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        30.height,
        if (demande.reference != null) info("Reference", demande.reference!),
        if (demande.matricule != null) info("Matricule", demande.matricule!),
        if (demande.status != null) info("Status", demande.status!),
        if (demande.contenu != null) info("Contenu", demande.contenu!),
        if (demande.motif != null) info("Motif", demande.motif!),
        if (demande.createdAt != null)
          info("Created At",
              DateFormat('dd-MM-yyyy').format(demande.createdAt!)),
        if (demande.dateDecision != null)
          info("Date Decision",
              DateFormat('dd-MM-yyyy').format(demande.dateDecision!)),
      ],
    );
  }

  document(demande) {
    return (demande.documents!.isEmpty)
        ? const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 16),
            child: Center(child: Text("Pas de document!...")))
        : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
                vertical: fullHeight(context) * 0.05,
                horizontal: fullWidth(context) * 0.03),
            itemCount: demande.documents!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: fullWidth(context) * 0.1,
              mainAxisSpacing: fullHeight(context) * 0.02,
            ),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () async {
                  try {
                    download(
                      url: demande.documents![index]["filePath"],
                    );
                  } catch (e) {
                    // print("Exception : $e");
                    Get.snackbar("Download field", e.toString());
                  }
                },
                child: Stack(
                  children: [
                    Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: SizedBox(
                            height: fullHeight(context) * 0.18,
                            width: fullWidth(context) * 0.4,
                            child: const Center(
                                // demande.documents![index]["fileType"]
                                child: Text("PDF",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54))))),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: fullWidth(context) * 0.41,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "${demande.documents![index]['fileName']}",
                              style: const TextStyle(color: Colors.white)),
                        ),
                      ),
                    )
                  ],
                ),
              );
            });
  }

  documentOutput(demande) {
    return (demande.documentOutput!.isEmpty)
        ? const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 16),
            child: Center(child: Text("Pas d'Output!...")))
        : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
                vertical: fullHeight(context) * 0.05,
                horizontal: fullWidth(context) * 0.03),
            itemCount: demande.documentOutput!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: fullWidth(context) * 0.1,
              mainAxisSpacing: fullHeight(context) * 0.02,
            ),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () async {
                  try {
                    download(
                      url: demande.documentOutput![index]["filePath"],
                    );
                  } catch (e) {
                    // print("Exception : $e");
                    Get.snackbar("Download field", e.toString());
                  }
                },
                child: Stack(
                  children: [
                    Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: SizedBox(
                            height: fullHeight(context) * 0.18,
                            width: fullWidth(context) * 0.4,
                            child: const Center(
                                // demande.documentOutput![index]["fileType"]
                                child: Text("PDF",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54))))),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: fullWidth(context) * 0.41,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "${demande.documentOutput![index]['fileName']}",
                              style: const TextStyle(color: Colors.white)),
                        ),
                      ),
                    )
                  ],
                ),
              );
            });
  }

  @override
  Widget build(BuildContext context) {
    Demande demande = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.green,
      body: ListView(padding: const EdgeInsets.all(0), children: [
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
                  Text(
                    "Demande ${demande.id}",
                    style: const TextStyle(fontSize: 16),
                  )
                ])
              ],
            )),
        SizedBox(
          height: fullHeight(context) * 0.07,
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelStyle: const TextStyle(fontSize: 14),
            indicatorColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Colors.white60,
            labelStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            tabs: const [
              Tab(text: "Général"),
              Tab(text: "Documents"),
              Tab(text: "Output"),
            ],
          ),
        ),
        Container(
            height: fullHeight(context),
            width: fullWidth(context),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(70),
                )),
            child: TabBarView(
              controller: _tabController,
              children: [
                general(demande),
                document(demande),
                documentOutput(demande)
              ],
            ))
      ]),
    );
  }
}
