import 'package:agence/Map/setLocationOffer.dart';
import 'package:agence/home/addphoto/addphoto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';

import '../shared/components/components.dart';
import 'package:agence/home/cubitHome/CubitHome.dart';
import 'package:agence/home/cubitHome/homeStates.dart';

class AddPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<CupitHome, HomeStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
            appBar: AppBar(
              elevation: 15,
              title: Text(
                'Add Offer',
                style: TextStyle(
                    color: CupitHome.get(context).dartSwitch
                        ? Colors.white
                        : Colors.black,
                    fontSize: 34),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      CupitHome.get(context).changeSwitch(
                          value: !CupitHome.get(context).dartSwitch);
                    },
                    icon: const Icon(
                      Icons.dark_mode_outlined,
                      size: 30,
                    )),
              ],
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                border: Border.all(
                                  color: Colors.grey,
                                )),
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  style: TextStyle(
                                      color: CupitHome.get(context).dartSwitch
                                          ? Colors.white
                                          : Colors.black),
                                  dropdownColor:
                                      CupitHome.get(context).dartSwitch
                                          ? Colors.black
                                          : Colors.white,
                                  isExpanded: true,
                                  hint: Text(
                                    'Vente',
                                    style: TextStyle(
                                        color: CupitHome.get(context).dartSwitch
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  items: CupitHome.get(context)
                                      .vende
                                      .map(buildMenuItem)
                                      .toList(),
                                  onChanged: (value) {
                                    CupitHome.get(context).vendeDropDown(value);
                                  },
                                  value: CupitHome.get(context).vendevalueDrop,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                border: Border.all(
                                  color: Colors.grey,
                                )),
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  style: TextStyle(
                                      color: CupitHome.get(context).dartSwitch
                                          ? Colors.white
                                          : Colors.black),
                                  dropdownColor:
                                      CupitHome.get(context).dartSwitch
                                          ? Colors.black
                                          : Colors.white,
                                  isExpanded: true,
                                  hint: Text(
                                    'Appartement',
                                    style: TextStyle(
                                        color: CupitHome.get(context).dartSwitch
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  items: CupitHome.get(context)
                                      .appartement
                                      .map(buildMenuItem)
                                      .toList(),
                                  onChanged: (value) {
                                    CupitHome.get(context)
                                        .appartementDropDown(value);
                                  },
                                  value: CupitHome.get(context)
                                      .appartementvalueDrop,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          defaultForm(
                              context: context,
                              type: TextInputType.number,
                              lable: Text(
                                'Superficie',
                                style: TextStyle(
                                    color: CupitHome.get(context).dartSwitch
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                              valid: (String value) {
                                if (value.isEmpty) {
                                  return 'Superficie Must Not Be Empty';
                                }
                              },
                              controller:
                                  CupitHome.get(context).superficieController,
                              sufixText: 'm2'),
                          const SizedBox(
                            height: 26,
                          ),
                          defaultForm(
                            context: context,
                            type: TextInputType.number,
                            lable: Text(
                              'Price',
                              style: TextStyle(
                                  color: CupitHome.get(context).dartSwitch
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            valid: (String value) {
                              if (value.isEmpty) {
                                return 'Price Must Not Be Empty';
                              }
                            },
                            controller: CupitHome.get(context).priceController,
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          Visibility(
                            visible:
                                CupitHome.get(context).isvisibility['etages']!,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 26),
                              child: defaultForm(
                                context: context,
                                type: TextInputType.number,
                                lable: Text(
                                  'Etage(s)',
                                  style: TextStyle(
                                      color: CupitHome.get(context).dartSwitch
                                          ? Colors.white
                                          : Colors.grey),
                                ),
                                valid: (String value) {
                                  if (value.isEmpty) {
                                    return 'Etage(s) Must Not Be Empty';
                                  }
                                },
                                controller:
                                    CupitHome.get(context).nEtageController,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: CupitHome.get(context)
                                .isvisibility['N-champre']!,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 26),
                              child: defaultForm(
                                context: context,
                                type: TextInputType.number,
                                lable: Text(
                                  '\u2116chambres',
                                  style: TextStyle(
                                      color: CupitHome.get(context).dartSwitch
                                          ? Colors.white
                                          : Colors.grey),
                                ),
                                valid: (String value) {
                                  if (value.isEmpty) {
                                    return '\u2116chambres Must Not Be Empty';
                                  }
                                },
                                controller: CupitHome.get(context).nChambres,
                              ),
                            ),
                          ),
                          MultiSelectDialogField(
                            dialogHeight: 150,
                            items: CupitHome.get(context).paymentVar,
                            selectedColor: Colors.blue,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            buttonText: Text(
                              "Conditions de paiment",
                              style: TextStyle(
                                color: CupitHome.get(context).dartSwitch
                                    ? Colors.white
                                    : Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            onConfirm: (List results) {
                              CupitHome.get(context).conditionsListhttp = [];
                              results.forEach((element) {
                                CupitHome.get(context)
                                    .conditionsListhttp
                                    .add(element.name);
                              });
                              print(CupitHome.get(context).conditionsListhttp);
                            },
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          MultiSelectDialogField(
                            dialogHeight: 150,
                            items: CupitHome.get(context).speceficationVar,
                            selectedColor: Colors.blue,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              border: Border.all(color: Colors.grey),
                            ),
                            buttonText: Text(
                              "Specification",
                              style: TextStyle(
                                color: CupitHome.get(context).dartSwitch
                                    ? Colors.white
                                    : Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            onConfirm: (List results) {
                              CupitHome.get(context).specificationListhttp = [];
                              results.forEach((element) {
                                CupitHome.get(context)
                                    .specificationListhttp
                                    .add(element.name);
                              });
                              print(
                                  CupitHome.get(context).specificationListhttp);
                            },
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          MultiSelectDialogField(
                            dialogHeight: 150,
                            items: CupitHome.get(context).papiersVar,
                            // title: Text("Conditions de paiment"),
                            selectedColor: Colors.blue,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              border: Border.all(color: Colors.grey),
                            ),
                            buttonText: Text(
                              "Papiers",
                              style: TextStyle(
                                color: CupitHome.get(context).dartSwitch
                                    ? Colors.white
                                    : Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            onConfirm: (List results) {
                              CupitHome.get(context).papiersListhttp = [];
                              results.forEach((element) {
                                CupitHome.get(context)
                                    .papiersListhttp
                                    .add(element.name);
                              });
                              print(CupitHome.get(context).papiersListhttp);
                            },
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                border: Border.all(
                                  color: Colors.grey,
                                )),
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  style: TextStyle(
                                      color: CupitHome.get(context).dartSwitch
                                          ? Colors.white
                                          : Colors.black),
                                  dropdownColor:
                                      CupitHome.get(context).dartSwitch
                                          ? Colors.black
                                          : Colors.white,
                                  isExpanded: true,
                                  hint: Text(
                                    'Wilaya',
                                    style: TextStyle(
                                        color: CupitHome.get(context).dartSwitch
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  items: CupitHome.get(context)
                                      .items
                                      .map(buildMenuItem)
                                      .toList(),
                                  onChanged: (value) {
                                    CupitHome.get(context)
                                        .wilaraDropdown(value);
                                  },
                                  value: CupitHome.get(context)
                                      .wilayavalueDropdown,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          Row(
                            children: const [
                              Icon(Icons.text_snippet_outlined),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultForm(
                            context: context,
                            type: TextInputType.text,
                            valid: (String value) {
                              if (value.isEmpty) {
                                return 'Description Must Not Be Empty';
                              }
                            },
                            controller:
                                CupitHome.get(context).descriptionController,
                            maxline: 6,
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          defaultForm(
                            context: context,
                            type: TextInputType.emailAddress,
                            lable: Text(
                              'Adresse',
                              style: TextStyle(
                                  color: CupitHome.get(context).dartSwitch
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            valid: (String value) {
                              if (value.isEmpty) {
                                return 'Address Must Not Be Empty';
                              }
                            },
                            controller:
                                CupitHome.get(context).addressController,
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(15)),
                              border: Border.all(
                                width: 1,
                                color: CupitHome.get(context).dartSwitch
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SetLocationOffer()));
                              },
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.gps_fixed_rounded,
                                      size: 40,
                                      color: CupitHome.get(context).dartSwitch
                                          ? Colors.white
                                          : Colors.black),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Ajouter localisation',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: CupitHome.get(context).dartSwitch
                                            ? Colors.white
                                            : Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Addphoto()));
                                  }
                                },
                                icon: Icon(Icons.arrow_forward_ios,
                                    color: CupitHome.get(context).dartSwitch
                                        ? Colors.white
                                        : Colors.grey),
                              )
                            ],
                          )
                        ],
                      )),
                ),
              ),
            ));
      },
      listener: (BuildContext context, Object? state) {},
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        onTap: () {},
        child: Text(
          item,
        ),
        value: item,
      );
}
