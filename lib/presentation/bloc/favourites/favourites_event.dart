part of 'favourites_bloc.dart';

abstract class FavouritesEvent {}

class AddFavourite extends FavouritesEvent {
  final Article article;

  AddFavourite(this.article);
}

class RemoveFavourite extends FavouritesEvent {
  final Article? article;
  final int? index;

  RemoveFavourite({
    this.article,
    this.index,
  });
}
