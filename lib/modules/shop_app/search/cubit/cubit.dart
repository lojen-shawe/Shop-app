import 'package:first_flutter/models/shop_model/search_model.dart';
import 'package:first_flutter/modules/shop_app/search/cubit/state.dart';
import 'package:first_flutter/shared/network/end_points.dart';
import 'package:first_flutter/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() :super(SearchInitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);
  SearchModel model=SearchModel();
  void search({required String text}){
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
      data: {
          'text':text
      },
    ).then((value) {
      model=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());
    });
  }
}