import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cache_helper.dart';
import '../../view_model/cubit.dart';
import '../../view_model/states.dart';

class FavScreenBody extends StatelessWidget {
  FavScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Token: ${CacheHelper.getData(key: "token")}');

    return BlocConsumer<FavCubit, FavStates>(
      listener: (context, state) {
        // ممكن تضيف هنا رسائل نجاح أو فشل حذف أو إضافة
        if (state is RemovedSuccessfully) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تم الحذف من المفضلة')),
          );
        } else if (state is AddToFavSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تمت الإضافة للمفضلة')),
          );
        }
      },
      builder: (context, state) {
        final favList = FavCubit.get(context).favoriteGlasses;

        return Scaffold(
          appBar: AppBar(
            title: Text('المفضلة'),
          ),
          body: state is ShowFavLoadingState
              ? Center(child: CircularProgressIndicator())
              : favList.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/3271760.jpg',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 16),
                const Text(
                  'No favorites added',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          )
              : ListView.builder(
            itemCount: favList.length,
            itemBuilder: (context, index) {
              final item = favList[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                elevation: 4.0,
                child: ListTile(
                  leading: item['image'] != null
                      ? Image.network(
                    item['image']!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  )
                      : const Icon(Icons.image_not_supported),
                  title: Text(
                    item['name'] ?? 'No name',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    item['price'] != null
                        ? '\$${item['price']}'
                        : 'Price not available',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      FavCubit.get(context).toggleFavorite(item);
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
