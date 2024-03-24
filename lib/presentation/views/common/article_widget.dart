import 'package:flutter/material.dart';

import '../../../domain/models/article.dart';
import '../../../utils/resources/styles.dart';

class ArticleWidget extends StatelessWidget {
  final Article article;
  final void Function(Article article)? onRemove;
  final void Function(Article article)? onArticlePressed;

  const ArticleWidget({
    required this.article,
    this.onArticlePressed,
    this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onArticlePressed?.call(article),
      child: Container(
        height: 150,
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Row(
          children: [
            _ImageArticle(article.urlToImage),
            _DescriptionArticle(article),
          ],
        ),
      ),
    );
  }
}

class _ImageArticle extends StatelessWidget {
  const _ImageArticle(this.path);

  final String? path;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      height: 150,
      margin: const EdgeInsets.only(right: 10),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.08),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
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

class _DescriptionArticle extends StatelessWidget {
  const _DescriptionArticle(this.article);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              article.title ?? '',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: Styles.s18fw900butler,
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.access_time,
                size: 16,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  article.publishedAt ?? '',
                  maxLines: 1,
                  style: Styles.s14butler,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
