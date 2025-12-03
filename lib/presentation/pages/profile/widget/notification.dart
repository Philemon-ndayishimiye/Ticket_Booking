import 'package:flutter/material.dart';
class ProfileSettingCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  const ProfileSettingCard({
    Key? key,
    required this.title,
    required this.icon,
    this.initialValue = false,
    this.onChanged,
  }) : super(key: key);

  @override
  State<ProfileSettingCard> createState() => _ProfileSettingCardState();
}

class _ProfileSettingCardState extends State<ProfileSettingCard> {
  late bool _isOn;

  @override
  void initState() {
    super.initState();
    _isOn = widget.initialValue;
  }

  void _toggleSwitch(bool value) {
    setState(() {
      _isOn = value;
      widget.onChanged?.call(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _toggleSwitch(!_isOn),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(widget.icon, size: 30),
            Text(widget.title, style: const TextStyle(fontSize: 16)),
            Switch(
              value: _isOn,
              onChanged: _toggleSwitch,
            ),
          ],
        ),
      ),
    );
  }
}
