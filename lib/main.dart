import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/router/app_router.dart';
import 'domain/repositories/api_repository.dart';
import 'config/locator/locator.dart';
import 'presentation/bloc/articles/articles_bloc.dart';
import 'presentation/bloc/favourites/favourites_bloc.dart';
import 'presentation/bloc/settings/settings_bloc.dart';
import 'utils/resources/theme/dark_theme.dart';
import 'utils/resources/theme/light_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  final appRouter = AppRouter();
  runApp(MyApp(appRouter));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp(this.appRouter, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ArticlesBloc(
            locator<ApiRepository>(),
          )..add(LoadArticles()),
        ),
        BlocProvider(
          create: (context) => FavouritesBloc(),
        ),
        BlocProvider(
          create: (context) => SettingsBloc(ThemeMode.system),
        ),
      ],
      child: BlocBuilder<SettingsBloc, ThemeMode>(
        builder: (_, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerDelegate: appRouter.delegate(),
            routeInformationParser: appRouter.defaultRouteParser(),
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state,
          );
        },
      ),
    );
  }
}
