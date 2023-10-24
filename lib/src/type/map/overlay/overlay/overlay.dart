part of flutter_naver_map;

abstract class NOverlay<O extends NOverlay<void>>
    with _NOverlaySender, _NOverlayHandler<O> {
  NOverlay({
    required this.info,
    double? minZoom,
    double? maxZoom,
  })  : _minZoom = minZoom ?? NaverMapViewOptions.minimumZoom,
        _maxZoom = maxZoom ?? NaverMapViewOptions.maximumZoom {
    if (minZoom != null && maxZoom != null) {
      assert(minZoom <= maxZoom);
    }
  }

  @override
  final NOverlayInfo info;

  @override
  bool get _isAdded => _overlayController != null;

  @override
  _NOverlayController? _overlayController;

  void _addedOnMap(_NOverlayController controller) {
    controller.add(info, this);
    _overlayController = controller;
  }

  @override
  Function(O overlay)? _onTapListener;

  /*
    --- methods ---
  */

  int get zIndex => _zIndex;
  int _zIndex = 0;

  /// globalZIndex has different initial values for each overlay type.
  int get _globalZIndex;

  set _globalZIndex(int value);

  int get globalZIndex => _globalZIndex;

  bool get isVisible => _isVisible;
  bool _isVisible = true;

  double get minZoom => _minZoom;
  double _minZoom = NaverMapViewOptions.minimumZoom;

  double get maxZoom => _maxZoom;
  double _maxZoom = NaverMapViewOptions.maximumZoom;

  bool get isMinZoomInclusive => _isMinZoomInclusive;
  bool _isMinZoomInclusive = true;

  bool get isMaxZoomInclusive => _isMaxZoomInclusive;
  bool _isMaxZoomInclusive = true;

  void setZIndex(int zIndex) {
    _zIndex = zIndex;
    _set(_zIndexName, zIndex);
  }

  void setGlobalZIndex(int globalZIndex) {
    _globalZIndex = globalZIndex;
    _set(_globalZIndexName, globalZIndex);
  }

  void setIsVisible(bool isVisible) {
    _isVisible = isVisible;
    _set(_isVisibleName, isVisible);
  }

  void setMinZoom(double minZoom) {
    _minZoom = minZoom;
    _set(_minZoomName, minZoom);
  }

  void setMaxZoom(double maxZoom) {
    _maxZoom = maxZoom;
    _set(_maxZoomName, maxZoom);
  }

  void setIsMinZoomInclusive(bool isMinZoomInclusive) {
    _isMinZoomInclusive = isMinZoomInclusive;
    _set(_isMinZoomInclusiveName, isMinZoomInclusive);
  }

  void setIsMaxZoomInclusive(bool isMaxZoomInclusive) {
    _isMaxZoomInclusive = isMaxZoomInclusive;
    _set(_isMaxZoomInclusiveName, isMaxZoomInclusive);
  }

  Future<void> performClick() => _runAsync(_performClickName);

  Map<String, dynamic> get _commonMap => {
        _zIndexName: _zIndex,
        _globalZIndexName: _globalZIndex,
        _isVisibleName: _isVisible,
        _minZoomName: _minZoom,
        _maxZoomName: _maxZoom,
        _isMinZoomInclusiveName: _isMinZoomInclusive,
        _isMaxZoomInclusiveName: _isMaxZoomInclusive,
      };

  /* ----- fromMessageable ----- */

  void _applyFromMessageable(dynamic m) {
    _zIndex = m[_zIndexName]!;
    _globalZIndex = m[_globalZIndexName]!;
    _isVisible = m[_isVisibleName]!;
    _minZoom = m[_minZoomName]!;
    _maxZoom = m[_maxZoomName]!;
    _isMinZoomInclusive = m[_isMinZoomInclusiveName]!;
    _isMaxZoomInclusive = m[_isMaxZoomInclusiveName]!;
  }

  /* ----- Override ----- */

  @override
  String toString() => "$runtimeType{info: $info}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NOverlay &&
          runtimeType == other.runtimeType &&
          info == other.info;

  @override
  int get hashCode => info.hashCode;

  /*
    --- Messaging Name Define ---
  */

  static const _zIndexName = "zIndex";
  static const _globalZIndexName = "globalZIndex";
  static const _isVisibleName = "isVisible";
  static const _minZoomName = "minZoom";
  static const _maxZoomName = "maxZoom";
  static const _isMinZoomInclusiveName = "isMinZoomInclusive";
  static const _isMaxZoomInclusiveName = "isMaxZoomInclusive";
  static const _performClickName = "performClick";
}
