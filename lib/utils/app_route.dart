enum AppRoute {
  home("/home"),
  search("/search"),
  categoryDetail("/category_detail_screen"),
  details("/detail");

  final String route;

  const AppRoute(this.route);
}
