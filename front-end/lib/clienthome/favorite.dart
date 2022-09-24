import 'dart:convert';

import 'package:agence/offersdetails/CubitOfferDetailState.dart';
import 'package:agence/offersdetails/cubitOfferDetail.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../Model/AfficheOffer.dart';

import '../home/cubitHome/CubitHome.dart';
import '../offersdetails/offerdetailFavoriete.dart';

class Favorite extends StatefulWidget {
  Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  Map<String, dynamic> sendfav = {};

  int a = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CubitDetail.get(context).getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitDetail, DetailStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 10,
            title: Text(
              'Favorite',
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
          body: ConditionalBuilder(
            builder: (BuildContext context) {
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: ((context, index) {
                      return ListItembuilder(
                        context,
                        CubitDetail.get(context)
                            .getFavoritesmodel!
                            .data!
                            .offers[index],
                      );
                    }),
                    itemCount: CubitDetail.get(context)
                        .getFavoritesmodel!
                        .data!
                        .offers
                        .length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                  ));
            },
            condition: CubitDetail.get(context).getFavoritesmodel != null &&
                state is! ConditionalLodinGetFavoritesState,
            fallback: (BuildContext context) {
              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }

  ListItembuilder(
    context,
    OffersModel model,
  ) {
    final OffersModel modelfav = model;
    final imageProvider = MemoryImage(base64Decode(model.photo![0]));

    return NeumorphicButton(
      style: NeumorphicStyle(
          color:
              CupitHome.get(context).dartSwitch ? Colors.black : Colors.white,
          depth: 0),
      onPressed: () async {
        CubitDetail.get(context).indexClient = 0;
        sendfav = {
          'offer_id': '${modelfav.id}',
        };
        await CubitDetail.get(context).getNameandPhone(data: {
          'offer_id': '${modelfav.id}',
        });
        CubitDetail.get(context).getexistfav(data: sendfav);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OfferDetailFav(
                      model: modelfav,
                    )));
      },
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: CupitHome.get(context).dartSwitch
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
                const BorderRadius.vertical(bottom: const Radius.circular(20)),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 10,
            ),
            Row(children: [
              const SizedBox(
                width: 8,
              ),
              Text(
                "${model.price} DA",
                style: Theme.of(context).textTheme.headline4?.copyWith(
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
                style: Theme.of(context).textTheme.bodyText2,
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
  }
}
