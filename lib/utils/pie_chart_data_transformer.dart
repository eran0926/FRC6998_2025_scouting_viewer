List<Map<String, dynamic>> pieChartDataTransformer(Map<String, dynamic> json) {
  return json.entries
      .map((e) => {
            'name': e.key,
            'value': e.value,
          })
      .toList()
      .cast<Map<String, dynamic>>();
}
