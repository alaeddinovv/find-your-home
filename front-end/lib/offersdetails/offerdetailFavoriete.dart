import 'dart:convert';

import 'package:agence/Model/AfficheOffer.dart';
import 'package:agence/clienthome/navbar.dart';
import 'package:agence/offersdetails/CubitOfferDetailState.dart';
import 'package:agence/offersdetails/cubitOfferDetail.dart';
import 'package:agence/home/cubitHome/CubitHome.dart';
import 'package:agence/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Map/GetLocationClientFav.dart';

import '../offerAgenceClient.dart';

class OfferDetailFav extends StatefulWidget {
  final OffersModel model;

  OfferDetailFav({required this.model});

  @override
  State<OfferDetailFav> createState() => _OfferDetailFavState(model: model);
}

class _OfferDetailFavState extends State<OfferDetailFav> {
  OffersModel model;
  _OfferDetailFavState({required this.model});

  bool ischangeFav = false;

  var onbordingController = PageController();

  var msgController = TextEditingController();

  Map<String, dynamic> sendinfomsg = {};

  int a = 0;

  String? number;

  String? seLoger;

  Map<String, dynamic> sendfava = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    number = CubitDetail.get(context).namAndphoen[0]['phone'];
    seLoger = CubitDetail.get(context).namAndphoen[0]['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            flex: 35,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white54,
                  child: PageView.builder(
                    onPageChanged: (int index) {},
                    controller: onbordingController,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      List? k;
                      k = model.photo?.map((e) {
                        return base64Decode(e);
                      }).toList();
                      return Image(
                        image: MemoryImage(k![index]),
                        width: 400,
                        fit: BoxFit.cover,
                      );
                    },
                    itemCount: model.photo!.length,
                  ),
                ),
                Positioned(
                  top: 45,
                  left: -5,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    shape: const CircleBorder(),
                    color: CupitHome.get(context).dartSwitch
                        ? Colors.black
                        : Colors.blue,
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: CupitHome.get(context).dartSwitch
                          ? Colors.white
                          : Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SmoothPageIndicator(
                          controller: onbordingController,
                          count: model.photo!.length,
                          effect: ScrollingDotsEffect(
                            dotColor: CupitHome.get(context).dartSwitch
                                ? const Color(0xffb3b2b2)
                                : Colors.white,
                            activeDotColor: CupitHome.get(context).dartSwitch
                                ? const Color(0xff131313)
                                : Colors.blue,
                          ),
                          onDotClicked: (index) {}),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
          Divider(
            color: CupitHome.get(context).dartSwitch
                ? Colors.blueGrey
                : const Color(0xffF3F3F3FF),
            height: 1,
            thickness: 2,
          ),
          Expanded(
            flex: 65,
            child: BlocConsumer<CubitDetail, DetailStates>(
              builder: (BuildContext context, state) {
                return Column(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "${model.price} DA",
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      fontSize: 32,
                                    ),
                          ),
                          const Spacer(),
                          ConditionalBuilder(
                            builder: (BuildContext context) {
                              return MaterialButton(
                                minWidth: 0,
                                onPressed: () {
                                  ischangeFav = true;
                                  sendfava = {
                                    'offer_id': '${model.id}',
                                  };
                                  CubitDetail.get(context)
                                      .changefav(
                                          data: sendfava,
                                          dd: CubitDetail.get(context).colorfav)
                                      .then((value) {});
                                },
                                shape: const CircleBorder(),
                                color: CupitHome.get(context).dartSwitch
                                    ? const Color(0xff8d8d8d)
                                    : Colors.blue,
                                child: Icon(
                                  Icons.favorite_sharp,
                                  color: CubitDetail.get(context).colorfav
                                      ? Colors.redAccent
                                      : Colors.white,
                                ),
                              );
                            },
                            condition: state is! LoadingExFavState &&
                                state is! LoadingChangeFavState &&
                                CubitDetail.get(context).existfav != null,
                            fallback: (BuildContext context) {
                              return SpinKitRipple(
                                duration: Duration(seconds: 1),
                                itemBuilder: (context, index) {
                                  return const DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: Colors.lightBlueAccent,
                                          shape: BoxShape.circle));
                                },
                              );
                            },
                          ),
                          MaterialButton(
                            minWidth: 0,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          GetLocationClientFav(
                                            model: model,
                                          )));
                            },
                            shape: const CircleBorder(),
                            color: CupitHome.get(context).dartSwitch
                                ? const Color(0xff8d8d8d)
                                : Colors.blue,
                            child: Icon(
                              Icons.place,
                              color: CupitHome.get(context).dartSwitch
                                  ? Colors.white
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              '${model.address}',
                              style: Theme.of(context).textTheme.bodyText2,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OfferAgenceClient(
                                            model: model,
                                          )));
                            },
                            child: Text(
                              seLoger!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: CupitHome.get(context).dartSwitch
                          ? Colors.blueGrey
                          : const Color(0xffF3F3F3FF),
                      height: 1,
                      thickness: 2,
                    ),
                    Expanded(
                      flex: 8,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 54,
                              child: MaterialButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  CubitDetail.get(context)
                                      .changeNavDetailClient(0);
                                },
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Icon(
                                      Icons.description_outlined,
                                      color: CubitDetail.get(context)
                                                  .indexClient ==
                                              0
                                          ? CupitHome.get(context).dartSwitch
                                              ? Colors.white
                                              : Colors.redAccent
                                          : CupitHome.get(context).dartSwitch
                                              ? Colors.blueGrey
                                              : Colors.blue,
                                    ),
                                    Text('Information',
                                        style: TextStyle(
                                            color: CubitDetail.get(context)
                                                        .indexClient ==
                                                    0
                                                ? CupitHome.get(context)
                                                        .dartSwitch
                                                    ? Colors.white
                                                    : Colors.redAccent
                                                : CupitHome.get(context)
                                                        .dartSwitch
                                                    ? Colors.blueGrey
                                                    : Colors.blue,
                                            fontSize: 14)),
                                    const SizedBox(
                                      height: 7,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 54,
                              child: MaterialButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  CubitDetail.get(context)
                                      .changeNavDetailClient(1);
                                },
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Icon(
                                      Icons.menu_sharp,
                                      color: CubitDetail.get(context)
                                                  .indexClient ==
                                              1
                                          ? CupitHome.get(context).dartSwitch
                                              ? Colors.white
                                              : Colors.redAccent
                                          : CupitHome.get(context).dartSwitch
                                              ? Colors.blueGrey
                                              : Colors.blue,
                                    ),
                                    Text('Details',
                                        style: TextStyle(
                                            color: CubitDetail.get(context)
                                                        .indexClient ==
                                                    1
                                                ? CupitHome.get(context)
                                                        .dartSwitch
                                                    ? Colors.white
                                                    : Colors.redAccent
                                                : CupitHome.get(context)
                                                        .dartSwitch
                                                    ? Colors.blueGrey
                                                    : Colors.blue,
                                            fontSize: 14)),
                                    const SizedBox(
                                      height: 7,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 54,
                              child: MaterialButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  CubitDetail.get(context)
                                      .changeNavDetailClient(2);
                                  CubitDetail.get(context).getAllMsg(
                                      data: {'offer_id': '${model.id}'});
                                },
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Icon(
                                      Icons.message_outlined,
                                      color: CubitDetail.get(context)
                                                  .indexClient ==
                                              2
                                          ? CupitHome.get(context).dartSwitch
                                              ? Colors.white
                                              : Colors.redAccent
                                          : CupitHome.get(context).dartSwitch
                                              ? Colors.blueGrey
                                              : Colors.blue,
                                    ),
                                    Text('Commentaire',
                                        style: TextStyle(
                                            color: CubitDetail.get(context)
                                                        .indexClient ==
                                                    2
                                                ? CupitHome.get(context)
                                                        .dartSwitch
                                                    ? Colors.white
                                                    : Colors.redAccent
                                                : CupitHome.get(context)
                                                        .dartSwitch
                                                    ? Colors.blueGrey
                                                    : Colors.blue,
                                            fontSize: 14)),
                                    const SizedBox(
                                      height: 7,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 54,
                              child: MaterialButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () async {
                                  FlutterPhoneDirectCaller.callNumber(number!);
                                },
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Icon(
                                      Icons.call,
                                      color: CupitHome.get(context).dartSwitch
                                          ? Colors.blueGrey
                                          : Colors.blue,
                                    ),
                                    Text('Call',
                                        style: TextStyle(
                                            color: CupitHome.get(context)
                                                    .dartSwitch
                                                ? Colors.blueGrey
                                                : Colors.blue,
                                            fontSize: 14)),
                                    const SizedBox(
                                      height: 7,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: CupitHome.get(context).dartSwitch
                          ? Colors.blueGrey
                          : const Color(0xffF3F3F3FF),
                      height: 1,
                      thickness: 2,
                    ),
                    Expanded(
                      flex: 43,
                      child: Container(
                        child: CubitDetail.get(context).indexClient == 0
                            ? Information(context, model)
                            : (CubitDetail.get(context).indexClient == 1
                                ? Details(
                                    context,
                                    model,
                                  )
                                : ConditionalBuilder(
                                    builder: (BuildContext context) {
                                      return Commentaire(context);
                                    },
                                    condition: state
                                            is! LodinGetAllMsgOfferState &&
                                        CubitDetail.get(context).allmsgmodel !=
                                            null,
                                    fallback: (BuildContext context) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    },
                                  )),
                      ),
                    ),
                  ],
                );
              },
              listener: (BuildContext context, Object? state) async {
                if (state is GoodChangeFavoriteState) {
                  if (ischangeFav == true) {
                    Fluttertoast.showToast(
                        msg: 'Delet Success Fav',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    CupitHome.get(context).currentindexa = 0;
                    await Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Navbar()),
                        (route) => false);
                    ischangeFav = false;
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget Commentaire(context) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              height: 58,
              child: defaultForm(
                lable: Text(
                  'write a message',
                  style: TextStyle(
                      color: CupitHome.get(context).dartSwitch
                          ? Colors.white
                          : Colors.grey),
                ),
                sufixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.send_sharp,
                        color: CupitHome.get(context).dartSwitch
                            ? Colors.white
                            : Colors.grey)),
                textInputAction: TextInputAction.done,
                controller: msgController,
                context: context,
                type: TextInputType.text,
                valid: (value) {
                  if (value.isEmpty) {
                    return 'you can not add an umpty message';
                  }
                },
              ),
            ),
            Expanded(
                child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: ((context, index) => Listemessage(
                  context, CubitDetail.get(context).allmsgmodel[index])),
              itemCount: CubitDetail.get(context).allmsgmodel.length,
              separatorBuilder: (context, int index) {
                return const SizedBox(
                  height: 1,
                );
              },
            )),
          ],
        ),
      );
}

