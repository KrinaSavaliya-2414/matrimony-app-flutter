import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          "About Us",
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const SizedBox(height: 15),

            // ================= LOGO =================

            Container(
              height: 110,
              width: 110,

              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,

                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, 5),
                  ),
                ],
              ),

              child: const Icon(
                Icons.favorite_rounded,
                color: Colors.deepPurple,
                size: 58,
              ),
            ),

            const SizedBox(height: 18),

            // ================= APP NAME =================

            const Text(
              "VivaahVerse",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "Find Your Perfect Life Partner",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 25),

            // ================= ABOUT CARD =================

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

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

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  const Row(
                    children: [

                      Icon(
                        Icons.info_outline_rounded,
                        color: Colors.deepPurple,
                        size: 27,
                      ),

                      SizedBox(width: 10),

                      Text(
                        "About VivaahVerse",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "VivaahVerse is a simple and user-friendly "
                        "matrimony application designed to help users "
                        "create and manage their profiles easily.",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Users can register their profile, view user "
                        "details, edit information, delete profiles "
                        "and add their favorite profiles for easy access.",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // ================= FEATURES CARD =================

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

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

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  const Row(
                    children: [

                      Icon(
                        Icons.star_outline_rounded,
                        color: Colors.deepPurple,
                        size: 27,
                      ),

                      SizedBox(width: 10),

                      Text(
                        "Key Features",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  featureItem(
                    Icons.person_add_alt_1_rounded,
                    "Add User",
                    "Create a new matrimony profile.",
                  ),

                  featureItem(
                    Icons.people_alt_rounded,
                    "User List",
                    "View and manage registered users.",
                  ),

                  featureItem(
                    Icons.edit_rounded,
                    "Edit User",
                    "Update user profile information.",
                  ),

                  featureItem(
                    Icons.delete_outline_rounded,
                    "Delete User",
                    "Remove an unwanted user profile.",
                  ),

                  featureItem(
                    Icons.favorite_rounded,
                    "Favorite User",
                    "Save profiles for quick access.",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ================= FOOTER =================

            const Text(
              "VivaahVerse",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Made with Flutter",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  // ================= FEATURE ITEM =================

  static Widget featureItem(
      IconData icon,
      String title,
      String description,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Container(
            height: 42,
            width: 42,

            decoration: BoxDecoration(
              color: Colors.deepPurple.withOpacity(0.10),
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              color: Colors.deepPurple,
              size: 21,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}