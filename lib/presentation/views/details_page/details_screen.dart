import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/article.dart';
import '../../../utils/resources/styles.dart';
import '../../bloc/favourites/favourites_bloc.dart';

@RoutePage()
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    required this.article,
    super.key,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouritesBloc, List<Article>>(
      builder: (context, articles) {
        final _isAlreadyExist = articles.contains(article);
        final _icon = _isAlreadyExist
            ? const Icon(
                CupertinoIcons.bookmark_fill,
                color: Colors.white,
              )
            : const Icon(
                CupertinoIcons.bookmark,
                color: Colors.white,
              );
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: context.back,
              child: const Icon(
                CupertinoIcons.back,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _TitleDetails(article),
                _DetailsImage(article.urlToImage),
                _DescriptionDetails(article),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_isAlreadyExist) {
                context
                    .read<FavouritesBloc>()
                    .add(RemoveFavourite(article: article));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Article Removed Successfully'),
                  ),
                );
              } else {
                context.read<FavouritesBloc>().add(AddFavourite(article));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Article Saved Successfully'),
                  ),
                );
              }
            },
            child: _icon,
          ),
        );
      },
    );
  }
}

class _TitleDetails extends StatelessWidget {
  const _TitleDetails(this.article);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title ?? '',
            style: Styles.s20fw900butler,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(
                Icons.access_time,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                article.publishedAt ?? '',
                style: Styles.s14butler,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailsImage extends StatelessWidget {
  const _DetailsImage(this.path);

  final String? path;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: const EdgeInsets.only(top: 14),
      child: Image.network(
        path ?? '',
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return const Center(
            child: Text(
              'not found image',
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}

class _DescriptionDetails extends StatelessWidget {
  const _DescriptionDetails(this.article);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      child: Text(
        '${article.description}\n\n${article.content}',
        style: Styles.s16butler,
      ),
    );
  }
}
