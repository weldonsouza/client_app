import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:client_app/src/core/provider/global_providers.dart';
import 'package:client_app/src/core/route/navigation_service.dart';
import 'package:client_app/src/domain/models/address/address_model.dart';

import '../../../core/utils/utils.dart';
import '../../../domain/models/user/user_model.dart';
import '../../widgets/custom_alert_signup.dart';
import '../main/buttom_navigation_bar_controller.dart';
import 'login_signup_view.dart';

class LoginProviderController with ChangeNotifier {
  final _userEntity = setupLocator.serviceLocatorUserEntity;
  final _addressEntity = setupLocator.serviceLocatorAddressEntity;

  late AnimationController controllerProgressBar;
  late Map<String, dynamic> mapAddress;

  var cpfFormatter = MaskTextInputFormatter(mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});
  var birthdateFormatter = MaskTextInputFormatter(mask: "##/##/####", filter: {"#": RegExp(r'[0-9]')});
  TextEditingController nameController = TextEditingController();
  TextEditingController nameSocialController = TextEditingController();
  var phoneFormatter = MaskTextInputFormatter(mask: "(##) # ####-####", filter: {"#": RegExp(r'[0-9]')});
  var cepFormatter = MaskTextInputFormatter(mask: "#####-###", filter: {"#": RegExp(r'[0-9]')});

  FocusNode nameFocus = FocusNode();
  FocusNode nameSocialFocus = FocusNode();

  String dropdownGenderDocument = 'Gênero no documento';
  List<String> listGenderDocument = ['Gênero no documento', 'Masculino', 'Feminino'];
  String dropdownSocialGender = 'Gênero Social (opcional)';
  List<String> listSocialGender = ['Gênero Social (opcional)', 'Masculino', 'Feminino', 'Outro'];
  int currentStep = 0;
  bool isLoading = false;
  bool isChecked = false;
  String cpf = '';
  String birthdate = '';
  String gender = '';
  String phone = '';
  String phoneCode = '';
  String cep = '';

  var zipCodeFormatter = MaskTextInputFormatter(mask: "#####-###", filter: {"#": RegExp(r'[0-9]')});
  TextEditingController streetController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController complementController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  String zipCode = '';
  String street = '';
  String number = '';
  String complement = '';
  String district = '';
  String city = '';
  String state = '';
  late AddressModel addressModelResult;
  var previousPage = '';

  late String codeSms;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late String strVerificationId;

  bool get getIsLoading => isLoading;
  AddressModel get getAddressModelResult => addressModelResult;

  setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  setIsChecked(bool value) {
    isChecked = value;
    notifyListeners();
  }

  setGenderDocument(String value) {
    dropdownGenderDocument = value;
    notifyListeners();
  }

  setSocialGender(String value) {
    dropdownSocialGender = value;
    notifyListeners();
  }

  setCurrentStep(int value) {
    currentStep = value;
    controllerProgressBar.value = controllerProgressBar.value + 0.17;
    notifyListeners();
  }

  setCpf(String value) => cpf = value;
  setBirthdate(String value) => birthdate = value;

  setPhone(String value) {
    phone = value.replaceAll(RegExp(r'[()),-]'), "").replaceAll(' ', '');
    notifyListeners();
  }

  setPhoneCode(String value) {
    phoneCode = value;
    if (phoneCode.length == 6) {
    }
    notifyListeners();
  }

  setZipCode(String value) {
    zipCode = value;
    if (zipCode.length > 8) {
      findAddressByZipCode();
    }
    notifyListeners();
  }

  setStreet(String value) {
    street = value;
    notifyListeners();
  }

  setNumber(String value) {
    number = value;
    notifyListeners();
  }

  setComplement(String value) {
    complement = value;
    notifyListeners();
  }

  setDistrict(String value) {
    district = value;
    notifyListeners();
  }

  setCity(String value) {
    city = value;
    notifyListeners();
  }

  setState(String value) {
    state = value;
    notifyListeners();
  }

  setAddressModelResult(AddressModel value) {
    addressModelResult = value;
    isValidButtonNext;
    notifyListeners();
  }

  void init() async {
    setIsLoading(false);
  }

  void dispose() {
    controllerProgressBar.dispose();
    setIsLoading(false);
    setCurrentStep(0);
    clearFields();
  }

  bool get isValidButtonNext {
    var result = false;

    switch (currentStep) {
      case 0:
        // CPF and Birthdate
        result = cpf.isNotEmpty &&
            cpf.length > 11 &&
            birthdate.isNotEmpty &&
            birthdate.length > 7;
        break;
      case 1:
        // Name and Gender
        result = nameController.text.isNotEmpty &&
            nameController.text.length > 3 &&
            dropdownGenderDocument != 'Gênero no documento';
        break;
      case 2:
        // Name and Gender Social
        result = true;
        break;
      case 3:
        // Phone
        result = phone.isNotEmpty && phone.length > 10;
        break;
      case 4:
        // SMS Code
        result = showVerificationCode == true;
        break;
      case 5:
        // Address
        result = zipCode.isNotEmpty &&
            zipCode.length == 9 &&
            street.isNotEmpty &&
            street.length >= 3 &&
            district.isNotEmpty &&
            city.isNotEmpty &&
            state.isNotEmpty;
        break;
      default:
    }

    return result;
  }

  Future verifyClientByCpfAndBirthdate() async {
    setIsLoading(true);
    String? birthdateToDate = Utils.dateStringToDate(birthdate);

    UserModel? resultVerify = await _userEntity.executeClientByCpfAndBirthdate(cpf, birthdateToDate!);

    if(resultVerify != null) {
      nameController.text = resultVerify.name!;
      if(resultVerify.gender == 'M') {
        setGenderDocument('Masculino');
      } else {
        setGenderDocument('Feminino');
      }
      isValidButtonNext;
      setCurrentStep(1);
    }

    setIsLoading(false);
  }

  Future authenticationGoogle(context) async {
    setIsLoading(true);
    String? tokenGoogle = await _userEntity.getAuthTokenGoogle();

    var newToken = await _userEntity.executeAuthenticationGoogle(tokenGoogle!);

    await _userEntity.saveAuthToken(newToken!.data['authorizationToken']);

    mapAddress = newToken.data['address'];
    setIsLoading(false);

    // Verificar se o usuario possui districtId
    if(mapAddress['districtId'].isNotEmpty) {
      await navigationService.pushReplacement(BottomNavigationBarController.routeName);
    } else {
      CustomAlertSignUp.showAlert(
        context: context,
        title: 'Política de Privacidade e Termos de Uso',
        warning: 'Ao tocar em Concordar, você aceita os ',
        iconData: Icons.assignment,
        onTapToAgree: () async {
          Navigator.of(context).pop();
          await navigationService.push(LoginSignupView.routeName);
        },
        onTapExit: () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  bool onEditing = true;
  bool showVerifyNumber = false;
  bool showVerificationCode = false;
  bool showSuccess = false;
  bool enableButtonCodeSms = false;

  setShowVerifyNumber(bool value) {
    showVerifyNumber = value;
    notifyListeners();
  }
  setShowVerificationCode(bool value) {
    showVerificationCode = value;
    notifyListeners();
  }
  setShowSuccess(bool value) {
    showSuccess = value;
    notifyListeners();
  }
  setEnableButtonCodeSms(bool value) {
    enableButtonCodeSms = value;
    notifyListeners();
  }

  // Enable resend button
  Future<void> enableButtonVerification() async {
    setEnableButtonCodeSms(false);
    Timer(const Duration(seconds: 60), () => setEnableButtonCodeSms(true));
  }

  // TODO - Verificar porque não esta avançando automaticamento apos ter validado o sms
  /// Validate phone sms to firebase
  Future<void> phoneNumberVerification() async {

    PhoneVerificationCompleted phoneVerificationCompleted = (PhoneAuthCredential phoneAuthCredential) async {
      await firebaseAuth.signInWithCredential(phoneAuthCredential);
      // 'O número de telefone é verificado automaticamente e o usuário faz login: ${firebaseAuth.currentUser!.uid}'
      // 'Número de telefone ${firebaseAuth.currentUser!.phoneNumber}'

      setShowVerifyNumber(false);
      setShowVerificationCode(false);
      setShowSuccess(true);
      if(showSuccess == true){
        setCurrentStep(5);
        //'Código SMS verificado com sucesso!'
        Future.delayed(const Duration(milliseconds: 200), (){
          NavigationService.showSnackbarMessage('Código SMS verificado com sucesso!', true);
        });
      }
    };

    PhoneVerificationFailed phoneVerificationFailed = (FirebaseAuthException authException) {
      NavigationService.showSnackbarMessage('A verificação do número de telefone falhou. Por favor, verifique o numero do telefone.', false);
      //Utils.showToast('A verificação do número de telefone falhou. Por favor, verifique o numero do telefone.', false);
      //Utils.showToast('Phone number verification is failed. Code: ${authException.code}. Message: ${authException.message}', false);
      // 'A verificação do número de telefone falhou. Code: ${authException.code}. Message: ${authException.message}'

      // habilitar numero para digitar novamente
    };

    PhoneCodeSent phoneCodeSent = (String verificationId, [int? forceResendingToken]) async {
      NavigationService.showSnackbarMessage('Te enviamos um código por SMS.', true);
      // 'Te enviamos um código por SMS.'
      strVerificationId = verificationId;

      // 'PhoneCodeSent ${verificationId} #### ${verificationId.characters}'
      // 'PhoneCodeSent codeUnits ${verificationId.codeUnits}'

      setShowVerifyNumber(false);
      setShowVerificationCode(true);
    };

    PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout = (String verificationId) {
      // 'Código de verificação: $verificationId'
      strVerificationId = verificationId;

      setShowVerifyNumber(false);
      setShowVerificationCode(true);
    };

    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+55$phone',
        timeout: const Duration(seconds: 5),
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
      );
    } catch (e) {
      NavigationService.showSnackbarMessage('Falha ao verificar o número do telefone.', false);
      // 'Falha ao verificar o número do telefone: ${e}'
    }
  }

  ///send sms code to validade faribase
  void signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: strVerificationId,
        smsCode: codeSms,
      );

      User? user = (await firebaseAuth.signInWithCredential(credential)).user;
      // 'Verificação do código SMS realizado com sucesso! ${user!.uid}'

      NavigationService.showSnackbarMessage('Verificação do código SMS realizado com sucesso!', true);
      // 'Verificação do código SMS realizado com sucesso! ${user.uid}'

      setShowVerificationCode(false);
      setShowSuccess(true);
      if(showSuccess == true){
        // 'Código SMS verificado com sucesso!'
        setCurrentStep(5);
        Future.delayed(const Duration(milliseconds: 200), (){
          NavigationService.showSnackbarMessage('Código SMS verificado com sucesso!', true);
        });
      }
    } catch (e) {
      // 'Falha ao verificar o código SMS.'
      NavigationService.showSnackbarMessage('Falha ao verificar o código SMS.', false);
    }
  }

  Future findAddressByZipCode() async {
    setIsLoading(true);

    AddressModel? addressResult = await _addressEntity.executeFindAddressByZipcode(zipCode);

    if(addressResult != null) {
      streetController.text = addressResult.address!;
      districtController.text = addressResult.district!;
      cityController.text = addressResult.city!;
      stateController.text = addressResult.state!;

      setStreet(addressResult.address!);
      setDistrict(addressResult.district!);
      setCity(addressResult.city!);
      setState(addressResult.state!);
      setAddressModelResult(addressResult);
    }

    setIsLoading(false);
  }

  Future completeRegistration() async {
    setIsLoading(false);
    String socialGender;

    if(dropdownSocialGender == 'Masculino') {
      socialGender = 'M';
    } else if(dropdownGenderDocument == 'Feminino') {
      socialGender = 'F';
    } else {
      socialGender = 'O';
    }

    UserModel userModel = UserModel(
      gender: dropdownGenderDocument == 'Masculino' ? 'M' : 'F',
      socialGender: socialGender,
      name: nameController.text,
      socialName: nameSocialController.text,
      phone: phone,
      address: street,
      number: number,
      cityId: addressModelResult.cityId,
      stateId: addressModelResult.stateId,
      districtId: addressModelResult.districtId,
      zipCode: zipCode,
      complement: complement,
    );

    var result = await _userEntity.executeCompleteRegistration(userModel);

    if(result == 200 || result == 201) {
      previousPage = 'singup';
      NavigationService.showSnackbarMessage('Cadastro realizado com sucesso!', true);
      Future.delayed(const Duration(milliseconds: 200), () async {
        await navigationService.pushReplacement(BottomNavigationBarController.routeName);
      });
    }

    setIsLoading(false);
  }

  void clearFields() {}
}