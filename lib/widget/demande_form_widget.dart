// ignore_for_file: avoid_print


import 'package:demandeautorisation/models/ministere.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../models/champsup.dart';
import 'package:demandeautorisation/services/controller/demande_controller.dart';
import '../screens/pdf_upload_widget.dart';
import '../services/api/demande_api.dart';
import '../services/api/piece_joint_api.dart';
import '../utils/config.dart';


class DemandeForm extends StatefulWidget {
  const DemandeForm({Key? key}) : super(key: key);

  @override
  State<DemandeForm> createState() => _DemandeFormState();
}

class _DemandeFormState extends State<DemandeForm> {
 List<Ministere> _ministries = []; 
  Ministere?  ministryVal;
  ministryDropdownMenu(){
    return Container(
      width: fullWidth(context),
      height: fullHeight(context) * 0.08,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: fullWidth(context) * 0.03),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Ministere>(
            hint: const Text("Ministere"),
              value: ministryVal,
              onChanged: (Ministere? newValue) {
                setState(() {
                  print("new value");
                  ministryVal = newValue ;
                  DemandeController.ministere=ministryVal;
                });
              },
              items: _ministries.map<DropdownMenuItem<Ministere>>((Ministere value) {
                return DropdownMenuItem<Ministere>(
                  value: value,
                  child: Text("${value.nameEn}"),
                );
              }).toList(),
            ),
        ),
      ),
      );
  }

  final DemandeController demandeController = Get.find();

  
_loadData() async { 
     loadData('/ministere/all').then((ministries) {
        setState(() {
          // _ministries=Ministere.ministeresFromSnapshot(ministries);
          _ministries = ministereFromJson(ministries);
        
        });
      });


    }


@override
    void initState() {
      _loadData();
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchAdditinalField(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ChampSup>> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6, top: 6),
                    child: Container(
                        // width: fullWidth(context) * 0.92,
                        // height: fullHeight(context) * 0.2,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: fullWidth(context) * 0.04),
                          child: TextField(
                      keyboardType: TextInputType.multiline,
                      // maxLines: 5,
                      controller: DemandeController.matriculeController,
                      decoration: const InputDecoration(
                            hintText: "matricule",
                            enabledBorder: UnderlineInputBorder(
                             borderSide: BorderSide(color: Colors.transparent)),
                            focusedBorder: UnderlineInputBorder(
                             borderSide: BorderSide(color: Colors.transparent)),
                            ),
                    ),
                        )
                    ),
                  ),
                  20.height,
                  ministryDropdownMenu(),
                  20.height,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6, top: 6),
                    child: Container(
                        width: fullWidth(context) * 0.92,
                        height: fullHeight(context) * 0.2,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: fullWidth(context) * 0.04),
                          child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      controller: DemandeController.contenuController,
                      decoration: const InputDecoration(
                            hintText: "Enter content",
                            enabledBorder: UnderlineInputBorder(
                             borderSide: BorderSide(color: Colors.transparent)),
                            focusedBorder: UnderlineInputBorder(
                             borderSide: BorderSide(color: Colors.transparent)),
                            ),
                    ),
                        )
                    ),
                  ),
                  20.height,
                  const Text("Pièces jointes",
                    style: TextStyle(
                    fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w400)),
                  10.height,
                  for (ChampSup a in snapshot.data!)
                    if (a.type == "file")
                     
                     PdfUploadWidget(a.designationFr!),

                     /*  ElevatedButton(
                        onPressed: () {
                          print('attached file list befor ::::: ${demandeController.files}');
                          _openFileExplorer();
                          print('attached file list after ::::: ${demandeController.files}');
                        },
                        child: Text(
                          a.designationFr!,
                        ),
                      ), */ 
            
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
