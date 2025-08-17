import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/components/custom_buttons.dart';
import 'package:fasti_dashboard/core/providers/providers.dart';
import 'package:fasti_dashboard/core/router/router.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/cars/data/model/car_model.dart';
import 'package:fasti_dashboard/features/admin/cars/presentation/riverpod/cars_provider.dart';
import 'package:fasti_dashboard/widgets/content_view.dart';
import 'package:fasti_dashboard/widgets/page_header.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class CreateCarPage extends ConsumerStatefulWidget {
  const CreateCarPage({super.key});

  @override
  ConsumerState<CreateCarPage> createState() => _CreateCarPageState();
}

class _CreateCarPageState extends ConsumerState<CreateCarPage> {
  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _typeController = TextEditingController();
  final _seatsController = TextEditingController();
  final _priceController = TextEditingController();

  List<PlatformFile> _selectedImages = [];
  bool _isAvailable = true;
  bool _isLoading = false;
  bool _isUploadingImages = false;
  int _uploadProgress = 0;
  int _totalImages = 0;

  final List<String> _carTypes = [
    'Sedan',
    'SUV',
    'Hatchback',
    'Convertible',
    'Coupe',
    'Wagon',
    'Pickup',
    'Van',
    'Luxury',
    'Electric',
    'Hybrid',
  ];

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _typeController.dispose();
    _seatsController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        final imageUploadService = ref.read(imageUploadServiceProvider);
        final validImages = result.files.where((file) {
          return imageUploadService.isValidImageFile(file);
        }).toList();

