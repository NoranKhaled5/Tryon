import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';


import '../../../profile/view_model/cubit.dart';
import '../../view_model/cubit.dart';

import '../../view_model/states.dart';
import 'done.dart';

class CheckOutScreenBody extends StatelessWidget {
  CheckOutScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) async {
        if (state is UpdateCartSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Add Successfully"),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = ProfileCubit.get(context);
        final profileData = cubit.showProfileModel?.data;
        ProfileCubit.get(context).GetProfile();
        return Scaffold(
          appBar: AppBar(
            title: Text('Checkout'),
          ),
          body: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildProfileItem('Name', profileData?.name, Icons.person),
                    buildProfileItem('Email', profileData?.email, Icons.email),
                    buildProfileItem('Phone', profileData?.phone, Icons.phone),
                    buildProfileItem('City', profileData?.city, Icons.location_city),

                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: CartCubit.get(context)
                      .showCartModel?.data?.cartItems?.length ?? 0,
                  itemBuilder: (context, index) {
                    final cart = CartCubit.get(context)
                        .showCartModel?.data?.cartItems?[index];

                    return Container(
                      margin: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16.0),
                        leading: Container(
                          width: 80.0,
                          height: 120.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              cart?.itemProductImage ??
                                  'https://img.freepik.com/free-photo/front-view-smiley-woman-with-fireworks_52683-98180.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          cart?.itemProductName ??
                              'Product Name not available',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,

                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price: \$${cart?.itemProductPrice ?? 'Price not available'}',
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 14.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Discounted Price: \$${cart?.itemProductPriceAfterDiscount ?? 'Price not available'}',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Quantity: ${cart?.itemQuantity}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Center(
                child: Container(
                  width: 312,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      primary: HexColor('#174068'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Price : ${CartCubit.get(context).showCartModel?.data?.total} ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Done()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green, // Customize the color for the Checkout button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Order Now',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        );
      },
    );
  }


  Widget buildProfileItem(String label, String? value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: HexColor("#174068"),
          ),
          SizedBox(width: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                value ?? 'Not available',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}