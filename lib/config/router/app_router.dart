import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../domain/models/article.dart';
import '../../presentation/views/articles_page/articles_screen.dart';
import '../../presentation/views/details_page/details_screen.dart';
import '../../presentation/views/favourites_page/favourites_screen.dart';
import '../../presentation/views/splash_page/splash_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: ArticlesRoute.page),
    AutoRoute(page: DetailsRoute.page),
    AutoRoute(page: FavouritesRoute.page),
  ];
}