        if (validImages.length != result.files.length) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Some files were skipped (invalid format or too large)'),
              backgroundColor: Colors.orange,
            ),
          );
        }

        if (validImages.isNotEmpty) {
          setState(() {
            _selectedImages.addAll(validImages);
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking images: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _clearAllImages() {
    setState(() {
      _selectedImages.clear();
    });
  }

  Future<void> _createCar() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one image'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _isUploadingImages = true;
      _uploadProgress = 0;
      _totalImages = _selectedImages.length;
    });

    try {
      // Generate car ID first
      final carId = const Uuid().v4();

      // Upload images to Firebase Storage
      final imageUploadService = ref.read(imageUploadServiceProvider);
      final imageUrls = await imageUploadService.uploadMultipleCarImages(
        files: _selectedImages,
        carId: carId,
        onProgress: (current, total) {
          setState(() {
            _uploadProgress = current;
            _totalImages = total;
          });
        },
      );

      setState(() {
        _isUploadingImages = false;
      });

      // Create CarModel object with uploaded image URLs
      final newCar = CarModel(
        id: carId,
        brand: _brandController.text.trim(),
        model: _modelController.text.trim(),
        type: _typeController.text.trim(),
        seats: int.parse(_seatsController.text.trim()),
        pricePerDay: double.parse(_priceController.text.trim()),
        imageUrl: imageUrls,
        isAvailable: _isAvailable,
        rentalPeriods: [], // Empty for new car
      );

      // Create car using the provider
      await ref.read(carsNotifierProvider.notifier).createCar(car: newCar);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Car created successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        CarsPageRoute().go(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create car: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isUploadingImages = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: ContentView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Header with Back Button
            Row(
              children: [
                IconButton(
                  onPressed: () => context.go('/admin/cars'),
                  icon: const Icon(Icons.arrow_back),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: PageHeader(
                    title: 'Create New Car',
                    description: 'Add a new car to the rental inventory.',
                  ),
                ),
              ],
            ),
            const Gap(24),

            // Form Card
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Basic Information Section
                          CommonText.textBoldWeight700(
                            text: 'Basic Information',
                            fontSize: 18,
                          ),
                          const Gap(16),

                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _brandController,
                                  decoration: const InputDecoration(
                                    labelText: 'Brand *',
                                    hintText: 'e.g., Toyota, BMW, Mercedes',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Brand is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  controller: _modelController,
                                  decoration: const InputDecoration(
                                    labelText: 'Model *',
                                    hintText: 'e.g., Camry, X5, C-Class',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Model is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Gap(16),

                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: _typeController.text.isEmpty
                                      ? null
                                      : _typeController.text,
                                  decoration: const InputDecoration(
                                    labelText: 'Type *',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: _carTypes.map((type) {
                                    return DropdownMenuItem(
                                      value: type,
                                      child: Text(type),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _typeController.text = value ?? '';
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Type is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  controller: _seatsController,
                                  decoration: const InputDecoration(
                                    labelText: 'Number of Seats *',
                                    hintText: 'e.g., 4, 5, 7',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Number of seats is required';
                                    }
                                    final seats = int.tryParse(value);
                                    if (seats == null ||
                                        seats < 1 ||
                                        seats > 50) {
                                      return 'Please enter a valid number of seats (1-50)';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Gap(16),

                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _priceController,
                                  decoration: const InputDecoration(
                                    labelText: 'Price per Day (MRU) *',
                                    hintText: 'e.g., 150.00',
                                    border: OutlineInputBorder(),
                                    prefixText: 'MRU ',
                                  ),
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+\.?\d{0,2}')),
                                  ],
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Price is required';
                                    }
                                    final price = double.tryParse(value);
                                    if (price == null || price <= 0) {
                                      return 'Please enter a valid price';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: _isAvailable,
                                      onChanged: (value) {
                                        setState(() {
                                          _isAvailable = value ?? true;
                                        });
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    CommonText.textBoldWeight500(
                                      text: 'Available for rental',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const Gap(32),

                          // Images Section
                          CommonText.textBoldWeight700(
                            text: 'Car Images',
                            fontSize: 18,
                          ),
                          const Gap(16),

                          // Image Upload Button
                          Row(
                            children: [
                              ElevatedButton.icon(
                                onPressed: _isLoading ? null : _pickImages,
                                icon: const Icon(Icons.add_photo_alternate),
                                label: const Text('Select Images'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Palette.mainDarkColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              if (_selectedImages.isNotEmpty) ...[
                                Text(
                                  '${_selectedImages.length} image(s) selected',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                TextButton.icon(
                                  onPressed:
                                      _isLoading ? null : _clearAllImages,
                                  icon: const Icon(Icons.clear,
                                      color: Colors.red),
                                  label: const Text(
                                    'Clear All',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ],
                          ),

                          // Upload Progress
                          if (_isUploadingImages) ...[
                            const Gap(16),
                            Card(
                              color: Colors.blue[50],
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2),
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          'Uploading images... ($_uploadProgress/$_totalImages)',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    LinearProgressIndicator(
                                      value: _totalImages > 0
                                          ? _uploadProgress / _totalImages
                                          : 0,
                                      backgroundColor: Colors.grey[300],
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Palette.mainDarkColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],

                          // Selected Images Preview
                          if (_selectedImages.isNotEmpty &&
                              !_isUploadingImages) ...[
                            const Gap(16),
                            CommonText.textBoldWeight600(
                              text: 'Selected Images:',
                            ),
                            const Gap(8),
                            SizedBox(
                              height: 120,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _selectedImages.length,
                                itemBuilder: (context, index) {
                                  final file = _selectedImages[index];
                                  return Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 8),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.grey[300]!),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: file.bytes != null
                                                ? Image.memory(
                                                    file.bytes!,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Container(
                                                    color: Colors.grey[200],
                                                    child:
                                                        const Icon(Icons.image),
                                                  ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 4,
                                          right: 4,
                                          child: GestureDetector(
                                            onTap: () => _removeImage(index),
                                            child: Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.close,
                                                size: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 4,
                                          left: 4,
                                          right: 4,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              '${(file.size / (1024 * 1024)).toStringAsFixed(1)}MB',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],

                          const Gap(32),

                          // Action Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: _isLoading
                                    ? null
                                    : () => context.go('/admin/cars'),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Palette.redColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              CustomButtons.simpleButton(
                                width: 150,
                                text: _isUploadingImages
                                    ? 'Uploading...'
                                    : 'Create Car',
                                isLoading: _isLoading,
                                onPressed: _isLoading ? null : _createCar,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
