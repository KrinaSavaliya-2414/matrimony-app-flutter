import 'package:flutter/material.dart';

import 'user_data.dart';
import 'user_model.dart';
import 'user_detail.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  // ================= Age Calculation Logic =================

  int calculateAge(String dob) {
    try {
      final parts = dob.split('/');

      if (parts.length != 3) {
        return 0;
      }

      final birthDate = DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );

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

  // ================= SEARCH & FILTER =================

  String searchQuery = "";
  final TextEditingController searchController = TextEditingController();
  String selectedGenderFilter = "All";
  String selectedCityFilter = "All Cities";

  // ================= DELETE USER =================

  Future<void> deleteUser(int index) async {
    final user = UserData.users[index];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Delete User",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Are you sure you want to delete ${user.name}?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await UserData.deleteUser(user.id!);

                if (!mounted) return;

                setState(() {});

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "User deleted successfully",
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                "Delete",
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

  // ================= FAVORITE USER =================

  Future<void> toggleFavorite(int index) async {
    final user = UserData.users[index];

    user.isFavorite = !user.isFavorite;

    await UserData.updateUser(user);

    if (!mounted) return;

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          user.isFavorite
              ? "Added to Favorite"
              : "Removed from Favorite",
        ),
        backgroundColor: Colors.deepPurple,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // ================= EDIT USER =================

  void editUser(int index) {
    final user = UserData.users[index];

    final nameController =
    TextEditingController(text: user.name);

    final emailController =
    TextEditingController(text: user.email);

    final mobileController =
    TextEditingController(text: user.mobile);

    final dobController =
    TextEditingController(text: user.dob);

    final passwordController =
    TextEditingController(text: user.password);

    final confirmPasswordController =
    TextEditingController(text: user.password);

    String selectedGender = user.gender;
    String selectedCity = user.city;

    bool isPasswordHidden = true;
    bool isConfirmPasswordHidden = true;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                "Edit User",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    // ================= NAME =================

                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: Colors.deepPurple,
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // ================= EMAIL =================

                    TextField(
                      controller: emailController,
                      keyboardType:
                      TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.deepPurple,
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // ================= MOBILE =================

                    TextField(
                      controller: mobileController,
                      keyboardType:
                      TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Mobile",
                        prefixIcon: const Icon(
                          Icons.phone_outlined,
                          color: Colors.deepPurple,
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // ================= DOB =================

                    TextField(
                      controller: dobController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Date of Birth",
                        prefixIcon: const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.deepPurple,
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // ================= GENDER =================

                    DropdownButtonFormField<String>(
                      value: selectedGender,
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: "Gender",
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: Colors.deepPurple,
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "Male",
                          child: Text("Male"),
                        ),
                        DropdownMenuItem(
                          value: "Female",
                          child: Text("Female"),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() {
                            selectedGender = value;
                          });
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    // ================= CITY =================

                    DropdownButtonFormField<String>(
                      value: selectedCity,
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: "City",
                        prefixIcon: const Icon(
                          Icons.location_city_outlined,
                          color: Colors.deepPurple,
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "Rajkot",
                          child: Text("Rajkot"),
                        ),
                        DropdownMenuItem(
                          value: "Ahmedabad",
                          child: Text("Ahmedabad"),
                        ),
                        DropdownMenuItem(
                          value: "Surat",
                          child: Text("Surat"),
                        ),
                        DropdownMenuItem(
                          value: "Vadodara",
                          child: Text("Vadodara"),
                        ),
                        DropdownMenuItem(
                          value: "Jamnagar",
                          child: Text("Jamnagar"),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() {
                            selectedCity = value;
                          });
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    // ================= PASSWORD =================

                    TextField(
                      controller: passwordController,
                      obscureText: isPasswordHidden,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Colors.deepPurple,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setDialogState(() {
                              isPasswordHidden =
                              !isPasswordHidden;
                            });
                          },
                          icon: Icon(
                            isPasswordHidden
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // ================= CONFIRM PASSWORD =================

                    TextField(
                      controller:
                      confirmPasswordController,
                      obscureText:
                      isConfirmPasswordHidden,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Colors.deepPurple,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setDialogState(() {
                              isConfirmPasswordHidden =
                              !isConfirmPasswordHidden;
                            });
                          },
                          icon: Icon(
                            isConfirmPasswordHidden
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ================= ACTIONS =================

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.trim().isEmpty ||
                        emailController.text.trim().isEmpty ||
                        mobileController.text.trim().isEmpty ||
                        passwordController.text.isEmpty ||
                        confirmPasswordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please fill all fields.",
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );

                      return;
                    }

                    if (passwordController.text.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Password must contain at least 6 characters.",
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );

                      return;
                    }

                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Passwords do not match.",
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );

                      return;
                    }

                    // ================= UPDATED USER =================

                    final updatedUser = UserModel(
                      id: user.id,
                      name: nameController.text.trim(),
                      email: emailController.text.trim(),
                      mobile: mobileController.text.trim(),
                      dob: dobController.text.trim(),
                      gender: selectedGender,
                      city: selectedCity,
                      password: passwordController.text,
                      isFavorite: user.isFavorite,
                    );

                    // ================= DATABASE UPDATE =================

                    await UserData.updateUser(updatedUser);

                    if (!mounted) return;

                    setState(() {});

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "User updated successfully",
                        ),
                        backgroundColor: Colors.deepPurple,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Text(
                    "Update",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ================= USER CARD =================

  Widget userCard(
      UserModel user,
      int index,
      ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetailScreen(
              user: user,
              index: index,
              onEdit: () {
                Navigator.pop(context);
                editUser(index);
              },
            ),
          ),
        ).then((_) {
          setState(() {});
        });
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
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
              // ================= TOP =================

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
                            Expanded(
                              child: Text(
                                user.city,
                                overflow:
                                TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // ================= FAVORITE =================

                  IconButton(
                    onPressed: () {
                      toggleFavorite(index);
                    },
                    icon: Icon(
                      user.isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: user.isFavorite
                          ? Colors.red
                          : Colors.grey,
                      size: 28,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              const Divider(),

              const SizedBox(height: 8),

              // ================= DETAILS =================

              detailRow(
                Icons.email_outlined,
                user.email,
              ),

              const SizedBox(height: 8),

              detailRow(
                Icons.phone_outlined,
                user.mobile,
              ),

              const SizedBox(height: 8),

              detailRow(
                Icons.cake_outlined,
                user.dob,
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(
                    Icons.person_pin_outlined,
                    size: 18,
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "${calculateAge(user.dob)} years",
                  ),
                ],
              ),

              const SizedBox(height: 8),

              detailRow(
                Icons.person_outline,
                user.gender,
              ),

              const SizedBox(height: 15),

              // ================= BUTTONS =================

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        editUser(index);
                      },
                      icon: const Icon(
                        Icons.edit_outlined,
                        size: 19,
                      ),
                      label: const Text("Edit"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor:
                        Colors.deepPurple,
                        side: const BorderSide(
                          color: Colors.deepPurple,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        deleteUser(index);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        size: 19,
                      ),
                      label: const Text("Delete"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(
                          color: Colors.red,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
            overflow: TextOverflow.ellipsis,
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
          "User List",
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

      body: UserData.users.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: Colors.deepPurple
                    .withOpacity(0.10),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.people_outline_rounded,
                size: 50,
                color: Colors.deepPurple,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "No Users Available",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Add a user to see them here.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ],
        ),
      )
          : Column(
        children: [
          // ================= SEARCH BAR =================

          Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              10,
            ),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery =
                      value.toLowerCase().trim();
                });
              },
              decoration: InputDecoration(
                hintText:
                "Search by name, city, age, email or phone",

                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: Colors.deepPurple,
                ),

                suffixIcon:
                searchQuery.isNotEmpty
                    ? IconButton(
                  onPressed: () {
                    searchController.clear();

                    setState(() {
                      searchQuery = "";
                    });
                  },
                  icon: const Icon(
                    Icons.clear_rounded,
                    color: Colors.grey,
                  ),
                )
                    : null,

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(15),
                  borderSide:
                  const BorderSide(
                    color: Colors.deepPurple,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),

          // ================= FILTERS =================

          Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              0,
              20,
              10,
            ),
            child: Row(
              children: [
                // ================= GENDER =================

                Expanded(
                  child:
                  DropdownButtonFormField<String>(
                    value: selectedGenderFilter,
                    isExpanded: true,

                    decoration: InputDecoration(
                      labelText: "Gender",

                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: Colors.deepPurple,
                        size: 20,
                      ),

                      filled: true,
                      fillColor: Colors.white,

                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(14),
                        borderSide:
                        BorderSide.none,
                      ),

                      enabledBorder:
                      OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(14),
                        borderSide:
                        BorderSide.none,
                      ),

                      focusedBorder:
                      OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(14),
                        borderSide:
                        const BorderSide(
                          color: Colors.deepPurple,
                          width: 1.5,
                        ),
                      ),
                    ),

                    items: const [
                      DropdownMenuItem(
                        value: "All",
                        child: Text("All"),
                      ),
                      DropdownMenuItem(
                        value: "Male",
                        child: Text("Male"),
                      ),
                      DropdownMenuItem(
                        value: "Female",
                        child: Text("Female"),
                      ),
                    ],

                    onChanged: (value) {
                      setState(() {
                        selectedGenderFilter =
                            value ?? "All";
                      });
                    },
                  ),
                ),

                const SizedBox(width: 10),

                // ================= CITY =================

                Expanded(
                  child:
                  DropdownButtonFormField<String>(
                    value: selectedCityFilter,
                    isExpanded: true,

                    decoration: InputDecoration(
                      labelText: "City",

                      prefixIcon: const Icon(
                        Icons.location_city_outlined,
                        color: Colors.deepPurple,
                        size: 20,
                      ),

                      prefixIconConstraints:
                      const BoxConstraints(
                        minWidth: 38,
                        minHeight: 0,
                      ),

                      filled: true,
                      fillColor: Colors.white,

                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(14),
                        borderSide:
                        BorderSide.none,
                      ),

                      enabledBorder:
                      OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(14),
                        borderSide:
                        BorderSide.none,
                      ),

                      focusedBorder:
                      OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(14),
                        borderSide:
                        const BorderSide(
                          color: Colors.deepPurple,
                          width: 1.5,
                        ),
                      ),
                    ),

                    items: const [
                      DropdownMenuItem(
                        value: "All Cities",
                        child: Text("All"),
                      ),
                      DropdownMenuItem(
                        value: "Rajkot",
                        child: Text("Rajkot"),
                      ),
                      DropdownMenuItem(
                        value: "Ahmedabad",
                        child: Text("Ahmedabad"),
                      ),
                      DropdownMenuItem(
                        value: "Surat",
                        child: Text("Surat"),
                      ),
                      DropdownMenuItem(
                        value: "Vadodara",
                        child: Text("Vadodara"),
                      ),
                      DropdownMenuItem(
                        value: "Jamnagar",
                        child: Text("Jamnagar"),
                      ),
                    ],

                    onChanged: (value) {
                      setState(() {
                        selectedCityFilter =
                            value ?? "All Cities";
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // ================= FILTERED USERS =================

          Expanded(
            child: Builder(
              builder: (context) {
                final filteredUsers =
                UserData.users.where(
                      (user) {
                    final name =
                    user.name.toLowerCase();

                    final city =
                    user.city.toLowerCase();

                    final email =
                    user.email.toLowerCase();

                    final mobile =
                    user.mobile.toLowerCase();

                    final age =
                    calculateAge(
                      user.dob,
                    ).toString();

                    // ================= SEARCH =================

                    final matchesSearch =
                        name.contains(searchQuery) ||
                            city.contains(searchQuery) ||
                            age.contains(searchQuery) ||
                            email.contains(searchQuery) ||
                            mobile.contains(searchQuery);

                    // ================= GENDER FILTER =================

                    final matchesGender =
                        selectedGenderFilter == "All" ||
                            user.gender ==
                                selectedGenderFilter;

                    // ================= CITY FILTER =================

                    final matchesCity =
                        selectedCityFilter ==
                            "All Cities" ||
                            user.city ==
                                selectedCityFilter;

                    return matchesSearch &&
                        matchesGender &&
                        matchesCity;
                  },
                ).toList();

                // ================= NO RESULT =================

                if (filteredUsers.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple
                                .withOpacity(0.10),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.search_off_rounded,
                            size: 42,
                            color:
                            Colors.deepPurple,
                          ),
                        ),

                        const SizedBox(height: 18),

                        const Text(
                          "No User Found",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        const Text(
                          "Try changing your search or filters.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 15),

                        // ================= RESET FILTERS =================

                        OutlinedButton.icon(
                          onPressed: () {
                            setState(() {
                              searchQuery = "";
                              selectedGenderFilter =
                              "All";
                              selectedCityFilter =
                              "All Cities";
                            });
                          },
                          icon: const Icon(
                            Icons.refresh_rounded,
                          ),
                          label: const Text(
                            "Reset Filters",
                          ),
                          style:
                          OutlinedButton.styleFrom(
                            foregroundColor:
                            Colors.deepPurple,
                            side:
                            const BorderSide(
                              color:
                              Colors.deepPurple,
                            ),
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // ================= USER LIST =================

                return ListView.builder(
                  padding:
                  const EdgeInsets.fromLTRB(
                    20,
                    5,
                    20,
                    20,
                  ),
                  itemCount:
                  filteredUsers.length,
                  itemBuilder:
                      (context, index) {
                    final user =
                    filteredUsers[index];

                    final originalIndex =
                    UserData.users.indexOf(
                      user,
                    );

                    return userCard(
                      user,
                      originalIndex,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}