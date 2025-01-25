class UIState<T> {
  final T? data;
  final bool loader;
  final String? error;

  UIState({this.data, this.loader = true, this.error});
}
