import 'package:flutter/material.dart';

import 'user_data.dart';
import 'user_model.dart';

class UserDetailScreen extends StatefulWidget {
  final UserModel user;
  final int index;
  final VoidCallback? onEdit;

  const UserDetailScreen({
    super.key,
    required this.user,
    required this.index,
    this.onEdit,
  });

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  // ================= CALCULATE AGE =================

  int calculateAge(String dob) {
    try {
      final parts = dob.split('/');

      if (parts.length != 3) {
        return 0;
      }

      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      final birthDate = DateTime(year, month, day);
      final today = DateTime.now();

      int age = today.year - birthDate.year;

      if (today.month < birthDate.month ||
          (today.month == birthDate.month &&
              today.day < birthDate.day)) {
        age--;
      }

      return age;
    } catch (e) {
      return 0;
    }
  }

  // ================= FAVORITE =================

  void toggleFavorite() {
    setState(() {
      widget.user.isFavorite = !widget.user.isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.user.isFavorite
              ? "Added to Favorite"
              : "Removed from Favorite",
        ),
        backgroundColor: Colors.deepPurple,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // ================= DELETE =================

  void deleteUser() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Are you sure want to delete this user?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "This will permanently remove ${widget.user.name}.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "No",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                UserData.users.removeAt(widget.index);

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("User deleted successfully"),
                    backgroundColor: Colors.red,
                  ),
                );

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                "Yes",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ================= DETAIL ROW =================

  Widget detailRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
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

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    final age = calculateAge(user.dob);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      // ================= APP BAR =================

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
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
          "User Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ================= BODY =================

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            // ================= PROFILE HEADER =================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 25,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF311B92),
                    Color(0xFF7E57C2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Container(
                    height: 82,
                    width: 82,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: Colors.deepPurple,
                      size: 48,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Text(
                    user.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white70,
                        size: 17,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        user.city,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ================= DETAILS =================

            detailRow(
              icon: Icons.person_outline,
              title: "Full Name",
              value: user.name,
            ),

            detailRow(
              icon: Icons.email_outlined,
              title: "Email Address",
              value: user.email,
            ),

            detailRow(
              icon: Icons.phone_outlined,
              title: "Mobile Number",
              value: user.mobile,
            ),

            detailRow(
              icon: Icons.calendar_month_outlined,
              title: "Date of Birth",
              value: user.dob,
            ),

            detailRow(
              icon: Icons.cake_outlined,
              title: "Age",
              value: "$age Years",
            ),

            detailRow(
              icon: Icons.location_city_outlined,
              title: "City",
              value: user.city,
            ),

            detailRow(
              icon: Icons.wc_outlined,
              title: "Gender",
              value: user.gender,
            ),

            const SizedBox(height: 8),

            // ================= ACTION BUTTONS =================

            Row(
              children: [
                // EDIT
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: widget.onEdit,
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Edit",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // FAVORITE
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: toggleFavorite,
                    icon: Icon(
                      user.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.white,
                    ),
                    label: Text(
                      user.isFavorite
                          ? "Unfavorite"
                          : "Favorite",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // DELETE
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: deleteUser,
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                label: const Text(
                  "Delete User",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  side: const BorderSide(
                    color: Colors.red,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}