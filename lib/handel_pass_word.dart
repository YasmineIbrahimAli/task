import 'package:flutter/material.dart';
import 'package:forget_pass_word/password_veraction.dart';

class HandelPassWord extends StatefulWidget {
  const HandelPassWord({super.key});
  @override
  State<HandelPassWord> createState() => _HandelPassWordState();
}

class _HandelPassWordState extends State<HandelPassWord> {
  late TextEditingController _oldPassword;
  late TextEditingController _newPassword;
  late TextEditingController _confirmPassword;

  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final String currentPassword = "Yasmin";
  String? _errorMessage;
  Color _messageColor = Colors.red;
  bool _hasLower = false;
  bool _hasUpper = false;
  bool _hasSpecial = false;
  bool _hasNumeric = false;
  bool _hasMinLength = false;

  @override
  void initState() {
    super.initState();
    _oldPassword = TextEditingController();
    _newPassword = TextEditingController();
    _confirmPassword = TextEditingController();
    _newPassword.addListener(_checkPasswordConditions);
  }

  @override
  void dispose() {
    _oldPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  bool _isPasswordValid() {
    return _hasLower &&
        _hasUpper &&
        _hasSpecial &&
        _hasNumeric &&
        _hasMinLength;
  }

  void _checkPasswordConditions() {
    String password = _newPassword.text;
    setState(() {
      _hasLower = password.contains(RegExp(r'[a-z]'));
      _hasUpper = password.contains(RegExp(r'[A-Z]'));
      _hasSpecial = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      _hasNumeric = password.contains(RegExp(r'[0-9]'));
      _hasMinLength = password.length >= 8;
    });
  }

  void _handleSavePassword() {
    setState(() {
      _errorMessage = null;
    });

    if (_oldPassword.text != currentPassword) {
      setState(() {
        _errorMessage = "Old password is incorrect.";
        _messageColor = Colors.red;
      });
      return;
    }

    if (_newPassword.text != _confirmPassword.text) {
      setState(() {
        _errorMessage = "New passwords do not match.";
        _messageColor = Colors.red;
      });
      return;
    }

    if (!_isPasswordValid()) {
      setState(() {
        _errorMessage = "Password does not achieve requirements.";
        _messageColor = Colors.red;
      });
      return;
    }

    setState(() {
      _errorMessage = "Password successfully changed ^--^";
      _messageColor = Colors.green;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Change Password",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        leading: const Icon(
          Icons.arrow_back_sharp,
          size: 24,
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Change Password',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _oldPassword,
                decoration: InputDecoration(
                  hintText: ' old password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isOldPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _isOldPasswordVisible = !_isOldPasswordVisible;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
                obscureText: !_isOldPasswordVisible,
              ),
              const SizedBox(height: 24),
              const Text(
                'Enter Your New Password',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _newPassword,
                decoration: InputDecoration(
                  hintText: ' New password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isNewPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _isNewPasswordVisible = !_isNewPasswordVisible;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
                obscureText: !_isNewPasswordVisible,
              ),
              const SizedBox(height: 24),
              const Text(
                'Password Must:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              PasswordVeraction('Include lower', _hasLower),
              PasswordVeraction('Upper lower', _hasUpper),
              PasswordVeraction(
                  'Include at least one special character', _hasSpecial),
              PasswordVeraction('Include numeric character', _hasNumeric),
              PasswordVeraction(
                  'Minimum password length 8 characters', _hasMinLength),
              const SizedBox(height: 24),
              const Text(
                'Confirm New Password',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPassword,
                decoration: InputDecoration(
                  hintText: 'Confirmation  ',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
                obscureText: !_isConfirmPasswordVisible,
              ),
              const SizedBox(height: 24),
              if (_errorMessage != null) ...[
                Text(
                  _errorMessage!,
                  style: TextStyle(color: _messageColor),
                ),
                const SizedBox(height: 16),
              ],
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _handleSavePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
