import 'package:vertical_view_pager/constant/constant.dart';

class Champion {
  final String name;
  final Role role;
  final Difficulty difficulty;

  const Champion({this.name, this.difficulty, this.role});
}

final championsMap = {
  "Akali": Champion(
      name: "Akali", role: Role.ASSASIN, difficulty: Difficulty.MODERATE),
  "Camile": Champion(
      name: "Camile", role: Role.FIGHTER, difficulty: Difficulty.MODERATE),
  "Ezreal": Champion(
      name: "Ezreal", role: Role.MARKSMAN, difficulty: Difficulty.MODERATE),
  "Zoe": Champion(
      name: "Zoe", role: Role.MAGE, difficulty: Difficulty.HIGH),
  "Irelia": Champion(
      name: "Irelia", role: Role.FIGHTER, difficulty: Difficulty.MODERATE),
  "Poppy": Champion(
      name: "Poppy", role: Role.TANKER, difficulty: Difficulty.MODERATE),
};
