import 'dart:math';

import 'package:flutter_avatar_maker/assets.dart' as assets;
import 'package:flutter_avatar_maker/shared/background_shape.dart';
import 'package:get/get.dart';

enum HairType {
  short,
  long,
}

class AvatarMakerController extends GetxController {
  final _selectedCategory = 0.obs;
  get selectedCategory => _selectedCategory.value;
  set category(int value) {
    _selectedCategory.value = value;
    update(["avatar_category"]);
  }

  final _selectedColor = 0.obs;
  get selectedColor => _selectedColor.value;
  set color(int value) {
    _selectedColor.value = value;
    update(["avatar_color"]);
  }

  final _selectedBody = 0.obs;
  get selectedBody => _selectedBody.value;
  set body(int value) {
    _selectedBody.value = value;
    update(["avatar_body"]);
  }

  final _selectedHairType = HairType.short.obs;
  get selectedHairType => _selectedHairType.value;
  set hairType(HairType value) {
    _selectedHairType.value = value;
    update(["avatar_hair_type"]);
  }

  final _selectedShortHair = 0.obs;
  get selectedShortHair => _selectedShortHair.value;
  set shortHair(int value) {
    _selectedShortHair.value = value;
    update(["avatar_hair"]);
  }

  final _selectedLongHair = 0.obs;
  get selectedLongHair => _selectedLongHair.value;
  set longHair(int value) {
    _selectedLongHair.value = value;
    update(["avatar_hair"]);
  }

  final _selectedEyes = 0.obs;
  get selectedEyes => _selectedEyes.value;
  set eyes(int value) {
    _selectedEyes.value = value;
    update(["avatar_eyes"]);
  }

  final _selectedNose = 0.obs;
  get selectedNose => _selectedNose.value;
  set nose(int value) {
    _selectedNose.value = value;
    update(["avatar_nose"]);
  }

  final _selectedMouth = 0.obs;
  get selectedMouth => _selectedMouth.value;
  set mouth(int value) {
    _selectedMouth.value = value;
    update(["avatar_mouth"]);
  }

  final _selectedFacialHair = 0.obs;
  get selectedFacialHair => _selectedFacialHair.value;
  set facialHair(int value) {
    _selectedFacialHair.value = value;
    update(["avatar_facial_hair"]);
  }

  final _selectedFacialHairColor = 0.obs;
  get selectedFacialHairColor => _selectedFacialHairColor.value;
  set facialHairColor(int value) {
    _selectedFacialHairColor.value = value;
    update(["avatar_facial_hair"]);
  }

  final _selectedHat = 0.obs;
  get selectedHat => _selectedHat.value;
  set hat(int value) {
    _selectedHat.value = value;
    // Here notify both hat and hair because showing hat should hide hair hence
    // notify hair to get hair to update
    update(["avatar_hat", "avatar_hair"]);
  }

  final _selectedClothing = 0.obs;
  get selectedClothing => _selectedClothing.value;
  set clothing(int value) {
    _selectedClothing.value = value;
    update(["avatar_clothing"]);
  }

  final _selectedClothingColor = 0.obs;
  get selectedClothingColor => _selectedClothingColor.value;
  set clothingColor(int value) {
    _selectedClothingColor.value = value;
    update(["avatar_clothing"]);
  }

  final _selectedAccessory = 0.obs;
  get selectedAccessory => _selectedAccessory.value;
  set accessory(int value) {
    _selectedAccessory.value = value;
    update(["avatar_accessory"]);
  }

  final _selectedAccessoryColor = 0.obs;
  get selectedAccessoryColor => _selectedAccessoryColor.value;
  set accessoryColor(int value) {
    _selectedAccessoryColor.value = value;
    update(["avatar_accessory"]);
  }

  final _selectedBackgroundColor = 0.obs;
  get selectedBackgroundColor => _selectedBackgroundColor.value;
  set backgroundColor(int value) {
    _selectedBackgroundColor.value = value;
    update(["avatar_background_color", "avatar_background"]);
  }

  final _selectedBackgroundShape = BackgroundShape.circle.obs;
  get selectedBackgroundShape => _selectedBackgroundShape.value;
  set backgroundShape(BackgroundShape value) {
    _selectedBackgroundShape.value = value;
    update(["avatar_background_shape", "avatar_background"]);
  }

  /// Function that executes randomize() starting from fast and gradually slowing down for a given time interval
  void randomizeForInterval(int timeInterval) {
    final interval = timeInterval / 100;
    for (var i = 0; i < 500;) {
      Future.delayed(Duration(milliseconds: (interval * i).toInt()), () {
        randomize();
      });
      if (i < 150) {
        i += 4;
      } else if (i < 300) {
        i += 8;
      } else {
        i += 12;
      }
    }
  }

  void randomize() {
    body = _randomInt(0, assets.bodyAssets.length - 1);
    hairType = _randomInt(0, 1) == 0 ? HairType.short : HairType.long;
    if (selectedHairType == HairType.short) {
      shortHair = _randomInt(0, assets.shortHairAssets.length - 1);
    } else {
      longHair = _randomInt(0, assets.longHairAssets.length - 1);
    }
    eyes = _randomInt(0, assets.eyesAssets.length - 1);
    nose = _randomInt(0, assets.noseAssets.length - 1);
    mouth = _randomInt(0, assets.mouthAssets.length - 1);
    facialHair = _randomInt(0, assets.facialHairAssets.length - 1);
    facialHairColor = _randomInt(0, assets.facialHairColor.length - 1);
    hat = _randomInt(0, assets.hatAssets.length - 1);
    clothing = _randomInt(0, assets.clothingAssets.length - 1);
    clothingColor = _randomInt(0, assets.clothingColor.length - 1);
    accessory = _randomInt(0, assets.accessoryAssets.length - 1);
    accessoryColor = _randomInt(0, assets.accessoryColor.length - 1);
    update();
  }

  int _randomInt(int min, int max) {
    return (min + (max - min) * _random.nextDouble()).toInt();
  }

  final _random = Random();

  AvatarMakerController();
}
