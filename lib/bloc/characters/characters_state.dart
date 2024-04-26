import 'package:studio_ghibli_app/models/character.dart';

abstract class CharactersState {}

class CharactersInitialState extends CharactersState {}

class CharactersLoadingState extends CharactersState {}

class CharactersLoadedState extends CharactersState {
  final List<Character> characters;

  CharactersLoadedState(this.characters);
}

class CharacterDetailsLoadingState extends CharactersState {}

class CharacterDetailsLoadedState extends CharactersState {
  final Character characterDetails;

  CharacterDetailsLoadedState(this.characterDetails);
}

class CharactersErrorState extends CharactersState {
  final String message;

  CharactersErrorState(this.message);
}
