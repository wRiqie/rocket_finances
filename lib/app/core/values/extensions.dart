extension MapExt<K, V> on Map<K, V> {
  void addAllNotNull(Map<K, V> map) {
    for (var entry in map.entries) {
      if (entry.value != null) {
        addAll({entry.key: entry.value});
      }
    }
  }
}
