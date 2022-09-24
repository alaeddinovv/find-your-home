import 'dart:convert';

import 'package:agence/Api/httplaravel.dart';
import 'package:agence/clienthome/cupitSearch/cupitsearch_cubit.dart';
import 'package:agence/clienthome/cupitSearch/cupitsearch_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../home/cubitHome/CubitHome.dart';
import '../Api/constApi.dart';
import '../Model/AfficheOffer.dart';
import '../Model/AgencenameandphoneModel.dart';

import 'dart:convert' as convert;

import '../offerAgenceClient.dart';
import '../offersdetails/cubitOfferDetail.dart';
import '../offersdetails/offerdetailclient.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);
  Map<String, dynamic> sendfav = {};

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CupitsearchCubit, CupitsearchStates>(
      builder: (BuildContext context, state) {
        var shearchcontroller = TextEditingController();

        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 5, right: 5, top: 16, bottom: 5),
                child: ToggleSwitch(
                  changeOnTap: false,
                  initialLabelIndex:
                      CupitsearchCubit.get(context).toggelindexshearch,
                  onToggle: (index) {
                    CupitsearchCubit.get(context)
                        .changeToggelIndexSearch(index);
                  },
                  labels: CupitsearchCubit.get(context).type_search,
                  radiusStyle: true,
                  customWidths: [
                    MediaQuery.of(context).size.width / 2 - 20,
                    MediaQuery.of(context).size.width / 2 - 20,
                  ],
                  minHeight: 45,
                  minWidth: double.infinity,
                  cornerRadius: 50,
                  fontSize: 18,
                  activeBgColor: [
                    CupitHome.get(context).dartSwitch
                        ? Colors.blueGrey
                        : Colors.blue,
                    CupitHome.get(context).dartSwitch
                        ? Colors.blueGrey
                        : Colors.blue,
                  ],
                  inactiveBgColor: CupitHome.get(context).dartSwitch
                      ? const Color(0xff131313)
                      : Colors.white,
                  activeFgColor: Colors.white,
                  inactiveFgColor: CupitHome.get(context).dartSwitch
                      ? Colors.white
                      : Colors.blue,
                  borderColor: [
                    CupitHome.get(context).dartSwitch
                        ? const Color(0xff131313)
                        : Colors.blue,
                  ],
                  borderWidth: 3,
                  dividerColor: CupitHome.get(context).dartSwitch
                      ? const Color(0xff131313)
                      : Colors.white,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CupitsearchCubit.get(context).toggelindexshearch == 0
                      ? TypeAheadFormField(
                          textFieldConfiguration: TextFieldConfiguration(
                              style: TextStyle(
                                  color: CupitHome.get(context).dartSwitch
                                      ? Colors.white
                                      : Colors.black),
                              autofocus: true,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder())),
                          itemBuilder: (BuildContext context, Name? model) {
                            return NeumorphicButton(
                              style: NeumorphicStyle(
                                  color: CupitHome.get(context).dartSwitch
                                      ? Colors.black
                                      : Colors.white,
                                  depth: 0),
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OfferAgenceClient(
                                              model: model,
                                            )));
                              },
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 150,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                top: Radius.circular(20)),
                                        image: DecorationImage(
                                            image: model!.photo == null
                                                ? const AssetImage(
                                                    'assets/images/profile_avatar.jpg')
                                                : Image.memory(
                                                    base64Decode(model.photo!),
                                                    fit: BoxFit.cover,
                                                  ).image,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: CupitHome.get(context)
                                                .dartSwitch
                                            ? const LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Color(0xff131313),
                                                  Color(0xff131313),
                                                ],
                                              )
                                            : const LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                    Colors.blue,
                                                    const Color(0xffCFD9E2FF),
                                                  ]),
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                bottom: Radius.circular(20)),
                                      ),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(children: [
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                "${model.name}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4
                                                    ?.copyWith(
                                                      fontSize: 32,
                                                    ),
                                              )
                                            ]),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(children: [
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                '${model.phone}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ])
                                          ]),
                                      height: 120,
                                      width: double.infinity,
                                    )
                                  ]),
                            );
                          },
                          suggestionsCallback: getOfferAgencetoclientName,
                          onSuggestionSelected: (Name? k) {},
                        )
                      : TypeAheadFormField(
                          textFieldConfiguration: TextFieldConfiguration(
                              style: TextStyle(
                                  color: CupitHome.get(context).dartSwitch
                                      ? Colors.white
                                      : Colors.black),
                              autofocus: true,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder())),
                          itemBuilder:
                              (BuildContext context, OffersModel? model) {
                            final imageProvider =
                                MemoryImage(base64Decode(model!.photo![0]));

                            final modelClient = model;
                            return NeumorphicButton(
                              style: NeumorphicStyle(
                                  color: CupitHome.get(context).dartSwitch
                                      ? Colors.black
                                      : Colors.white,
                                  depth: 0),
                              onPressed: () async {
                                CubitDetail.get(context)
                                    .changeNavDetailClient(0);
                                print(modelClient.id);
                                sendfav = {
                                  'offer_id': '${modelClient.id}',
                                };
                                await CubitDetail.get(context)
                                    .getNameandPhone(data: {
                                  'offer_id': '${modelClient.id}',
                                });
                                CubitDetail.get(context)
                                    .getexistfav(data: sendfav);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Offerdetailclient(
                                              model: modelClient,
                                            )));
                              },
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 150,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20)),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: CupitHome.get(context)
                                                .dartSwitch
                                            ? const LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Color(0xff131313),
                                                  Color(0xff131313),
                                                ],
                                              )
                                            : const LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                    Colors.blue,
                                                    const Color(0xffCFD9E2FF),
                                                  ]),
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                bottom: Radius.circular(20)),
                                      ),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(children: [
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                "${model.price} DA",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4
                                                    ?.copyWith(
                                                      fontSize: 32,
                                                    ),
                                              )
                                            ]),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(children: [
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                '${model.address}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ])
                                          ]),
                                      height: 120,
                                      width: double.infinity,
                                    )
                                  ]),
                            );
                          },
                          suggestionsCallback: getOfferAgencetoclient,
                          onSuggestionSelected: (OffersModel? k) {},
                        )),
              const SizedBox(
                height: 10,
              ),
            ]),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}

