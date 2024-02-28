// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rwayat/features/liveView/data/repos/live_repo_impl.dart';

part 'live_state.dart';

class LiveCubit extends Cubit<LiveState> {
  LiveCubit(this.liveRepoImpl) : super(LiveInitial());
  final LiveRepoImpl liveRepoImpl;

  Future<void> getLiveurl() async {
    emit(LiveLoading());
    var result = await liveRepoImpl.getLiveUrl();
    result.fold((failure) {
      emit(LiveFailure(errMessage: failure));
    }, (success) {
      emit(LiveSuccess(liveUrl: success));
    });
  }

  Future<void> getEmojeAdsCounter() async {
    emit(EmojeAdsCounterLoading());
    var result = await liveRepoImpl.getEmojeAdsCounter();
    result.fold((failure) {
      emit(EmojeAdsCounterFailure(errMessage: failure));
    }, (success) {
      emit(EmojeAdsCounterSuccess(adsCounter: success));
    });
  }
}
