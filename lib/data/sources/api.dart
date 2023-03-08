class Api {
  static const String _apiBaseUrl = 'api.agify.io';

  Uri guess(String name) => _buildUri(
      parametersBuilder: () => {
            'name': name,
          });

  Uri _buildUri({
    required Map<String, dynamic> Function() parametersBuilder,
  }) {
    return Uri(
      scheme: 'https',
      host: _apiBaseUrl,
      queryParameters: parametersBuilder(),
    );
  }
}
