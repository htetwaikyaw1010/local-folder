import 'dart:ui';

class Dimesion {
  static double screenWidth =
      PlatformDispatcher.instance.views.first.physicalSize.width /
          PlatformDispatcher.instance.views.first.devicePixelRatio;
  static double screeHigh =
      PlatformDispatcher.instance.views.first.physicalSize.height /
          PlatformDispatcher.instance.views.first.devicePixelRatio;
  // static double screeHigh = Get.context!.height;
  // static double screeWidth = Get.context!.width;
  static double pageView = screeHigh / 2.23;

//height
  static double height2 = height20 / 10;
  static double height3 = height30 / 3;
  static double height4 = height40 / 10;
  static double height5 = height10 / 2;
  static double height6 = height4 + height2;
  static double height7 = height4 + height3;
  static double height8 = height4 * 2;
  static double height10 = screeHigh / 71.5;
  static double height12 = height6 * 2;
  static double height15 = screeHigh / 47.67;
  static double height16 = height4 * 4;
  static double height18 = height16 + height2;
  static double height20 = screeHigh / 35.75;
  static double height24 = height20 + height4;
  static double height28 = height20 + height8;
  static double height30 = screeHigh / 23.83;
  static double height32 = height16 * 2;
  static double height35 = height30 + height5;
  static double height40 = screeHigh / 17.88;
  static double height44 = height40 + height4;
  static double height48 = height40 + height8;
  static double height50 = height10 * 5;
  static double height52 = height50 + height2;
  static double height60 = height20 * 3;
  static double height70 = height10 * 7;
  static double height75 = height70 + 5;

  static double height80 = height40 * 2;
  static double height90 = height80 + height10;
  static double height100 = height10 * 10;
  static double height120 = height10 * 12;
  static double height130 = height10 * 13;
  static double height140 = height10 * 14;
  static double height150 = height10 * 15;

  static double height190 = height100 + height90;
  static double height200 = height100 * 2;
  static double height400 = height100 * 4;
  static double height500 = height100 * 5;
  static double height600 = height100 * 6;

  //fonts
  static double font2 = font20 * 10;
  static double font4 = font16 / 8;

  static double font12 = screeHigh / 59.58;
  static double font14 = font2 * 7;
  static double font16 = screeHigh / 44.69;
  static double font18 = screeHigh / 39.72;
  static double font20 = font4 * 5;
  static double font26 = screeHigh / 25;
  //radius
  static double radius5 = radius20 / 4;
  static double radius10 = radius20 / 2;
  static double radius20 = screeHigh / 35.75;
  static double radius30 = screeHigh / 23.83;
  static double radius15 = screeHigh / 47.67;
  //width
  static double width10 = screeHigh / 71.5;
  static double width5 = screeHigh / 143;

  static double width20 = screeHigh / 35.75;
  static double width30 = screeHigh / 23.83;

  static double size24 = screeHigh / 29.79;
  static double size25 = screeHigh / 28.6;
  static double size18 = screeHigh / 39.72;
//iconsSize
  static double iconSize4 = iconSize16 / 4;
  static double iconSize16 = screeHigh / 44.81;
  static double iconSize20 = iconSize16 + iconSize4;

  static double iconSize25 = screeHigh / 28.6;
  static double iconSize32 = iconSize16 * 2;
  //imageSize
  static double popularImgSize = screeHigh / 2.17;
//pageviewhienght
  static double pageViewContainer = screeHigh / 3.25;
  static double pageViewTextContainer = screeHigh / 5.96;
}
