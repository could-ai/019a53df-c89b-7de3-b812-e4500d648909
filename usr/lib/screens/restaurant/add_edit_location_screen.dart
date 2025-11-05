import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../services/location_service.dart';
import '../../models/location.dart';

class AddEditLocationScreen extends StatefulWidget {
  final LocationService locationService;
  final Location? location;

  const AddEditLocationScreen({
    super.key,
    required this.locationService,
    this.location,
  });

  @override
  State<AddEditLocationScreen> createState() => _AddEditLocationScreenState();
}

class _AddEditLocationScreenState extends State<AddEditLocationScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _latitudeController;
  late TextEditingController _longitudeController;
  bool _isBlocked = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.location?.name ?? '');
    _addressController = TextEditingController(text: widget.location?.address ?? '');
    _latitudeController = TextEditingController(text: widget.location?.latitude.toString() ?? '');
    _longitudeController = TextEditingController(text: widget.location?.longitude.toString() ?? '');
    _isBlocked = widget.location?.isBlocked ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  bool get _isEditing => widget.location != null;

  void _saveLocation() {
    if (_formKey.currentState!.validate()) {
      final location = Location(
        id: widget.location?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        address: _addressController.text.trim(),
        latitude: double.parse(_latitudeController.text.trim()),
        longitude: double.parse(_longitudeController.text.trim()),
        isBlocked: _isBlocked,
        restaurantId: 'rest1',
      );

      if (_isEditing) {
        widget.locationService.updateLocation(location);
      } else {
        widget.locationService.addLocation(location);
      }

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isEditing ? 'Location updated successfully' : 'Location added successfully'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Location' : 'Add Location'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Location Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_city),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter location name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.home),
              ),
              maxLines: 2,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _latitudeController,
              decoration: const InputDecoration(
                labelText: 'Latitude',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.place),
                hintText: 'e.g. 40.7128',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter latitude';
                }
                final lat = double.tryParse(value);
                if (lat == null || lat < -90 || lat > 90) {
                  return 'Please enter a valid latitude (-90 to 90)';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _longitudeController,
              decoration: const InputDecoration(
                labelText: 'Longitude',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.place),
                hintText: 'e.g. -74.0060',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter longitude';
                }
                final lon = double.tryParse(value);
                if (lon == null || lon < -180 || lon > 180) {
                  return 'Please enter a valid longitude (-180 to 180)';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Card(
              child: SwitchListTile(
                title: const Text('Block this location'),
                subtitle: const Text('Blocked locations won\'t receive orders'),
                value: _isBlocked,
                onChanged: (value) {
                  setState(() {
                    _isBlocked = value;
                  });
                },
                activeColor: Colors.red,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveLocation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                _isEditing ? 'Update Location' : 'Add Location',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}