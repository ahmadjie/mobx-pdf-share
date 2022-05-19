import 'package:creditest/models/listphotos.dart';
import 'package:creditest/services/network_services.dart';
import 'package:mobx/mobx.dart';

// flutter packages pub run build_runner build
part 'photo_store.g.dart';

class PhotoStore = _PhotoStore with _$PhotoStore;

abstract class _PhotoStore with Store {
  final NetworkService httpClient = NetworkService();

  // future list data photo
  @observable
  ObservableFuture<List<ListPhotos>>? observableListData;

  // list data photo
  @observable
  List<ListPhotos>? listData;

  @observable
  int? photoId;

  // fetch data photo api
  @action
  Future fetchData() => observableListData =
          ObservableFuture(httpClient.getListData().then((data) {
        final sliceData = data.sublist(0, 101);
        listData = sliceData;
        return sliceData;
      }));

  // set photo id
  @action
  void setPhotoId(int val) {
    photoId = val;
  }

  // filter detail data photo list with photo id
  @computed
  ListPhotos? get detailData {
    return listData?.where((e) => e.id == photoId).toList().first;
  }
}
