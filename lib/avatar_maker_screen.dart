import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_avatar_maker/assets.dart';
import 'package:flutter_avatar_maker/avatar_maker_controller.dart';
import 'package:flutter_avatar_maker/shared/color.dart';
import 'package:flutter_avatar_maker/shared/text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class AvatarMakerScreen extends StatefulWidget {
  const AvatarMakerScreen({super.key});

  @override
  State<AvatarMakerScreen> createState() => _AvatarMakerScreenState();
}

class _AvatarMakerScreenState extends State<AvatarMakerScreen> {
  Widget colorList() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 40,
      child: GetBuilder<AvatarMakerController>(
          id: "avatar_category",
          builder: (controller) {
            final selectedCategory = category[controller.selectedCategory];
            final List<int>? colorList;
            if (selectedCategory == "CLOTHING") {
              colorList = clothingColor;
            } else if (selectedCategory == "ACCESSORY") {
              colorList = accessoryColor;
            } else if (selectedCategory == "FACIAL_HAIR") {
              colorList = facialHairColor;
            } else {
              colorList = null;
            }
            return colorList == null
                ? const SizedBox.shrink()
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: colorList.length + 2,
                    itemBuilder: (context, index) {
                      if (index == 0 || index == colorList!.length + 1) {
                        return const SizedBox(width: 36);
                      }
                      final indexOffset = index - 1;
                      final color = Color(colorList[indexOffset]);
                      return InkWell(
                          onTap: () {
                            if (selectedCategory == "CLOTHING") {
                              controller.clothingColor =
                                  colorList![indexOffset];
                            } else if (selectedCategory == "ACCESSORY") {
                              controller.accessoryColor =
                                  colorList![indexOffset];
                            } else if (selectedCategory == "FACIAL_HAIR") {
                              controller.facialHairColor =
                                  colorList![indexOffset];
                            }
                          },
                          child: color.alpha != 0
                              ? Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: color,
                                  ),
                                )
                              : Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.grey),
                                  ),
                                ));
                    },
                    separatorBuilder: ((context, index) =>
                        const SizedBox(width: 16)),
                  );
          }),
    );
  }

  Widget componentList(List<String> components, String notifyId,
      void Function(int) onTap, bool Function(int) isSelected) {
    return Container(
        height: 195,
        margin: const EdgeInsets.symmetric(vertical: 36),
        child: GetBuilder<AvatarMakerController>(
            id: notifyId,
            builder: (controller) {
              return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: components.length + 2,
                  separatorBuilder: ((context, index) =>
                      const SizedBox(width: 24)),
                  itemBuilder: (context, index) {
                    if (index == 0 || index == components.length + 1) {
                      return const SizedBox(width: 36);
                    }
                    final indexOffset = index - 1;
                    final path = components[indexOffset];
                    return InkWell(
                        onTap: () => onTap(indexOffset),
                        child: Stack(children: [
                          Container(
                              width: 195,
                              height: 195,
                              decoration: BoxDecoration(
                                  color: AppColorTheme.paleGrey,
                                  borderRadius: BorderRadius.circular(16))),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: path != ""
                                  ? SvgPicture.asset(
                                      path,
                                      width: 160,
                                      height: 160,
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ),
                          ...isSelected(indexOffset)
                              ? [
                                  Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: const BoxDecoration(
                                              color: AppColorTheme.primaryColor,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.zero,
                                                  topRight: Radius.zero,
                                                  bottomLeft: Radius.zero,
                                                  bottomRight:
                                                      Radius.circular(16))),
                                          child: const Icon(Icons.done,
                                              color: Colors.white, size: 32))),
                                  Container(
                                      width: 195,
                                      height: 195,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColorTheme.primaryColor,
                                              width: 4),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.zero,
                                              topRight: Radius.circular(16),
                                              bottomLeft: Radius.circular(16),
                                              bottomRight:
                                                  Radius.circular(16))))
                                ]
                              : [const SizedBox.shrink()]
                        ]));
                  });
            }));
  }

  Widget categoryList() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 44,
      child: GetBuilder<AvatarMakerController>(
          id: "avatar_category",
          builder: (controller) {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: category.length + 2,
              itemBuilder: (context, index) {
                if (index == 0 || index == category.length + 1) {
                  return const SizedBox(width: 36);
                }
                final indexOffset = index - 1;
                return InkWell(
                  onTap: () {
                    controller.category = indexOffset;
                    if (category[indexOffset] == "SHORT HAIR") {
                      controller.hairType = HairType.short;
                    } else if (category[indexOffset] == "LONG HAIR") {
                      controller.hairType = HairType.long;
                    }
                  },
                  child: Chip(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    label: Text(category[indexOffset]),
                    backgroundColor: controller.selectedCategory == indexOffset
                        ? AppColorTheme.primaryColor
                        : AppColorTheme.lightGrey,
                    labelStyle: controller.selectedCategory == indexOffset
                        ? AppTextStyle.primaryWhiteText
                        : AppTextStyle.primaryDarkGreyText,
                  ),
                );
              },
              separatorBuilder: ((context, index) => const SizedBox(width: 24)),
            );
          }),
    );
  }

  Widget replaceColorOrReturn(
      bool shouldReplace, SvgPicture picture, Color? src, Color rep) {
    return shouldReplace && rep != Colors.transparent
        ? ColorFiltered(
            colorFilter: src != null
                ? ColorFilter.matrix(<double>[
                    rep.red / src.red,
                    0,
                    0,
                    0,
                    0,
                    0,
                    rep.green / src.green,
                    0,
                    0,
                    0,
                    0,
                    0,
                    rep.blue / src.blue,
                    0,
                    0,
                    0,
                    0,
                    0,
                    1,
                    0,
                  ])
                : ColorFilter.mode(rep, BlendMode.srcIn),
            child: picture,
          )
        : picture;
  }

  final GlobalKey _avatarKey = GlobalKey();

  /// function that generates unique file name for the avatar
  String generateFileName() {
    final now = DateTime.now();
    return "${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}${now.millisecond}${now.microsecond}";
  }

  void saveAvatar() async {
    RenderRepaintBoundary boundary =
        _avatarKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 2.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    // Save the image
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${generateFileName()}.png');
    await file.writeAsBytes(pngBytes);
  }

  @override
  Widget build(BuildContext context) {
    AvatarMakerController controller = Get.put(AvatarMakerController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Avatar Maker"),
        backgroundColor: AppColorTheme.primaryColor,
        centerTitle: true,
        actions: [
          IconButton(onPressed: saveAvatar, icon: const Icon(Icons.save))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColorTheme.primaryColor,
          onPressed: () {
            controller.randomizeForInterval(1500);
          },
          child: const Icon(
            Icons.casino,
            color: Colors.white,
          )),
      body: Container(
          color: AppColorTheme.paleGrey,
          child: Column(children: [
            Expanded(
              flex: 1,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: AppColorTheme.paleGrey,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24))),
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 180,
                      height: 180,
                      child: RepaintBoundary(
                        key: _avatarKey,
                        child: Stack(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: AppColorTheme.white,
                                    borderRadius: BorderRadius.circular(16))),
                            GetBuilder<AvatarMakerController>(
                                id: "avatar_body",
                                builder: (controller) {
                                  return Positioned.fill(
                                      bottom: -30,
                                      child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: SvgPicture.asset(
                                              bodyAssets[
                                                  controller.selectedBody],
                                              width: 160,
                                              height: 160)));
                                }),
                            GetBuilder<AvatarMakerController>(
                                id: "avatar_clothing",
                                builder: (controller) {
                                  Color src = const Color(0xFF80C43B);
                                  Color rep = controller
                                              .selectedClothingColor ==
                                          0
                                      ? src
                                      : Color(controller.selectedClothingColor);
                                  return Positioned.fill(
                                      bottom: -30,
                                      child: Align(
                                          alignment: Alignment.bottomCenter,
                                          // ColorFiltered below replace clothing color but not lines
                                          child: replaceColorOrReturn(
                                              category[controller
                                                      .selectedCategory] ==
                                                  "CLOTHING",
                                              SvgPicture.asset(
                                                  clothingAssets[controller
                                                      .selectedClothing],
                                                  width: 160,
                                                  height: 70),
                                              src,
                                              rep)));
                                }),
                            GetBuilder<AvatarMakerController>(
                                id: "avatar_eyes",
                                builder: (controller) {
                                  return Positioned.fill(
                                      top: 90,
                                      child: Align(
                                          alignment: Alignment.topCenter,
                                          child: SvgPicture.asset(
                                              eyesAssets[
                                                  controller.selectedEyes],
                                              width: 50,
                                              height: 20)));
                                }),
                            GetBuilder<AvatarMakerController>(
                                id: "avatar_nose",
                                builder: (controller) {
                                  return Positioned.fill(
                                      top: 90,
                                      child: Align(
                                          alignment: Alignment.topCenter,
                                          child: SvgPicture.asset(
                                              noseAssets[
                                                  controller.selectedNose],
                                              width: 20,
                                              height: 30)));
                                }),
                            GetBuilder<AvatarMakerController>(
                                id: "avatar_mouth",
                                builder: (controller) {
                                  return Positioned.fill(
                                      top: 115,
                                      child: Align(
                                          alignment: Alignment.topCenter,
                                          child: SvgPicture.asset(
                                              mouthAssets[
                                                  controller.selectedMouth],
                                              width: 40,
                                              height: 30)));
                                }),
                            GetBuilder<AvatarMakerController>(
                                id: "avatar_hair",
                                builder: (controller) {
                                  return Positioned(
                                      top: 15,
                                      child: Align(
                                          alignment: Alignment.topCenter,
                                          child: SvgPicture.asset(
                                              controller.selectedHairType ==
                                                      HairType.short
                                                  ? shortHairAssets[controller
                                                      .selectedShortHair]
                                                  : longHairAssets[controller
                                                      .selectedLongHair],
                                              width: 180,
                                              height: 195)));
                                }),
                            GetBuilder<AvatarMakerController>(
                                id: "avatar_facial_hair",
                                builder: (controller) {
                                  final path = facialHairAssets[
                                      controller.selectedFacialHair];
                                  // Color rep = controller
                                  //             .selectedFacialHairColor ==
                                  //         0
                                  //     ? Colors.transparent
                                  //     : Color(controller.selectedFacialHairColor);
                                  Color rep = Colors.transparent;
                                  return Positioned.fill(
                                      top: 105,
                                      child: Align(
                                          alignment: Alignment.topCenter,
                                          child: path != ""
                                              ? replaceColorOrReturn(
                                                  category[controller
                                                          .selectedCategory] ==
                                                      "FACIAL_HAIR",
                                                  SvgPicture.asset(path,
                                                      width: 90, height: 80),
                                                  null,
                                                  rep)
                                              : const SizedBox.shrink()));
                                }),
                            GetBuilder<AvatarMakerController>(
                                id: "avatar_accessory",
                                builder: (controller) {
                                  final path = accessoryAssets[
                                      controller.selectedAccessory];
                                  Color rep = controller
                                              .selectedAccessoryColor ==
                                          0
                                      ? Colors.transparent
                                      : Color(
                                          controller.selectedAccessoryColor);
                                  return Positioned.fill(
                                      top: 81,
                                      child: Align(
                                          alignment: Alignment.topCenter,
                                          child: path != ""
                                              ? replaceColorOrReturn(
                                                  category[controller
                                                          .selectedCategory] ==
                                                      "ACCESSORY",
                                                  SvgPicture.asset(path,
                                                      width: 80, height: 40),
                                                  null,
                                                  rep)
                                              : const SizedBox.shrink()));
                                }),
                            GetBuilder<AvatarMakerController>(
                                id: "avatar_hat",
                                builder: (controller) {
                                  final path =
                                      hatAssets[controller.selectedHat];
                                  return Positioned(
                                      top: 15,
                                      child: Align(
                                          alignment: Alignment.topCenter,
                                          child: path != ""
                                              ? SvgPicture.asset(path,
                                                  width: 180, height: 195)
                                              : const SizedBox.shrink()));
                                }),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
            categoryList(),
            Container(
              decoration: const BoxDecoration(
                  color: AppColorTheme.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(children: [
                colorList(),
                GetBuilder<AvatarMakerController>(
                    id: "avatar_category",
                    builder: (controller) {
                      switch (category[controller.selectedCategory]) {
                        case "BODY":
                          return componentList(
                              bodyAssets,
                              "avatar_body",
                              (index) => controller.body = index,
                              (index) => controller.selectedBody == index);
                        case "EYES":
                          return componentList(
                              eyesAssets,
                              "avatar_eyes",
                              (index) => controller.eyes = index,
                              (index) => controller.selectedEyes == index);
                        case "NOSE":
                          return componentList(
                              noseAssets,
                              "avatar_nose",
                              (index) => controller.nose = index,
                              (index) => controller.selectedNose == index);
                        case "MOUTH":
                          return componentList(
                              mouthAssets,
                              "avatar_mouth",
                              (index) => controller.mouth = index,
                              (index) => controller.selectedMouth == index);
                        case "SHORT HAIR":
                          return componentList(
                              shortHairAssets,
                              "avatar_hair",
                              (index) => controller.shortHair = index,
                              (index) => controller.selectedShortHair == index);
                        case "LONG HAIR":
                          return componentList(
                              longHairAssets,
                              "avatar_hair",
                              (index) => controller.longHair = index,
                              (index) => controller.selectedLongHair == index);
                        case "FACIAL_HAIR":
                          return componentList(
                              facialHairAssets,
                              "avatar_facial_hair",
                              (index) => controller.facialHair = index,
                              (index) =>
                                  controller.selectedFacialHair == index);
                        case "CLOTHING":
                          return componentList(
                              clothingAssets,
                              "avatar_clothing",
                              (index) => controller.clothing = index,
                              (index) => controller.selectedClothing == index);
                        case "HAT":
                          return componentList(
                              hatAssets,
                              "avatar_hat",
                              (index) => controller.hat = index,
                              (index) => controller.selectedHat == index);
                        case "ACCESSORY":
                          return componentList(
                              accessoryAssets,
                              "avatar_accessory",
                              (index) => controller.accessory = index,
                              (index) => controller.selectedAccessory == index);
                        default:
                          return const SizedBox.shrink();
                      }
                    }),
                // Space for FAB to not cover the category items
                const SizedBox(height: 36)
              ]),
            )
          ])),
    );
  }
}
