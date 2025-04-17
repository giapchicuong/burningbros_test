class PaginationState<T> {
  int skip = 0;
  bool hasReachedEnd = false;
  bool isFetching = false;
  List<T> items = [];

  void reset() {
    skip = 0;
    hasReachedEnd = false;
    isFetching = false;
    items = [];
  }

  void startFetching() {
    isFetching = true;
  }

  void stopFetching() {
    isFetching = false;
  }

  void update(List<T> newItems, int limit) {
    hasReachedEnd = newItems.length < limit;
    items = [...items, ...newItems];
    skip += limit;
    stopFetching();
  }
}
