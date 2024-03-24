import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/router/app_router.dart';
import '../../../utils/extensions/scroll_controller_extensions.dart';
import '../../../utils/resources/styles.dart';
import '../../bloc/articles/articles_bloc.dart';
import '../../bloc/settings/settings_bloc.dart';
import '../common/article_widget.dart';

@RoutePage()
class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.onScrollEndsListener(() {
      context.read<ArticlesBloc>().add(LoadArticles());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daily News',
          style: Styles.s25butler,
        ),
        actions: [
          GestureDetector(
            onTap: () => context.pushRoute(const FavouritesRoute()),
            onLongPress: () => context.read<SettingsBloc>().add(ChangeTheme()),
            child: const Padding(
              padding: EdgeInsets.only(right: 14),
              child: Icon(
                Icons.bookmark,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ArticlesBloc, ArticlesState>(
        builder: (context, state) {
          final articles = state.articles;
          return ListView(
            controller: _scrollController,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return ArticleWidget(
                    article: articles[index],
                    onArticlePressed: (article) => context.pushRoute(
                      DetailsRoute(article: article),
                    ),
                  );
                },
              ),
              if (state.isLoading)
                const Padding(
                  padding: EdgeInsets.only(
                    bottom: 40,
                    top: 8,
                  ),
                  child: CupertinoActivityIndicator(),
                ),
            ],
          );
        },
      ),
    );
  }
}
