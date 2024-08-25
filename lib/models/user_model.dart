class UserModel {
  final String fullName;
  final DateTime birthDate;
  final String gender;
  final String email;
  final String phoneNumber;
  final String education;
  final String maritalStatus;
  final String ktpPath;
  final String nik;
  final String ktpAddress;
  final String ktpProvince;
  final String ktpCity;
  final String ktpDistrict;
  final String ktpSubDistrict;
  final String ktpPostalCode;
  final String domicileAddress;
  final String domicileProvince;
  final String domicileCity;
  final String domicileDistrict;
  final String domicileSubDistrict;
  final String domicilePostalCode;
  final String companyName;
  final String companyAddress;
  final String jobTitle;
  final String yearsOfService;
  final String incomeSource;
  final String annualGrossIncome;
  final String bankName;
  final String bankBranch;
  final String bankAccountNumber;
  final String accountHolderName;

  const UserModel({
    required this.fullName,
    required this.birthDate,
    required this.gender,
    required this.email,
    required this.phoneNumber,
    required this.education,
    required this.maritalStatus,
    required this.ktpPath,
    required this.nik,
    required this.ktpAddress,
    required this.ktpProvince,
    required this.ktpCity,
    required this.ktpDistrict,
    required this.ktpSubDistrict,
    required this.ktpPostalCode,
    required this.domicileAddress,
    required this.domicileProvince,
    required this.domicileCity,
    required this.domicileDistrict,
    required this.domicileSubDistrict,
    required this.domicilePostalCode,
    required this.companyName,
    required this.companyAddress,
    required this.jobTitle,
    required this.yearsOfService,
    required this.incomeSource,
    required this.annualGrossIncome,
    required this.bankName,
    required this.bankBranch,
    required this.bankAccountNumber,
    required this.accountHolderName,
  });

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "birthDate": birthDate.toIso8601String(),
        "gender": gender,
        "email": email,
        "phoneNumber": phoneNumber,
        "education": education,
        "maritalStatus": maritalStatus,
        "ktpPath": ktpPath,
        "nik": nik,
        "ktpAddress": ktpAddress,
        "ktpProvince": ktpProvince,
        "ktpCity": ktpCity,
        "ktpDistrict": ktpDistrict,
        "ktpSubDistrict": ktpSubDistrict,
        "ktpPostalCode": ktpPostalCode,
        "domicileAddress": domicileAddress,
        "domicileProvince": domicileProvince,
        "domicileCity": domicileCity,
        "domicileDistrict": domicileDistrict,
        "domicileSubDistrict": domicileSubDistrict,
        "domicilePostalCode": domicilePostalCode,
        "companyName": companyName,
        "companyAddress": companyAddress,
        "jobTitle": jobTitle,
        "yearsOfService": yearsOfService,
        "incomeSource": incomeSource,
        "annualGrossIncome": annualGrossIncome,
        "bankName": bankName,
        "bankBranch": bankBranch,
        "bankAccountNumber": bankAccountNumber,
        "accountHolderName": accountHolderName,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        fullName: json["fullName"],
        birthDate: DateTime.parse(json["birthDate"]),
        gender: json["gender"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        education: json["education"],
        maritalStatus: json["maritalStatus"],
        ktpPath: json["ktpPath"],
        nik: json["nik"],
        ktpAddress: json["ktpAddress"],
        ktpProvince: json["ktpProvince"],
        ktpCity: json["ktpCity"],
        ktpDistrict: json["ktpDistrict"],
        ktpSubDistrict: json["ktpSubDistrict"],
        ktpPostalCode: json["ktpPostalCode"],
        domicileAddress: json["domicileAddress"],
        domicileProvince: json["domicileProvince"],
        domicileCity: json["domicileCity"],
        domicileDistrict: json["domicileDistrict"],
        domicileSubDistrict: json["domicileSubDistrict"],
        domicilePostalCode: json["domicilePostalCode"],
        companyName: json["companyName"],
        companyAddress: json["companyAddress"],
        jobTitle: json["jobTitle"],
        yearsOfService: json["yearsOfService"],
        incomeSource: json["incomeSource"],
        annualGrossIncome: json["annualGrossIncome"],
        bankName: json["bankName"],
        bankBranch: json["bankBranch"],
        bankAccountNumber: json["bankAccountNumber"],
        accountHolderName: json["accountHolderName"],
      );
}
