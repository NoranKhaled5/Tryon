import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

// هنا يمكنك استيراد ملفات cubit و states الخاصة بالمفضلة
// افترضت أنها موجودة بنفس أسماء الملفات في مشروعك
import '../Fav_screen/view_model/cubit.dart';
import '../Fav_screen/view_model/states.dart';

// لو عندك cubit للprofile
import '../profile/view_model/cubit.dart';
import '../profile/view/widget/profile_screen_body.dart';

class AccessoriesScreen extends StatefulWidget {
  const AccessoriesScreen({Key? key}) : super(key: key);

  @override
  State<AccessoriesScreen> createState() => _AccessoriesScreenState();
}

class _AccessoriesScreenState extends State<AccessoriesScreen> {
  int _currentIndex = 0;

  final List<Map<String, String>> accessories = [
    {
      "name": "Earring1",
      "image": "assets/accessories/acone.jpg",
      "url": "https://snapchat.com/t/wzpvZWSV"
    },
    {
      "name": "Earring2",
      "image": "assets/accessories/actwo.jpg",
      "url": "https://snapchat.com/t/HBeOO9yJ"
    },
    {
      "name": "Bracelet1",
      "image": "assets/accessories/acthree.jpg",
      "url": "https://snapchat.com/t/3XONbvk5"
    },
    {
      "name": "Earring3",
      "image": "assets/accessories/acfour.jpg",
      "url": "https://snapchat.com/t/UZCSOtvd"
    },
    {
      "name": "Earring4",
      "image": "assets/accessories/acfive.jpg",
      "url": "https://snapchat.com/t/UZCSOtvd"
    },
    {
      "name": "Cap",
      "image": "assets/accessories/acsix.jpg",
      "url": "https://snapchat.com/t/pqFse2Di"
    },
    {
      "name": "Bracelet2",
      "image": "assets/accessories/acseven.jpg",
      "url": "https://snapchat.com/t/ZKAcPhNJ"
    },
    {
      "name": "Belt",
      "image": "assets/accessories/aceight.jpg",
      "url": "https://snapchat.com/t/RvFygGrT"
    },
  ];

  void _showError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('عذرًا، لم نتمكن من فتح الرابط.')),
    );
  }

  Future<void> _launchInBrowser(Uri url, BuildContext context) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      _showError(context);
    }
  }

  Widget _buildAccessoriesGrid(FavCubit cubit) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: accessories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.62,
          ),
          itemBuilder: (context, index) {
            final acc = accessories[index];
            final isFav = cubit.isFavorite(acc);
            final isInCart = cubit.isInCart(acc);

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
                      acc["image"]!,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    acc["name"]!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  const Text("500", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
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
                              _launchInBrowser(Uri.parse(acc["url"]!), context);
                            },
                            child: const Text(
                              "Try On",
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          cubit.toggleFavorite(acc);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          isInCart ? Icons.shopping_cart : Icons.add_shopping_cart,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          cubit.toggleCart(acc);
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
      return const Center(child: Text('لا توجد عناصر حالياً'));
    }
    return SafeArea(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        padding: const EdgeInsets.only(bottom: 60),
        itemBuilder: (context, index) {
          final acc = items[index];
          return ListTile(
            leading: Image.asset(acc["image"]!, width: 50, height: 50),
            title: Text(acc["name"]!),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => onRemove(acc),
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
              const SnackBar(content: Text("تم الإضافة إلى المفضلة")),
            );
          } else if (state is RemovedSuccessfully) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("تم الإزالة من المفضلة")),
            );
          } else if (state is AddToCartSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("تمت الإضافة إلى السلة")),
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
            _buildAccessoriesGrid(cubit),
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
                "Accessories",
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
                BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "favourite"),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "cart"),
               // BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),

              ],
            ),
          );
        },
      ),
    );
  }
}
