import 'package:flutter/material.dart';
import '../../services/location_service.dart';
import '../../models/location.dart';
import 'add_edit_location_screen.dart';

class LocationManagementScreen extends StatefulWidget {
  const LocationManagementScreen({super.key});

  @override
  State<LocationManagementScreen> createState() => _LocationManagementScreenState();
}

class _LocationManagementScreenState extends State<LocationManagementScreen> {
  final LocationService _locationService = LocationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _locationService,
        builder: (context, child) {
          final locations = _locationService.locations;

          if (locations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No locations added yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: locations.length,
            itemBuilder: (context, index) {
              return _buildLocationCard(locations[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditLocationScreen(
                locationService: _locationService,
              ),
            ),
          );
        },
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_location),
        label: const Text('Add Location'),
      ),
    );
  }

  Widget _buildLocationCard(Location location) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: location.isBlocked ? Colors.red.shade100 : Colors.green.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            location.isBlocked ? Icons.location_off : Icons.location_on,
            color: location.isBlocked ? Colors.red : Colors.green,
          ),
        ),
        title: Text(
          location.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(location.address),
            const SizedBox(height: 4),
            Text(
              location.isBlocked ? 'BLOCKED' : 'Active',
              style: TextStyle(
                color: location.isBlocked ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Block/Unblock Button
            IconButton(
              icon: Icon(
                location.isBlocked ? Icons.check_circle : Icons.block,
                color: location.isBlocked ? Colors.green : Colors.orange,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(location.isBlocked ? 'Unblock Location' : 'Block Location'),
                    content: Text(
                      location.isBlocked
                          ? 'Are you sure you want to unblock "${location.name}"?'
                          : 'Are you sure you want to block "${location.name}"?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          _locationService.toggleLocationBlock(location.id);
                          Navigator.pop(context);
                        },
                        child: Text(location.isBlocked ? 'Unblock' : 'Block'),
                      ),
                    ],
                  ),
                );
              },
            ),
            // Edit Button
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditLocationScreen(
                      locationService: _locationService,
                      location: location,
                    ),
                  ),
                );
              },
            ),
            // Delete Button
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Location'),
                    content: Text('Are you sure you want to delete "${location.name}"?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          _locationService.deleteLocation(location.id);
                          Navigator.pop(context);
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}