import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/article.dart';
import '../../../domain/models/requests/news.request.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../utils/resources/data_state.dart';

part 'articles_event.dart';

part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final ApiRepository _apiRepository;

  ArticlesBloc(this._apiRepository) : super(const ArticlesState()) {
    on<LoadArticles>(_loadArticles);
  }

  int _page = 1;

  void _loadArticles(LoadArticles event, Emitter<ArticlesState> emit) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true));
    final response = await _apiRepository.getNewsArticles(
      request: NewsRequest(page: _page),
    );

    if (response is DataSuccess) {
      final articles = response.data!.articles;

      final list = state.articles.toList();
      list.addAll(articles);
      _page++;

      emit(
        state.copyWith(
          articles: list,
          isLoading: false,
        ),
      );
    } else if (response is DataFailed) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
