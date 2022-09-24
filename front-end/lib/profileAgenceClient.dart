import 'dart:convert';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:agence/home/cubitHome/CubitHome.dart';
import 'package:agence/home/cubitHome/homeStates.dart';

class ProfilAgence extends StatefulWidget {
  var model;
  ProfilAgence({Key? key, required this.model}) : super(key: key);

  @override
  State<ProfilAgence> createState() => _ProfilAgenceState(model: model);
}

class _ProfilAgenceState extends State<ProfilAgence> {
  var model;
  _ProfilAgenceState({required this.model});
  @override
  void initState() {
    // TODO: implement initState
    CupitHome.get(context)
        .getinformationAgenceToClient(model.agenceId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CupitHome, HomeStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 10,
            title: Text(
              'Profile',
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
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: CupitHome.get(context)
                                    .getinfoAgonceToClientModel!
                                    .photo ==
                                null
                            ? const AssetImage(
                                'assets/images/profile_avatar.jpg')
                            : Image.memory(
                                base64Decode(CupitHome.get(context)
                                    .getinfoAgonceToClientModel!
                                    .photo!),
                                fit: BoxFit.cover,
                              ).image,
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.real_estate_agent_outlined,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${CupitHome.get(context).getinfoAgonceToClientModel!.name}",
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            )
                          ],
                        ),
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: CupitHome.get(context).dartSwitch
                              ? Colors.blueGrey
                              : Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${CupitHome.get(context).getinfoAgonceToClientModel!.agence!.address}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: CupitHome.get(context).dartSwitch
                              ? Colors.blueGrey
                              : Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${CupitHome.get(context).getinfoAgonceToClientModel!.phone}",
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            )
                          ],
                        ),
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: CupitHome.get(context).dartSwitch
                              ? Colors.blueGrey
                              : Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.alternate_email,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${CupitHome.get(context).getinfoAgonceToClientModel!.email}",
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            )
                          ],
                        ),
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: CupitHome.get(context).dartSwitch
                              ? Colors.blueGrey
                              : Colors.blue,
                        ),
                      ),
                    ]),
              );
            },
            condition:
                CupitHome.get(context).getinfoAgonceToClientModel != null &&
                    state is! ConditionalLodinInfoState,
            fallback: (BuildContext context) {
              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
