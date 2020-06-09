import 'package:vertical_view_pager/constant/constant.dart';

class Champion {
  final String name;
  final String nickName;
  final Role role;
  final Difficulty difficulty;

  const Champion({this.name, this.nickName, this.difficulty, this.role});
}


final championsMap = {
  "akali": Champion(
    name: "Akali",
    role: Role.ASSASIN,
    difficulty: Difficulty.MODERATE,
    nickName: "THE ROGUE ASSASSIN",
  ),
  "camile": Champion(
    name: "Camile",
    role: Role.FIGHTER,
    difficulty: Difficulty.MODERATE,
    nickName: "THE STEEL SHADOW",
  ),
  "ezreal": Champion(
    name: "Ezreal",
    role: Role.MARKSMAN,
    difficulty: Difficulty.MODERATE,
    nickName: "THE PRODIGAL EXPLORER",
  ),
  "zoe": Champion(
    name: "Zoe",
    role: Role.MAGE,
    difficulty: Difficulty.HIGH,
    nickName: "THE ASPECT OF TWILIGHT",
  ),
  "irelia": Champion(
    name: "Irelia",
    role: Role.FIGHTER,
    difficulty: Difficulty.MODERATE,
    nickName: "THE BLADE DANCER",
  ),
  "poppy": Champion(
    name: "Poppy",
    role: Role.TANKER,
    difficulty: Difficulty.MODERATE,
    nickName: "KEEPER OF THE HAMMER",
  ),
};