Widget Listemessage(context, msg) => Container(
      decoration: BoxDecoration(
          color: CupitHome.get(context).dartSwitch
              ? const Color(0xff131313)
              : Colors.lightBlue,
          borderRadius: const BorderRadius.all(const Radius.circular(4))),
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: msg['photo'] == null
                      ? const AssetImage('assets/images/profile_avatar.jpg')
                      : Image.memory(
                          base64Decode(msg['photo']),
                          fit: BoxFit.cover,
                        ).image,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(msg['name'],
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  width: 7,
                ),
                Text('${msg['created_at']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    )),
              ],
            ),
            const SizedBox(
              height: 3,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 7,
                ),
                Expanded(
                    child: Text(
                  msg['text'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )),
                // Spacer(),
                const SizedBox(
                  width: 7,
                ),

                const SizedBox(
                  width: 0,
                ),
              ],
            )
          ],
        ),
      ),
    );

Widget Information(context, OffersModel model) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Description ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              '${model.description}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );

Widget Details(
  context,
  OffersModel model,
) =>
    Padding(
      padding: const EdgeInsets.all(18.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Card(
          color: CupitHome.get(context).dartSwitch
              ? const Color(0xff131313)
              : Colors.lightBlue,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 2,
                color: CupitHome.get(context).dartSwitch
                    ? const Color(0xff131313)
                    : Colors.lightBlue),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                        width: 130,
                        child: const Text(
                          'Wilaya ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${model.wilaya}',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                        width: 130,
                        child: const Text(
                          'Superficie ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${model.space} m2',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                        width: 130,
                        child: const Text(
                          'Etages',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${model.nEtage}',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                        width: 130,
                        child: const Text(
                          'Chambres ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${model.nChambre} chambre(s)',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                        width: 130,
                        child: const Text(
                          'Type de vente ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${model.typeVente}',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                        width: 130,
                        child: const Text(
                          'Categorie ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${model.typeOffer}',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 1,
                ),
                Container(
                  height: 28,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                          width: 130,
                          child: const Text(
                            'Specification ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(child: listSpecefication(context, model))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 28,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                          width: 130,
                          child: const Text(
                            'paiement ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(child: listPaiment(context, model))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

listSpecefication(context, OffersModel model) => ListView(
      scrollDirection: Axis.horizontal,
      children: model.specification!
          .map((e) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blueAccent,
                ),
                child: Center(
                    child: Row(children: [
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    '$e',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(
                    width: 6,
                  )
                ])),
              ))
          .toList(),
    );
listPaiment(context, OffersModel model) => ListView(
      scrollDirection: Axis.horizontal,
      children: model.conditionDePaiment!
          .map((e) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blueAccent,
                ),
                child: Center(
                    child: Row(children: [
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    '$e',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(
                    width: 6,
                  )
                ])),
              ))
          .toList(),
    );
