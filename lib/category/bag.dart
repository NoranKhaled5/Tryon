import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

// استبدل أسماء البكجات وال import paths حسب مشروعك:
import '../Fav_screen/view_model/cubit.dart';
import '../Fav_screen/view_model/states.dart';
import '../profile/view/widget/profile_screen_body.dart';
import '../profile/view_model/cubit.dart';


class BagsScreen extends StatefulWidget {
  const BagsScreen({Key? key}) : super(key: key);

  @override
  State<BagsScreen> createState() => _BagsScreenState();
}

class _BagsScreenState extends State<BagsScreen> {
  int _currentIndex = 0;

  final List<Map<String, String>> bags = [
    {
      "name": "Bag1",
      "image": "assets/bags/bagone.jpg",
      "url": "https://snapchat.com/t/EVtqC0Hm",
    },
    {
      "name": "Bag2",
      "image": "assets/bags/bagtwo.jpg",
      "url": "https://snapchat.com/t/Isa7A20J",
    },
    {
      "name": "Bag3",
      "image": "assets/bags/bagthree.jpg",
      "url": "https://snapchat.com/t/g04YIuMo",
    },
    {
      "name": "Bag4",
      "image": "assets/bags/bagfour.jpg",
      "url": "https://snapchat.com/t/T1yqiDgF",
    },
    {
      "name": "Bag5",
      "image": "assets/bags/bagfive.jpg",
      "url": "https://snapchat.com/t/T1yqiDgF",
    },
    {
      "name": "Bag6",
      "image": "assets/bags/bagsix.jpg",
      "url": "https://snapchat.com/t/n5LSW0LN",
    },
  ];

  void _showError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sorry, could not open link.')),
    );
  }

  Future<void> _launchInBrowser(Uri url, BuildContext context) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      _showError(context);
    }
  }

  Widget _buildBagsGrid(FavCubit cubit) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: bags.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.62,
          ),
          itemBuilder: (context, index) {
            final bag = bags[index];
            final isFav = cubit.isFavorite(bag);
            final isInCart = cubit.isInCart(bag);

            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: Image.asset(
                      bag["image"]!,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    bag["name"]!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 4),
                      Text("200", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 140,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4B2A5F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {
                              _launchInBrowser(Uri.parse(bag["url"]!), context);
                            },
                            child: const Text(
                              "Try On",
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 0),
                      IconButton(
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          cubit.toggleFavorite(bag);
                        },
                      ),
                      const SizedBox(width: 0),
                      IconButton(
                        icon: Icon(
                          isInCart ? Icons.shopping_cart : Icons.add_shopping_cart,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          cubit.toggleCart(bag);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildListSection(
      List<Map<String, String>> items, Function(Map<String, String>) onRemove) {
    if (items.isEmpty) {
      return const Center(child: Text('Currently no items'));
    }
    return SafeArea(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        padding: const EdgeInsets.only(bottom: 60),
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            leading: Image.asset(item["image"]!, width: 50, height: 50),
            title: Text(item["name"]!),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => onRemove(item),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FavCubit()),
        BlocProvider(create: (_) => ProfileCubit()..GetProfile()),
      ],
      child: BlocConsumer<FavCubit, FavStates>(
        listener: (context, state) {
          if (state is AddToFavSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Added to favorites")),
            );
          } else if (state is RemovedSuccessfully) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Removed from favorites")),
            );
          } else if (state is AddToCartSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Added to cart")),
            );
          } else if (state is RemovedFromCartSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Removed from cart")),
            );
          }
        },
        builder: (context, state) {
          final cubit = FavCubit.get(context);
          final profileCubit = ProfileCubit.get(context);

          List<Widget> screens = [
            _buildBagsGrid(cubit),
            _buildListSection(cubit.favoriteGlasses, cubit.toggleFavorite),
            _buildListSection(cubit.cartGlasses, cubit.toggleCart),
            ProfileScreenBody(),
          ];

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: const Color(0xFF4B2A5F),
              elevation: 0,
              title: Text(
                "Bags",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            body: screens[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              selectedItemColor: const Color(0xFF4B2A5F),
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
                //BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
              ],
            ),
          );
        },
      ),
    );
  }
}
