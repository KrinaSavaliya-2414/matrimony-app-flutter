import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'user_data.dart';
import 'user_model.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? selectedGender;
  String? selectedCity;

  bool genderError = false;

  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    dobController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // ================= INPUT DECORATION =================

  InputDecoration fieldDecoration({
    required String hintText,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,

      prefixIcon: Icon(icon, color: Colors.deepPurple),

      suffixIcon: suffixIcon,

      filled: true,
      fillColor: Colors.white,

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.deepPurple),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.red),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }

  // ================= FIELD TITLE =================

  Widget fieldTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  // ================= CALCULATE AGE =================

  int calculateAge(DateTime birthDate) {
    final today = DateTime.now();

    int age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
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
          "Add User",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),

        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4527A0), Color(0xFF7E57C2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),

            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
        ),
      ),

      // ================= BODY =================
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },

        child: SingleChildScrollView(
          child: Form(
            key: _formKey,

            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                children: [
                  const SizedBox(height: 25),

                  // ================= PROFILE ICON =================
                  Center(
                    child: Container(
                      height: 90,
                      width: 90,

                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),

                      child: const Icon(
                        Icons.person_rounded,
                        color: Colors.deepPurple,
                        size: 45,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Add User",
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Create Your Matrimony Profile",
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ================= FULL NAME =================
                  fieldTitle("Full Name"),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: nameController,

                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                    ],

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter your full name.";
                      }

                      if (value.trim().length < 3) {
                        return "Name must contain at least 3 characters.";
                      }

                      return null;
                    },

                    decoration: fieldDecoration(
                      hintText: "Enter your full name",
                      icon: Icons.person_outline,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ================= EMAIL =================
                  fieldTitle("Email Address"),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: emailController,

                    keyboardType: TextInputType.emailAddress,

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter your email address.";
                      }

                      final emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                      );

                      if (!emailRegex.hasMatch(value.trim())) {
                        return "Enter a valid email address.";
                      }

                      return null;
                    },

                    decoration: fieldDecoration(
                      hintText: "Enter your email address",
                      icon: Icons.email_outlined,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ================= MOBILE NUMBER =================
                  fieldTitle("Mobile Number"),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: mobileController,

                    keyboardType: TextInputType.phone,

                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter your mobile number.";
                      }

                      if (value.length != 10) {
                        return "Enter a valid 10 digit mobile number.";
                      }

                      return null;
                    },

                    decoration: fieldDecoration(
                      hintText: "Enter your mobile number",
                      icon: Icons.phone_outlined,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ================= DATE OF BIRTH =================
                  fieldTitle("Date of Birth"),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: dobController,

                    readOnly: true,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select your date of birth.";
                      }

                      return null;
                    },

                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,

                        initialDate: DateTime(DateTime.now().year - 25),

                        firstDate: DateTime(
                          DateTime.now().year - 80,
                          DateTime.now().month,
                          DateTime.now().day,
                        ),

                        lastDate: DateTime(
                          DateTime.now().year - 18,
                          DateTime.now().month,
                          DateTime.now().day,
                        ),
                      );

                      if (pickedDate != null) {
                        int age = calculateAge(pickedDate);

                        if (age < 18 || age > 80) {
                          dobController.clear();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Age must be between 18 and 80 years.",
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );

                          return;
                        }

                        dobController.text =
                            "${pickedDate.day.toString().padLeft(2, '0')}/"
                            "${pickedDate.month.toString().padLeft(2, '0')}/"
                            "${pickedDate.year}";

                        setState(() {});
                      }
                    },

                    decoration: fieldDecoration(
                      hintText: "Select your date of birth",
                      icon: Icons.calendar_month_outlined,

                      suffixIcon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ================= GENDER =================
                  fieldTitle("Gender"),

                  const SizedBox(height: 8),

                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    clipBehavior: Clip.antiAlias,

                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),

                        border: Border.all(
                          color: genderError ? Colors.red : Colors.deepPurple,
                        ),
                      ),

                      child: Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              contentPadding: EdgeInsets.zero,

                              title: const Text("Male"),

                              value: "Male",

                              groupValue: selectedGender,

                              activeColor: Colors.deepPurple,

                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value;
                                  genderError = false;
                                });
                              },
                            ),
                          ),

                          Expanded(
                            child: RadioListTile<String>(
                              contentPadding: EdgeInsets.zero,

                              title: const Text("Female"),

                              value: "Female",

                              groupValue: selectedGender,

                              activeColor: Colors.deepPurple,

                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value;
                                  genderError = false;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (genderError)
                    const Padding(
                      padding: EdgeInsets.only(top: 5, left: 5),

                      child: Align(
                        alignment: Alignment.centerLeft,

                        child: Text(
                          "Please select your gender.",

                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),

                  // ================= CITY =================
                  fieldTitle("City"),

                  const SizedBox(height: 8),

                  DropdownButtonFormField<String>(
                    value: selectedCity,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select your city.";
                      }

                      return null;
                    },

                    decoration: fieldDecoration(
                      hintText: "Select your city",
                      icon: Icons.location_city_outlined,
                    ),

                    items: const [
                      DropdownMenuItem(value: "Rajkot", child: Text("Rajkot")),

                      DropdownMenuItem(
                        value: "Ahmedabad",
                        child: Text("Ahmedabad"),
                      ),

                      DropdownMenuItem(value: "Surat", child: Text("Surat")),

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
                        selectedCity = value;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  // ================= PASSWORD =================
                  fieldTitle("Password"),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: passwordController,

                    obscureText: isPasswordHidden,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password.";
                      }

                      if (value.length < 6) {
                        return "Password must contain at least 6 characters.";
                      }

                      return null;
                    },

                    decoration: fieldDecoration(
                      hintText: "Enter your password",
                      icon: Icons.lock_outline,

                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordHidden
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey,
                        ),

                        onPressed: () {
                          setState(() {
                            isPasswordHidden = !isPasswordHidden;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ================= CONFIRM PASSWORD =================
                  fieldTitle("Confirm Password"),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: confirmPasswordController,

                    obscureText: isConfirmPasswordHidden,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm your password.";
                      }

                      if (value != passwordController.text) {
                        return "Passwords do not match.";
                      }

                      return null;
                    },

                    decoration: fieldDecoration(
                      hintText: "Re-enter your password",
                      icon: Icons.lock_outline,

                      suffixIcon: IconButton(
                        icon: Icon(
                          isConfirmPasswordHidden
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey,
                        ),

                        onPressed: () {
                          setState(() {
                            isConfirmPasswordHidden = !isConfirmPasswordHidden;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ================= REGISTER BUTTON =================
                  SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(
                      onPressed: () async{
                        // Gender validation
                        if (selectedGender == null) {
                          setState(() {
                            genderError = true;
                          });
                        } else {
                          setState(() {
                            genderError = false;
                          });
                        }

                        // Form validation
                        bool isFormValid = _formKey.currentState!.validate();

                        if (!isFormValid || selectedGender == null) {
                          return;
                        }

                        // ================= SAVE USER =================

                        await UserData.addUser(
                          UserModel(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            mobile: mobileController.text.trim(),
                            dob: dobController.text.trim(),
                            gender: selectedGender!,
                            city: selectedCity!,
                            password: passwordController.text,
                          ),
                        );

                        // ================= SUCCESS MESSAGE =================

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("User Registered Successfully"),
                            backgroundColor: Colors.deepPurple,
                          ),
                        );

                        // Go back to Dashboard
                        Navigator.pop(context);
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),

                      child: const Text(
                        "Register",

                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}