import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/router/app_router.dart';
import '../../../domain/models/article.dart';
import '../../../utils/resources/styles.dart';
import '../../bloc/favourites/favourites_bloc.dart';
import '../common/article_widget.dart';

@RoutePage()
class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favourites',
          style: Styles.s25butler,
        ),
        leading: GestureDetector(
          onTap: context.back,
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocBuilder<FavouritesBloc, List<Article>>(
        builder: (context, articles) {
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return Dismissible(
                background: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  alignment: Alignment.centerRight,
                  child: const Icon(
                    CupertinoIcons.trash,
                  ),
                ),
                direction: DismissDirection.endToStart,
                key: ValueKey<Article>(articles[index]),
                onDismissed: (DismissDirection direction) {
                  context
                      .read<FavouritesBloc>()
                      .add(RemoveFavourite(index: index));
                },
                child: ArticleWidget(
                  article: articles[index],
                  onArticlePressed: (article) => context.pushRoute(
                    DetailsRoute(article: article),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
