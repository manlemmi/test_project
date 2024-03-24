import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../domain/models/article.dart';

part 'favourites_event.dart';

class FavouritesBloc extends HydratedBloc<FavouritesEvent, List<Article>> {
  FavouritesBloc() : super(const []) {
    on<AddFavourite>(_addToFavorites);
    on<RemoveFavourite>(_removeFromFavorites);
  }

  void _addToFavorites(AddFavourite event, Emitter<List<Article>> emit) {
    emit(state.toList()..add(event.article));
  }

  void _removeFromFavorites(
      RemoveFavourite event, Emitter<List<Article>> emit) {
    if (event.index != null) {
      emit(state.toList()..removeAt(event.index!));
    } else {
      emit(state.toList()..remove(event.article));
    }
  }

  @override
  List<Article>? fromJson(Map<String, dynamic> json) {
    if ((json['items'] as List<dynamic>).isNotEmpty) {
      return (json['items'] as List<dynamic>)
          .map((e) => Article.fromJson(e))
          .toList();
    }
    return [];
  }

  @override
  Map<String, dynamic>? toJson(List<Article> state) {
    final items = state.map((e) => e.toJson()).toList();
    return {'items': items};
  }
}
