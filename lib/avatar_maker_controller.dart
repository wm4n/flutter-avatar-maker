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
    update(["avatar_hat"]);
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

  AvatarMakerController();
}
