import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio_ghibli_app/bloc/characters/characters_event.dart';
import 'package:studio_ghibli_app/bloc/characters/characters_state.dart';
import 'package:studio_ghibli_app/repository/characters_repository.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharactersRepository charactersRepository;

  CharactersBloc({required this.charactersRepository}) : super(CharactersInitialState()) {
    on<LoadCharactersEvent>((event, emit) async {
      emit(CharactersLoadingState());
      try {
        final characters = await charactersRepository.fetchCharacters();
        emit(CharactersLoadedState(characters));
      } catch (e) {
        emit(CharactersErrorState(e.toString()));
      }
    });

    on<LoadCharactersByIdsEvent>((event, emit) async {
      emit(CharactersLoadingState());
      try {
        final characters = await charactersRepository.fetchCharactersByIds(
            event.ids);
        emit(CharactersLoadedState(characters));
      } catch (e) {
        emit(CharactersErrorState(e.toString()));
      }
    });

    on<LoadCharactersByUrlsEvent>((event, emit) async {
      emit(CharactersLoadingState());
      try {
        final characters = await charactersRepository.fetchCharactersByUrls(
            event.urls);
        emit(CharactersLoadedState(characters));
      } catch (e) {
        emit(CharactersErrorState(e.toString()));
      }
    });

    on<LoadCharacterDetailsByIdEvent>((event, emit) async {
      emit(CharacterDetailsLoadingState());
      try {
        final characterDetails = await charactersRepository.fetchCharacterDetails(
            event.characterId);
        emit(CharacterDetailsLoadedState(characterDetails));
      } catch (e) {
        emit(CharactersErrorState(e.toString()));
      }
    });

    on<LoadCharacterDetailsByUrlEvent>((event, emit) async {
      emit(CharacterDetailsLoadingState());
      try {
        final characterDetails = await charactersRepository.fetchCharacterByUrl(
            event.url);
        emit(CharacterDetailsLoadedState(characterDetails));
      } catch (e) {
        emit(CharactersErrorState(e.toString()));
      }
    });
  }
}