import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/service.dart';
import '../models/zone.dart';
import '../models/booking.dart';
import '../providers/booking_provider.dart';

class ServiceDetailScreen extends StatefulWidget {
  final Service service;
  final Zone zone;

  const ServiceDetailScreen({
    super.key,
    required this.service,
    required this.zone,
  });

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedTimeSlot = '';
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    if (widget.service.availableTimeSlots.isNotEmpty) {
      selectedTimeSlot = widget.service.availableTimeSlots.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final price = widget.service.getPriceForZone(widget.zone.id);
    final totalPrice = price * quantity;

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: Text(widget.service.name, style: TextStyle(color: Colors.white)),

        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  _getServiceIcon(widget.service.name),
                  size: 100,
                  color: Colors.white,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.service.name,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '₹${price.toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    child: Text(widget.zone.name),
                  ),

                  const SizedBox(height: 20),

                  _sectionTitle('Description'),
                  Text(widget.service.description),

                  const SizedBox(height: 20),
                  _sectionTitle('Details'),
                  _buildDetailRow(
                    'Duration',
                    '${widget.service.durationMinutes} mins',
                  ),
                  _buildDetailRow(
                    'Availability',
                    widget.service.availableOnWeekends
                        ? 'Weekdays & Weekends'
                        : 'Weekdays only',
                  ),
                  _buildDetailRow(
                    'Time Slots',
                    widget.service.availableTimeSlots.join(', '),
                  ),

                  const SizedBox(height: 20),
                  _sectionTitle('Select Date'),
                  _buildDateSelector(),

                  const SizedBox(height: 20),
                  _sectionTitle('Select Time'),
                  _buildTimeSlotSelector(),

                  const SizedBox(height: 20),
                  _sectionTitle('Quantity'),
                  _buildQuantitySelector(),

                  const SizedBox(height: 30),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Price:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '₹${totalPrice.toStringAsFixed(0)}',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                            ),
                            ElevatedButton(
                              onPressed: _canBook() ? _bookService : null,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 14,
                                ),
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                              ),
                              child: const Text(
                                'Book Now',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('EEEE, MMMM d, y').format(selectedDate),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          IconButton(
            onPressed: () => _selectDate(context),
            icon: const Icon(Icons.calendar_today),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlotSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.service.availableTimeSlots.map((timeSlot) {
        final isSelected = selectedTimeSlot == timeSlot;
        return ChoiceChip(
          label: Text(timeSlot),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) {
              setState(() {
                selectedTimeSlot = timeSlot;
              });
            }
          },
        );
      }).toList(),
    );
  }

  Widget _buildQuantitySelector() {
    return Row(
      children: [
        IconButton(
          onPressed: quantity > 1 ? () => setState(() => quantity--) : null,
          icon: const Icon(Icons.remove),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            quantity.toString(),
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
          onPressed: () => setState(() => quantity++),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      selectableDayPredicate: (DateTime date) {
        if (!widget.service.availableOnWeekends) {
          return date.weekday >= 1 && date.weekday <= 5;
        }
        return true;
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  bool _canBook() => selectedTimeSlot.isNotEmpty && quantity > 0;

  void _bookService() {
    final price = widget.service.getPriceForZone(widget.zone.id);
    final totalPrice = price * quantity;

    final booking = Booking(
      serviceId: widget.service.id,
      serviceName: widget.service.name,
      zoneId: widget.zone.id,
      zoneName: widget.zone.name,
      date: selectedDate,
      timeSlot: selectedTimeSlot,
      quantity: quantity,
      totalPrice: totalPrice,
    );

    context.read<BookingProvider>().addBooking(booking);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.service.name} booked successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  IconData _getServiceIcon(String serviceName) {
    switch (serviceName.toLowerCase()) {
      case 'home cleaning':
        return Icons.cleaning_services;
      case 'plumbing service':
        return Icons.plumbing;
      case 'electrical work':
        return Icons.electrical_services;
      case 'garden maintenance':
        return Icons.eco;
      case 'interior painting':
        return Icons.format_paint;
      case 'carpentry work':
        return Icons.handyman;
      default:
        return Icons.miscellaneous_services;
    }
  }
}
