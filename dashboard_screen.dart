import 'package:flutter/material.dart';

import 'add_user.dart';
import 'user_data.dart';
import 'user_list.dart';
import 'favorite_user.dart';
import 'about_us.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // ================= STATISTICS =================

  int get totalUsers => UserData.users.length;

  int get favoriteUsers =>
      UserData.users.where((user) => user.isFavorite).length;

  int get maleUsers =>
      UserData.users.where((user) => user.gender == "Male").length;

  int get femaleUsers =>
      UserData.users.where((user) => user.gender == "Female").length;

  // ================= REFRESH DASHBOARD =================

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    setState(() {});
  }

  // ================= STATISTICS CARD =================

  Widget statisticsCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 26,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= DASHBOARD CARD =================

  Widget dashboardCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF4527A0),
                      Color(0xFF7E57C2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 28,
                ),
              ),

              const Spacer(),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      body: SafeArea(
        child: Column(
          children: [
            // ================= HEADER =================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                24,
                25,
                24,
                28,
              ),
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
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Row(
                children: [
                  // Logo

                  Container(
                    height: 58,
                    width: 58,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_rounded,
                      color: Colors.white,
                      size: 31,
                    ),
                  ),

                  const SizedBox(width: 15),

                  // Title

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "VivaahVerse",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          "Find Your Perfect Life Partner",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Favorite icon

                  Container(
                    height: 45,
                    width: 45,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border_rounded,
                      color: Colors.deepPurple,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            // ================= CONTENT =================

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  20,
                  20,
                  25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ================= WELCOME =================

                    const Text(
                      "Dashboard",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      "Manage your matrimony profiles easily.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ================= STATISTICS TITLE =================

                    const Text(
                      "Overview",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ================= STATISTICS GRID =================

                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      shrinkWrap: true,
                      physics:
                      const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.9,
                      children: [
                        statisticsCard(
                          title: "Total Users",
                          value: totalUsers.toString(),
                          icon: Icons.people_alt_rounded,
                          iconColor: Colors.deepPurple,
                        ),

                        statisticsCard(
                          title: "Favorites",
                          value: favoriteUsers.toString(),
                          icon: Icons.favorite_rounded,
                          iconColor: Colors.red,
                        ),

                        statisticsCard(
                          title: "Male",
                          value: maleUsers.toString(),
                          icon: Icons.male_rounded,
                          iconColor: Colors.blue,
                        ),

                        statisticsCard(
                          title: "Female",
                          value: femaleUsers.toString(),
                          icon: Icons.female_rounded,
                          iconColor: Colors.pink,
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // ================= QUICK ACTIONS =================

                    const Text(
                      "Quick Actions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ================= DASHBOARD GRID =================

                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      shrinkWrap: true,
                      physics:
                      const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.05,
                      children: [
                        // ================= ADD USER =================

                        dashboardCard(
                          icon: Icons.person_add_alt_1_rounded,
                          title: "Add User",
                          subtitle: "Create new profile",
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const AddUserScreen(),
                              ),
                            );

                            setState(() {});
                          },
                        ),

                        // ================= USER LIST =================

                        dashboardCard(
                          icon: Icons.people_alt_rounded,
                          title: "User List",
                          subtitle: "View all profiles",
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const UserListScreen(),
                              ),
                            );

                            setState(() {});
                          },
                        ),

                        // ================= FAVORITE =================

                        dashboardCard(
                          icon: Icons.favorite_rounded,
                          title: "Favorite User",
                          subtitle: "View favorites",
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const FavoriteUserScreen(),
                              ),
                            );

                            setState(() {});
                          },
                        ),

                        // ================= ABOUT =================

                        dashboardCard(
                          icon: Icons.info_outline_rounded,
                          title: "About Us",
                          subtitle: "About VivaahVerse",
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const AboutUsScreen(),
                              ),
                            );

                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}