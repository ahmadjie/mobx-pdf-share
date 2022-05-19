// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PhotoStore on _PhotoStore, Store {
  Computed<ListPhotos?>? _$detailDataComputed;

  @override
  ListPhotos? get detailData =>
      (_$detailDataComputed ??= Computed<ListPhotos?>(() => super.detailData,
              name: '_PhotoStore.detailData'))
          .value;

  late final _$observableListDataAtom =
      Atom(name: '_PhotoStore.observableListData', context: context);

  @override
  ObservableFuture<List<ListPhotos>>? get observableListData {
    _$observableListDataAtom.reportRead();
    return super.observableListData;
  }

  @override
  set observableListData(ObservableFuture<List<ListPhotos>>? value) {
    _$observableListDataAtom.reportWrite(value, super.observableListData, () {
      super.observableListData = value;
    });
  }

  late final _$listDataAtom =
      Atom(name: '_PhotoStore.listData', context: context);

  @override
  List<ListPhotos>? get listData {
    _$listDataAtom.reportRead();
    return super.listData;
  }

  @override
  set listData(List<ListPhotos>? value) {
    _$listDataAtom.reportWrite(value, super.listData, () {
      super.listData = value;
    });
  }

  late final _$photoIdAtom =
      Atom(name: '_PhotoStore.photoId', context: context);

  @override
  int? get photoId {
    _$photoIdAtom.reportRead();
    return super.photoId;
  }

  @override
  set photoId(int? value) {
    _$photoIdAtom.reportWrite(value, super.photoId, () {
      super.photoId = value;
    });
  }

  late final _$_PhotoStoreActionController =
      ActionController(name: '_PhotoStore', context: context);

  @override
  Future<dynamic> fetchData() {
    final _$actionInfo = _$_PhotoStoreActionController.startAction(
        name: '_PhotoStore.fetchData');
    try {
      return super.fetchData();
    } finally {
      _$_PhotoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhotoId(int val) {
    final _$actionInfo = _$_PhotoStoreActionController.startAction(
        name: '_PhotoStore.setPhotoId');
    try {
      return super.setPhotoId(val);
    } finally {
      _$_PhotoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
observableListData: ${observableListData},
listData: ${listData},
photoId: ${photoId},
detailData: ${detailData}
    ''';
  }
}
