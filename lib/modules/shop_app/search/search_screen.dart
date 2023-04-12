import 'package:first_flutter/modules/shop_app/search/cubit/cubit.dart';
import 'package:first_flutter/modules/shop_app/search/cubit/state.dart';
import 'package:first_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
var formKey=GlobalKey<FormState>();
var textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body:Column(
              children:
              [
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: textController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "input text to search";
                    }

                    return null;
                  },
                  onFieldSubmitted: (String text) {
                    SearchCubit.get(context).search(text: text);
                  },
                  onChanged: (val) {
                    print(val);
                  },
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                SizedBox(height: 10.0,),
                if(state is SearchLoadingState)
                  LinearProgressIndicator(),
                SizedBox(height: 10.0,),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context,index)=>buildCategoryItem(SearchCubit.get(context).model.data?.data![index],context,isOldPrice: false),
                    separatorBuilder: (context,index)=>myDivider(),
                    itemCount: SearchCubit.get(context).model.data!.data!.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
