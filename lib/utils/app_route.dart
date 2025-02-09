enum AppRoute {
  home("/splash"),
  splash("/home"),
  search("/search"),
  categoryDetail("/category_detail_screen"),
  details("/detail");

  final String route;

  const AppRoute(this.route);
}
