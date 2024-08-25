import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:payuung_pribadi/cubit/dropdown_cubit.dart';
import 'package:payuung_pribadi/cubit/image_cubit.dart';
import 'package:payuung_pribadi/cubit/master_data_cubit.dart';
import 'package:payuung_pribadi/models/user_model.dart';
import 'package:payuung_pribadi/services/user_service.dart';
import 'package:payuung_pribadi/views/widgets/custom_elevated_button.dart';
import 'package:payuung_pribadi/views/widgets/custom_text_form_field.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  final _formKey = GlobalKey<FormState>();
  final UserService _userService = UserService();
  final PageController _pageController = PageController();
  int _currentPage = 0;
  // Controllers
  late TextEditingController fullNameController;
  late TextEditingController birthDateController;
  late TextEditingController genderController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController educationController;
  late TextEditingController maritalStatusController;
  late TextEditingController ktpPathController;
  late TextEditingController nikController;
  late TextEditingController ktpAddressController;
  late TextEditingController ktpProvinceController;
  late TextEditingController ktpCityController;
  late TextEditingController ktpDistrictController;
  late TextEditingController ktpSubDistrictController;
  late TextEditingController ktpPostalCodeController;
  late TextEditingController domicileAddressController;
  late TextEditingController domicileProvinceController;
  late TextEditingController domicileCityController;
  late TextEditingController domicileDistrictController;
  late TextEditingController domicileSubDistrictController;
  late TextEditingController domicilePostalCodeController;
  late TextEditingController companyNameController;
  late TextEditingController companyAddressController;
  late TextEditingController jobTitleController;
  late TextEditingController yearsOfServiceController;
  late TextEditingController incomeSourceController;
  late TextEditingController annualGrossIncomeController;
  late TextEditingController bankNameController;
  late TextEditingController bankBranchController;
  late TextEditingController bankAccountNumberController;
  late TextEditingController accountHolderNameController;
  late TextEditingController formattedBirthDateController;

  void _goToPage(int page) {
    setState(() {
      _currentPage = page;
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _submitForm(UserModel user, String notifikasi) {
    if (_formKey.currentState!.validate()) {
      UserService().saveUser(user);

      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(notifikasi)),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    UserModel? user = _userService.getUser();
    fullNameController = TextEditingController(text: user?.fullName ?? '');
    birthDateController =
        TextEditingController(text: user?.birthDate.toString() ?? '');
    genderController = TextEditingController(text: user?.gender ?? '');
    emailController = TextEditingController(text: user?.email ?? '');
    phoneNumberController =
        TextEditingController(text: user?.phoneNumber ?? '');
    educationController = TextEditingController(text: user?.education ?? '');
    maritalStatusController =
        TextEditingController(text: user?.maritalStatus ?? '');
    ktpPathController = TextEditingController(text: user?.ktpPath ?? '');
    nikController = TextEditingController(text: user?.nik ?? '');
    ktpAddressController = TextEditingController(text: user?.ktpAddress ?? '');
    ktpProvinceController =
        TextEditingController(text: user?.ktpProvince ?? '');
    ktpCityController = TextEditingController(text: user?.ktpCity ?? '');
    ktpDistrictController =
        TextEditingController(text: user?.ktpDistrict ?? '');
    ktpSubDistrictController =
        TextEditingController(text: user?.ktpSubDistrict ?? '');
    ktpPostalCodeController =
        TextEditingController(text: user?.ktpPostalCode ?? '');
    domicileAddressController = TextEditingController(text: '');
    domicileProvinceController = TextEditingController(text: '');
    domicileCityController = TextEditingController(text: '');
    domicileDistrictController = TextEditingController(text: '');
    domicileSubDistrictController = TextEditingController(text: '');
    domicilePostalCodeController = TextEditingController(text: '');
    companyNameController =
        TextEditingController(text: user?.companyName ?? '');
    companyAddressController =
        TextEditingController(text: user?.companyAddress ?? '');
    jobTitleController = TextEditingController(text: user?.jobTitle ?? '');
    yearsOfServiceController =
        TextEditingController(text: user?.yearsOfService ?? '');
    incomeSourceController =
        TextEditingController(text: user?.incomeSource ?? '');
    annualGrossIncomeController =
        TextEditingController(text: user?.annualGrossIncome ?? '');
    bankNameController = TextEditingController(text: user?.bankName ?? '');
    bankBranchController = TextEditingController(text: user?.bankBranch ?? '');
    bankAccountNumberController =
        TextEditingController(text: user?.bankAccountNumber ?? '');
    accountHolderNameController =
        TextEditingController(text: user?.accountHolderName ?? '');

    final formattedDate =
        DateFormat('dd MMMM yyyy').format(user?.birthDate ?? DateTime.now());
    formattedBirthDateController = TextEditingController(text: formattedDate);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MasterDataCubit()..loadMasterData(),
      child: Scaffold(
        appBar:
            AppBar(centerTitle: true, title: const Text('Informasi Pribadi')),
        body: BlocBuilder<MasterDataCubit, MasterDataState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.errorMessage.isNotEmpty) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            }
            return Column(
              children: [
                // Header dengan stepper
                _buildStepper(),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: [
                      BlocProvider(
                        create: (context) => DropdownCubit(),
                        child: _buildBiodataDiriPage(
                          gender: state.jenisKelamin,
                          education: state.pendidikan,
                          maritalStatus: state.statusPernikahan,
                          namaController: fullNameController,
                          tanggalLahirController: birthDateController,
                          genderController: genderController,
                          emailController: emailController,
                          hpController: phoneNumberController,
                          pendidikanController: educationController,
                          statusNikahController: maritalStatusController,
                        ),
                      ),
                      BlocProvider(
                        create: (context) => ImageCubit()..loadSavedKTPImage(),
                        child: _buildAlamatPribadiPage(
                          nikController: nikController,
                          ktpAddressController: ktpAddressController,
                          ktpProvinceController: ktpProvinceController,
                          ktpCityController: ktpCityController,
                          ktpDistrictController: ktpDistrictController,
                          ktpSubDistrictController: ktpSubDistrictController,
                          ktpPostalCodeController: ktpPostalCodeController,
                        ),
                      ),
                      BlocProvider(
                        create: (context) => DropdownCubit(),
                        child: _buildInformasiPerusahaanPage(
                          jabatan: state.jabatan,
                          lamaBekerja: state.lamaBekerja,
                          sumberPendapatan: state.sumberPendapatan,
                          pendapatanKotor: state.pendapatanKotor,
                          companyNameController: companyNameController,
                          companyAddressController: companyAddressController,
                          bankNameController: bankNameController,
                          bankBranchController: bankBranchController,
                          bankAccountNumberController:
                              bankAccountNumberController,
                          accountHolderNameController:
                              accountHolderNameController,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStepper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStep(
          title: 'Biodata Diri',
          isActive: _currentPage == 0,
          onTap: () => _goToPage(0),
        ),
        _buildStep(
          title: 'Alamat\nPribadi',
          isActive: _currentPage == 1,
          onTap: () => _goToPage(1),
        ),
        _buildStep(
          title: 'Informasi\nPerusahaan',
          isActive: _currentPage == 2,
          onTap: () => _goToPage(2),
        ),
      ],
    );
  }

  // Widget untuk membuat step
  Widget _buildStep(
      {required String title,
      required bool isActive,
      required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: isActive ? Colors.amber : Colors.grey,
            child: Text(
              (title == 'Biodata Diri')
                  ? '1'
                  : (title == 'Alamat\nPribadi')
                      ? '2'
                      : '3',
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? Colors.amber : Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Halaman pertama: Biodata Diri
  Widget _buildBiodataDiriPage({
    required List<String> gender,
    required List<String> education,
    required List<String> maritalStatus,
    required TextEditingController namaController,
    required TextEditingController tanggalLahirController,
    required TextEditingController genderController,
    required TextEditingController emailController,
    required TextEditingController hpController,
    required TextEditingController pendidikanController,
    required TextEditingController statusNikahController,
  }) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              CustomTextFormField(
                hint: 'Nama Lengkap',
                textEditingController: namaController,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      namaController.text.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                readOnly: true,
                hint: 'Tanggal Lahir',
                textEditingController: formattedBirthDateController,
                suffix: IconButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2025),
                      );

                      if (pickedDate != null) {
                        setState(() {
                          tanggalLahirController.text = pickedDate.toString();
                          final formattedDate =
                              DateFormat('dd MMMM yyyy').format(pickedDate);
                          formattedBirthDateController.text = formattedDate;
                        });
                      }
                    },
                    icon: const Icon(Icons.date_range_outlined)),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      tanggalLahirController.text.isEmpty) {
                    return 'Tanggal lahir tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Jenis Kelamin"),
                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 0.1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: BlocBuilder<DropdownCubit, Map<String, String?>>(
                      builder: (context, state) {
                        return DropdownButton<String>(
                          underline: const SizedBox(),
                          isExpanded: true,
                          hint: Text(genderController.text.isNotEmpty
                              ? genderController.text
                              : "Pilih"),
                          value: state['gender'],
                          items: gender.map((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (value) {
                            print(value);
                            genderController.text = value ?? '';
                            context
                                .read<DropdownCubit>()
                                .selectItem('gender', value);
                            print(
                                'Ini controlller gender: ${genderController.text}');
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                hint: 'Alamat Email',
                textEditingController: emailController,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      emailController.text.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                hint: 'No. HP',
                textEditingController: hpController,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      hpController.text.isEmpty) {
                    return 'No. HP tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Pendidikan"),
                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 0.1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: BlocBuilder<DropdownCubit, Map<String, String?>>(
                      builder: (context, state) {
                        return DropdownButton<String>(
                          underline: const SizedBox(),
                          isExpanded: true,
                          hint: Text(educationController.text.isNotEmpty
                              ? educationController.text
                              : "Pilih"),
                          value: state['education'],
                          items: education.map((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (value) {
                            pendidikanController.text = value ?? '';
                            context
                                .read<DropdownCubit>()
                                .selectItem('education', value);
                            print(
                                'Ini controlller gender: ${educationController.text}');
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Status Pernikahan"),
                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 0.1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: BlocBuilder<DropdownCubit, Map<String, String?>>(
                      builder: (context, state) {
                        print(maritalStatusController.text);
                        return DropdownButton<String>(
                          underline: const SizedBox(),
                          isExpanded: true,
                          hint: Text(maritalStatusController.text.isNotEmpty
                              ? maritalStatusController.text
                              : "Pilih"),
                          value: state['maritalStatus'],
                          items: maritalStatus.map((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (value) {
                            statusNikahController.text = value ?? '';
                            context
                                .read<DropdownCubit>()
                                .selectItem('maritalStatus', value);
                            print(
                                'Ini controlller gender: ${maritalStatusController.text}');
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.amber,
                    surfaceTintColor: Colors.white,
                    elevation: 5, // Tingkat elevasi
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    _submitForm(
                        UserModel(
                          fullName: fullNameController.text,
                          birthDate: DateTime.parse(birthDateController.text),
                          gender: genderController.text,
                          email: emailController.text,
                          phoneNumber: phoneNumberController.text,
                          education: educationController.text,
                          maritalStatus: maritalStatusController.text,
                          ktpPath: ktpPathController.text,
                          nik: nikController.text,
                          ktpAddress: ktpAddressController.text,
                          ktpProvince: ktpProvinceController.text,
                          ktpCity: ktpCityController.text,
                          ktpDistrict: ktpDistrictController.text,
                          ktpSubDistrict: ktpSubDistrictController.text,
                          ktpPostalCode: ktpPostalCodeController.text,
                          domicileAddress: domicileAddressController.text,
                          domicileProvince: domicileProvinceController.text,
                          domicileCity: domicileCityController.text,
                          domicileDistrict: domicileDistrictController.text,
                          domicileSubDistrict:
                              domicileSubDistrictController.text,
                          domicilePostalCode: domicilePostalCodeController.text,
                          companyName: companyNameController.text,
                          companyAddress: companyAddressController.text,
                          jobTitle: jobTitleController.text,
                          yearsOfService: yearsOfServiceController.text,
                          incomeSource: incomeSourceController.text,
                          annualGrossIncome: annualGrossIncomeController.text,
                          bankName: bankNameController.text,
                          bankBranch: bankBranchController.text,
                          bankAccountNumber: bankAccountNumberController.text,
                          accountHolderName: accountHolderNameController.text,
                        ),
                        'Biodata berhasil disimpan');
                    _goToPage(1);
                  },
                  child: const Text('Selanjutnya'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Halaman kedua: Alamat Pribadi
  Widget _buildAlamatPribadiPage({
    required TextEditingController nikController,
    required TextEditingController ktpAddressController,
    required TextEditingController ktpProvinceController,
    required TextEditingController ktpCityController,
    required TextEditingController ktpDistrictController,
    required TextEditingController ktpSubDistrictController,
    required TextEditingController ktpPostalCodeController,
  }) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: BlocBuilder<ImageCubit, String?>(
            builder: (context, ktpPath) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (ktpPath != null)
                    Center(
                      child: Image.file(
                        File(ktpPath),
                        width: 200,
                        height: 200,
                      ),
                    )
                  else
                    const SizedBox(),
                  const SizedBox(height: 8),
                  CustomElevatedButton(
                    label: "Upload KTP",
                    icon: Icons.account_box_rounded,
                    padding: 0,
                    onPressed: () => _showImageSourceDialog(context),
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    hint: 'NIK',
                    textEditingController: nikController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          nikController.text.isEmpty) {
                        return 'NIK tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    hint: 'Alamat Sesuai KTP',
                    textEditingController: ktpAddressController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          ktpAddressController.text.isEmpty) {
                        return 'Alamat tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    hint: 'Provinsi',
                    textEditingController: ktpProvinceController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          ktpProvinceController.text.isEmpty) {
                        return 'Provinsi tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    hint: 'Kota/Kabupaten',
                    textEditingController: ktpCityController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          ktpCityController.text.isEmpty) {
                        return 'Kota/Kabupaten tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    hint: 'Kecamatan',
                    textEditingController: ktpDistrictController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          ktpDistrictController.text.isEmpty) {
                        return 'Kecamatan tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    hint: 'Kelurahan',
                    textEditingController: ktpSubDistrictController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          ktpSubDistrictController.text.isEmpty) {
                        return 'Kelurahan tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    hint: 'Kode POS',
                    textEditingController: ktpPostalCodeController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          ktpPostalCodeController.text.isEmpty) {
                        return 'Kode POS tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.amber,
                              ),
                              foregroundColor: Colors.amber,
                              backgroundColor: Colors.white,
                              surfaceTintColor: Colors.white,
                              elevation: 5, // Tingkat elevasi
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              _goToPage(0);
                            },
                            child: const Text('Sebelumnya'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.amber,
                              surfaceTintColor: Colors.white,
                              elevation: 5, // Tingkat elevasi
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              print(ktpPathController.text);
                              _submitForm(
                                  UserModel(
                                    fullName: fullNameController.text,
                                    birthDate: DateTime.parse(
                                        birthDateController.text),
                                    gender: genderController.text,
                                    email: emailController.text,
                                    phoneNumber: phoneNumberController.text,
                                    education: educationController.text,
                                    maritalStatus: maritalStatusController.text,
                                    ktpPath: ktpPathController.text,
                                    nik: nikController.text,
                                    ktpAddress: ktpAddressController.text,
                                    ktpProvince: ktpProvinceController.text,
                                    ktpCity: ktpCityController.text,
                                    ktpDistrict: ktpDistrictController.text,
                                    ktpSubDistrict:
                                        ktpSubDistrictController.text,
                                    ktpPostalCode: ktpPostalCodeController.text,
                                    domicileAddress:
                                        domicileAddressController.text,
                                    domicileProvince:
                                        domicileProvinceController.text,
                                    domicileCity: domicileCityController.text,
                                    domicileDistrict:
                                        domicileDistrictController.text,
                                    domicileSubDistrict:
                                        domicileSubDistrictController.text,
                                    domicilePostalCode:
                                        domicilePostalCodeController.text,
                                    companyName: companyNameController.text,
                                    companyAddress:
                                        companyAddressController.text,
                                    jobTitle: jobTitleController.text,
                                    yearsOfService:
                                        yearsOfServiceController.text,
                                    incomeSource: incomeSourceController.text,
                                    annualGrossIncome:
                                        annualGrossIncomeController.text,
                                    bankName: bankNameController.text,
                                    bankBranch: bankBranchController.text,
                                    bankAccountNumber:
                                        bankAccountNumberController.text,
                                    accountHolderName:
                                        accountHolderNameController.text,
                                  ),
                                  'Alamat Pribadi berhasil disimpan');
                              _goToPage(2);
                            },
                            child: const Text('Selanjutnya'),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // Halaman ketiga: Informasi Perusahaan
  Widget _buildInformasiPerusahaanPage({
    required List<String> jabatan,
    required List<String> lamaBekerja,
    required List<String> sumberPendapatan,
    required List<String> pendapatanKotor,
    required TextEditingController companyNameController,
    required TextEditingController companyAddressController,
    required TextEditingController bankNameController,
    required TextEditingController bankBranchController,
    required TextEditingController bankAccountNumberController,
    required TextEditingController accountHolderNameController,
  }) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              CustomTextFormField(
                hint: 'Nama Perusahaan',
                textEditingController: companyNameController,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                hint: 'Alamat Perusahaan',
                textEditingController: companyAddressController,
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Jabatan"),
                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 0.1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: BlocBuilder<DropdownCubit, Map<String, String?>>(
                      builder: (context, state) {
                        return DropdownButton<String>(
                          underline: const SizedBox(),
                          isExpanded: true,
                          hint: Text(jobTitleController.text.isNotEmpty
                              ? jobTitleController.text
                              : "Pilih"),
                          value: state['jabatan'],
                          items: jabatan.map((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (value) {
                            jobTitleController.text = value ?? '';
                            context
                                .read<DropdownCubit>()
                                .selectItem('jabatan', value);
                            print(jobTitleController.text);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Lama Bekerja"),
                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 0.1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: BlocBuilder<DropdownCubit, Map<String, String?>>(
                      builder: (context, state) {
                        return DropdownButton<String>(
                          underline: const SizedBox(),
                          isExpanded: true,
                          hint: Text(yearsOfServiceController.text.isNotEmpty
                              ? yearsOfServiceController.text
                              : "Pilih"),
                          value: state['lamaBekerja'],
                          items: lamaBekerja.map((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (value) {
                            yearsOfServiceController.text = value ?? '';
                            context
                                .read<DropdownCubit>()
                                .selectItem('lamaBekerja', value);
                            print(yearsOfServiceController.text);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Sumber Pendapatan"),
                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 0.1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: BlocBuilder<DropdownCubit, Map<String, String?>>(
                      builder: (context, state) {
                        return DropdownButton<String>(
                          underline: const SizedBox(),
                          isExpanded: true,
                          hint: Text(incomeSourceController.text.isNotEmpty
                              ? incomeSourceController.text
                              : "Pilih"),
                          value: state['sumberPendapatan'],
                          items: sumberPendapatan.map((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (value) {
                            incomeSourceController.text = value ?? '';
                            context
                                .read<DropdownCubit>()
                                .selectItem('sumberPendapatan', value);
                            print(incomeSourceController.text);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Pendapatan Kotor Pertahun"),
                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 0.1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: BlocBuilder<DropdownCubit, Map<String, String?>>(
                      builder: (context, state) {
                        return DropdownButton<String>(
                          underline: const SizedBox(),
                          isExpanded: true,
                          hint: Text(annualGrossIncomeController.text.isNotEmpty
                              ? annualGrossIncomeController.text
                              : "Pilih"),
                          value: state['pendapatanKotor'],
                          items: pendapatanKotor.map((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (value) {
                            annualGrossIncomeController.text = value ?? '';
                            context
                                .read<DropdownCubit>()
                                .selectItem('pendapatanKotor', value);

                            print(annualGrossIncomeController.text);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                hint: 'Nama Bank',
                textEditingController: bankNameController,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                hint: 'Cabang Bank',
                textEditingController: bankBranchController,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                hint: 'Nomor Rekening',
                textEditingController: bankAccountNumberController,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                hint: 'Nama Pemilik Rekening',
                textEditingController: accountHolderNameController,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            color: Colors.amber,
                          ),
                          foregroundColor: Colors.amber,
                          backgroundColor: Colors.white,
                          surfaceTintColor: Colors.white,
                          elevation: 5, // Tingkat elevasi
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          _goToPage(1);
                        },
                        child: const Text('Sebelumnya'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.amber,
                          surfaceTintColor: Colors.white,
                          elevation: 5, // Tingkat elevasi
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          _submitForm(
                              UserModel(
                                fullName: fullNameController.text,
                                birthDate:
                                    DateTime.parse(birthDateController.text),
                                gender: genderController.text,
                                email: emailController.text,
                                phoneNumber: phoneNumberController.text,
                                education: educationController.text,
                                maritalStatus: maritalStatusController.text,
                                ktpPath: ktpPathController.text,
                                nik: nikController.text,
                                ktpAddress: ktpAddressController.text,
                                ktpProvince: ktpProvinceController.text,
                                ktpCity: ktpCityController.text,
                                ktpDistrict: ktpDistrictController.text,
                                ktpSubDistrict: ktpSubDistrictController.text,
                                ktpPostalCode: ktpPostalCodeController.text,
                                domicileAddress: domicileAddressController.text,
                                domicileProvince:
                                    domicileProvinceController.text,
                                domicileCity: domicileCityController.text,
                                domicileDistrict:
                                    domicileDistrictController.text,
                                domicileSubDistrict:
                                    domicileSubDistrictController.text,
                                domicilePostalCode:
                                    domicilePostalCodeController.text,
                                companyName: companyNameController.text,
                                companyAddress: companyAddressController.text,
                                jobTitle: jobTitleController.text,
                                yearsOfService: yearsOfServiceController.text,
                                incomeSource: incomeSourceController.text,
                                annualGrossIncome:
                                    annualGrossIncomeController.text,
                                bankName: bankNameController.text,
                                bankBranch: bankBranchController.text,
                                bankAccountNumber:
                                    bankAccountNumberController.text,
                                accountHolderName:
                                    accountHolderNameController.text,
                              ),
                              'Informasi perusahaan berhasil disimpan');
                        },
                        child: const Text('Simpan'),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showImageSourceDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  // Memilih gambar dari kamera
                  ImageCubit().pickKTPImageFromCamera();

                  Navigator.of(context).pop(); // Menutup dialog setelah memilih
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  // Memilih gambar dari galeri
                  ImageCubit().pickKTPImageFromGallery();
                  Navigator.of(context).pop(); // Menutup dialog setelah memilih
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
