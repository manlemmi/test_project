
part of 'articles_bloc.dart';

class ArticlesState {
  final List<Article> articles;
  final bool isLoading;

  const ArticlesState({
    this.articles = const [],
    this.isLoading = false,
  });

  ArticlesState copyWith({
    List<Article>? articles,
    bool? isLoading,
  }) {
    return ArticlesState(
      articles: articles ?? this.articles,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}