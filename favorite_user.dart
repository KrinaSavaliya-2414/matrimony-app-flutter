import 'package:flutter/material.dart';

import 'user_data.dart';
import 'user_model.dart';

class FavoriteUserScreen extends StatefulWidget {
  const FavoriteUserScreen({super.key});

  @override
  State<FavoriteUserScreen> createState() =>
      _FavoriteUserScreenState();
}

class _FavoriteUserScreenState extends State<FavoriteUserScreen> {

  // ================= REMOVE FAVORITE =================

  void removeFavorite(UserModel user) {
    setState(() {
      user.isFavorite = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Removed from Favorite"),
        backgroundColor: Colors.deepPurple,
        duration: Duration(seconds: 1),
      ),
    );
  }

  // ================= USER CARD =================

  Widget favoriteCard(UserModel user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            // ================= TOP SECTION =================

            Row(
              children: [

                Container(
                  height: 65,
                  width: 65,

                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF4527A0),
                        Color(0xFF7E57C2),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: 34,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Row(
                        children: [

                          const Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Colors.deepPurple,
                          ),

                          const SizedBox(width: 3),

                          Text(
                            user.city,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ================= FAVORITE BUTTON =================

                IconButton(
                  onPressed: () {
                    removeFavorite(user);
                  },

                  icon: const Icon(
                    Icons.favorite_rounded,
                    color: Colors.red,
                    size: 28,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            const Divider(),

            const SizedBox(height: 8),

            // ================= EMAIL =================

            detailRow(
              Icons.email_outlined,
              user.email,
            ),

            const SizedBox(height: 8),

            // ================= MOBILE =================

            detailRow(
              Icons.phone_outlined,
              user.mobile,
            ),

            const SizedBox(height: 8),

            // ================= DOB =================

            detailRow(
              Icons.cake_outlined,
              user.dob,
            ),

            const SizedBox(height: 8),

            // ================= GENDER =================

            detailRow(
              Icons.person_outline,
              user.gender,
            ),
          ],
        ),
      ),
    );
  }

  // ================= DETAIL ROW =================

  Widget detailRow(
      IconData icon,
      String text,
      ) {
    return Row(
      children: [

        Icon(
          icon,
          color: Colors.deepPurple,
          size: 20,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {

    final favoriteUsers = UserData.users
        .where((user) => user.isFavorite)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      // ================= APP BAR =================

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          "Favorite Users",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),

        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF4527A0),
                Color(0xFF7E57C2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),

            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
        ),
      ),

      // ================= BODY =================

      body: favoriteUsers.isEmpty

          ? Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Container(
              height: 90,
              width: 90,

              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.10),
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.favorite_border_rounded,
                size: 50,
                color: Colors.red,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "No Favorite Users",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Add users to your favorites.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ],
        ),
      )

          : ListView.builder(
        padding: const EdgeInsets.all(20),

        itemCount: favoriteUsers.length,

        itemBuilder: (context, index) {
          final user = favoriteUsers[index];

          return favoriteCard(user);
        },
      ),
    );
  }
}