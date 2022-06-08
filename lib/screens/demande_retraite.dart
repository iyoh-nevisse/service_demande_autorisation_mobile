// ignore_for_file: deprecated_member_use, duplicate_ignore, unused_field, prefer_final_fields, avoid_print, camel_case_types
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:demandeautorisation/models/demande.dart';
import '../services/api/demande_api.dart';
import '../services/controller/demande_controller.dart';
import '../utils/config.dart';
import '../widget/demande_form_widget.dart';
import 'package:demandeautorisation/services/api/demande_api.dart';

class demandeautorisation extends StatefulWidget {
  const demandeautorisation({Key? key}) : super(key: key);

  @override
  State<demandeautorisation> createState() => _demandeautorisationState();
}

class _demandeautorisationState extends State<demandeautorisation> {

 
  final DemandeController demandeController = Get.put(DemandeController());
  Demande demande = Demande();

  List<String> steps = [ 
    "Preparation de la demande",
    "Revision",
    "Traitement",
    "Decision"
  ];

  int currentStepIndex = 0;
  bool hasNextStep   = true;
  bool hasPreviousStep  = false;


  @override
  void dispose() {
    super.dispose();
    DemandeController.contenuController.clear();
    DemandeController.matriculeController.clear();
    // ignore: unrelated_type_equality_checks, invalid_use_of_protected_member
    demandeController.files.value != [];
  }

  resumeEtConf(){
    return  Container(
        height: 200,
        decoration: const BoxDecoration(),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children:  <Widget>[
                  30.height,
                  const Text(
                    "Nom",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300),
                  ),
                  30.height,
                  const Text(
                    "Categorie",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300),
                  ),
                  30.height,
                  const Text(
                    "NNI",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            10.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  30.height,
                  Text(
                    // ignore: unrelated_type_equality_checks
                    DemandeController.user!.firstName!=Null ?" ": DemandeController.user!.firstName!,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  30.height,
                  const Text(
                    "retraite",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  30.height,
                  const Text(
                    "2945781456",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ) 
                ],
              ),
            ),
          ],
        ),
      );
   
  }

  stepWidget(index){
    return index == 0 
      ? const DemandeForm()
      : index == 1  
        ? resumeEtConf()
        : index == 2
        ? const Center(
          child: Text(
              "Votre demande est en cours de traitement",
              style: TextStyle(fontSize: 15),
            ),
        )
        : demande.status == "CONFIRMED"
          ? GestureDetector(
              child: const Center(
                child: Text("Telecharger la demande",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue)),
              ),
              onTap: () {
                // do what you need to do when "Click here" gets clicked
              })
          : const Center(
            child: Text(
                "Refuser",
                // style: TextStyle(fontSize: 15),
              ),
          );
  }
 
  continued() async {
    if (currentStepIndex == 1) {
      try {
        demande.contenu = DemandeController.contenuController.text;
        demande.matricule=DemandeController.matriculeController.text;
        demande.ministere=DemandeController.ministere;
        demande = await saveDemande(
          demande,
          demandeController.files,
        );
        Get.snackbar(
          "Save Success",
          "save demande informations success",
        );
        // Get.back();
      } catch (e) {
        // print("Exception : $e");
        Get.snackbar("Create demande failed", e.toString());
        return;
      }
    }
    if (currentStepIndex == 2) {
      try {
        demande = await updateDemande(demande);
        Get.snackbar("SUBMITED", "demande SUBMITED success.");
      } catch (e) {
        print("update demande failed ${e.toString()}");
        Get.snackbar("update demande failed", e.toString());
        return;
      }
    }

    if (currentStepIndex == 3) {
      try {
        demande = await getDemande(demande.id.toString());
        if (["DARFT", "SUBMITTED"].contains(demande.status)) return;
      } catch (e) {
        Get.snackbar("can't get demande from souerce", e.toString());
        return;
      }
    }

  //  currentStepIndex < 3 ? setState(() => currentStepIndex += 1) : null;
  }


  button(title,function){
    return SizedBox(
      width: fullWidth(context) * 0.4,
      child: MaterialButton(
        onPressed:  function,
       
        color: Colors.green,
        textColor: Colors.white,
        child:  Text(title)
        ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           30.height,
          IconButton(
              onPressed: ()=> Get.back(),
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal:fullWidth(context) * 0.07),
              children: [
                20.height,
                Row (
                  children: [
                   Stack(
                     alignment: Alignment.center,
                     children: [
                      SizedBox(
                        height: fullHeight(context) * 0.1,
                        width: fullHeight(context) * 0.1,
                        child:  CircularProgressIndicator(
                          strokeWidth: 6,
                          backgroundColor: Colors.grey[300],
                          valueColor:const AlwaysStoppedAnimation<Color>(Colors.green),
                          value: (currentStepIndex + 1)/4
                          )),
                      Text("${currentStepIndex+1} sur ${steps.length}" , style: TextStyle(fontWeight: FontWeight.w700, fontSize: fullWidth(context) * 0.04 ))   
                     ],
                   ),
                    20.width,
                    Padding(
                      padding: const EdgeInsets.only(top:8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(steps[currentStepIndex],style: TextStyle(fontSize: fullWidth(context) * 0.04 , fontWeight: FontWeight.w700),),
                            10.height,
                            Text( hasNextStep 
                              ? "Suivant: ${steps[currentStepIndex+1]}"
                              : "Finish", style: const TextStyle(color: Colors.grey))
                        ],
                      ),
                    )
          
                ],),
                20.height,
                SizedBox(
                  height: fullHeight(context) *0.65,
                  child: stepWidget(currentStepIndex)),
              ]),
          ),
        ],
      ),
        bottomSheet: Padding(
          padding: EdgeInsets.only(bottom:fullHeight(context) * 0.07 ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

            if(hasPreviousStep)  button("Retour" , (){
                  if (currentStepIndex == 1) {
                    setState(() {
                      hasPreviousStep  = false;
                    });
                  }
                  setState(() {
                    hasNextStep = true ;
                    currentStepIndex -- ;
                  });
                } ),

             if(hasNextStep) button("Suivant", () {
                  if (currentStepIndex == 2) {
                    setState(() {
                      hasNextStep   = false;
                    });
                  }
                  setState(() {
                    hasPreviousStep = true;
                    currentStepIndex ++ ;
                  });
                  continued();
                } ),


        
              ]),
        ),
      
    );
  }

}