var offersclient;
DataOffer? allofferModel;
Future<List<OffersModel>> getOfferAgencetoclient(String query) async {
  List<OffersModel> kk;

  kk = await Httplar.httpget(path: GETOFFERCATEGORIES + '/Tout').then((value) {
    var jsonResponse = convert.jsonDecode(value.body) as Map<String, dynamic>;

    allofferModel = DataOffer.fromJson(jsonResponse);
    print('ook');
    offersclient = allofferModel!.data!.offers;
    print(allofferModel!.data!.offers.runtimeType);
    return offersclient.where((offer) {
      final String wilaya = offer.wilaya.toLowerCase();
      final lowerQuery = query.toLowerCase();
      return wilaya.contains(lowerQuery);
    }).toList();
  });
  return kk;
}

Dd? agenceN;
var agenceName;
Future<List<Name>> getOfferAgencetoclientName(String query) async {
  List<Name> kk;

  kk = await Httplar.httpget(path: '/api/getnamephonuser').then((value) async {
    var jsonResponse = convert.jsonDecode(value.body) as Map<String, dynamic>;
    // await Future.delayed(Duration(seconds: 2));
    agenceN = Dd.fromJson(jsonResponse);
    print('ook');
    agenceName = agenceN!.o;
    print(agenceN!.o.runtimeType);
    return agenceName.where((offer) {
      final String name = offer.name.toLowerCase();
      final lowerQuery = query.toLowerCase();
      return name.contains(lowerQuery);
    }).toList();
  });
  return kk;
}
