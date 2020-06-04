import 'package:vertical_view_pager/constant/constant.dart';

class Champion {
  final String name;
  final Role role;
  final Difficulty difficulty;

  const Champion({this.name, this.difficulty, this.role});
}

final championsMap = {
  "akali": Champion(
      name: "Akali", role: Role.ASSASIN, difficulty: Difficulty.MODERATE),
  "camile": Champion(
      name: "Camile", role: Role.FIGHTER, difficulty: Difficulty.MODERATE),
  "ezreal": Champion(
      name: "Ezreal", role: Role.MARKSMAN, difficulty: Difficulty.MODERATE),
  "zoe": Champion(
      name: "Zoe", role: Role.MAGE, difficulty: Difficulty.HIGH),
  "irelia": Champion(
      name: "Irelia", role: Role.FIGHTER, difficulty: Difficulty.MODERATE),
  "poppy": Champion(
      name: "Poppy", role: Role.TANKER, difficulty: Difficulty.MODERATE),
};
