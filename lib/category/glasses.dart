import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled15/profile/view_model/cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Fav_screen/view_model/cubit.dart';
import '../Fav_screen/view_model/states.dart';
import '../profile/view/widget/profile_screen_body.dart';

class GlassesScreen extends StatefulWidget {
  const GlassesScreen({Key? key}) : super(key: key);

  @override
  State<GlassesScreen> createState() => _GlassesScreenState();
}

class _GlassesScreenState extends State<GlassesScreen> {
  int _currentIndex = 0;

  final List<Map<String, String>> glasses = [
    {
      "name": "Glasses1",
      "image": "assets/glasses/gl1.jpg",
      "url": "https://snapchat.com/t/zZE1HU1i",
    },
    {
      "name": "Glasses2",
      "image": "assets/glasses/gl2.jpg",
      "url": "https://snapchat.com/t/Ji9kVhsU",
    },
    {
      "name": "Glasses3",
      "image": "assets/glasses/gl3.jpg",
      "url": "https://snapchat.com/t/arH4jcmo",
    },
    {
      "name": "Glasses4",
      "image": "assets/glasses/gl4.jpg",
      "url": "https://snapchat.com/t/uK0wIsYu",
    },
    {
      "name": "Glasses5",
      "image": "assets/glasses/gl5.jpg",
      "url": "https://snapchat.com/t/uK0wIsYu",
    },
    {
      "name": "Glasses6",
      "image": "assets/glasses/gl6.jpg",
      "url": "https://snapchat.com/t/uK0wIsYu",
    },
  ];

  void _showError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sorry, couldnot open link.')),

    );
  }

  Future<void> _launchInBrowser(Uri url, BuildContext context) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      _showError(context);
    }
  }

  Widget _buildGlassesGrid(FavCubit cubit) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: glasses.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.62,
          ),
          itemBuilder: (context, index) {
            final glass = glasses[index];
            final isFav = cubit.isFavorite(glass);
            final isInCart = cubit.isInCart(glass);

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
                      glass["image"]!,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    glass["name"]!,
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
                              _launchInBrowser(Uri.parse(glass["url"]!), context);
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
                          cubit.toggleFavorite(glass);
                        },
                      ),
                      const SizedBox(width: 0),
                      IconButton(
                        icon: Icon(
                          isInCart ? Icons.shopping_cart : Icons.add_shopping_cart,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          cubit.toggleCart(glass);
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
          final glass = items[index];
          return ListTile(
            leading: Image.asset(glass["image"]!, width: 50, height: 50),
            title: Text(glass["name"]!),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => onRemove(glass),
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
              const SnackBar(content: Text("added to cart")),

            );
          } else if (state is RemovedFromCartSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("removed from basket")),

            );
          }
        },
        builder: (context, state) {
          final cubit = FavCubit.get(context);
          final profileCubit = ProfileCubit.get(context);

          List<Widget> screens = [
            _buildGlassesGrid(cubit),
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
                "welcome، ${profileCubit.showProfileModel?.data?.name ?? 'user'}",
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
