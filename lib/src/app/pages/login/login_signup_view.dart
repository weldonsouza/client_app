import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:client_app/src/app/widgets/custom_button.dart';
import 'package:client_app/src/app/widgets/custom_progress_bar.dart';
import 'package:client_app/src/app/widgets/custom_step.dart';
import 'package:client_app/src/app/widgets/custom_text_field.dart';
import 'package:client_app/src/app/widgets/custom_verification_code.dart';
import 'package:client_app/src/core/utils/constants.dart';
import 'package:client_app/src/core/utils/utils.dart';
import 'package:provider/provider.dart';

import 'login_viewModel.dart';

class LoginSignupView extends StatefulWidget {
  const LoginSignupView({Key? key}) : super(key: key);

  static String get routeName => '/loginSignup';

  @override
  _LoginSignupViewState createState() => _LoginSignupViewState();
}

class _LoginSignupViewState extends State<LoginSignupView> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    Provider.of<LoginProviderController>(context, listen: false).init();
    Provider.of<LoginProviderController>(context, listen: false)
        .controllerProgressBar = AnimationController(vsync: this, value: 0.17);
  }

  @override
  void dispose() {
    Provider.of<LoginProviderController>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Controller do provider
    var loginController = Provider.of<LoginProviderController>(context);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Constants.whiteColor,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Constants.surface,
            elevation: 0,
            iconTheme: const IconThemeData(color: Constants.blackColor),
            centerTitle: true,
            title: SizedBox(
              width: 150,
              height: 8,
              child: CustomProgressBar(
                max: 1,
                current: loginController.controllerProgressBar.value,
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CPF and Birthdate
              loginController.currentStep == 0
                  ? Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const CustomStep(
                            stepTitle: '1/6 etapas',
                            textInfo: 'Vamos nos conhecer melhor?',
                            subtitle: 'Precisamos confirmar alguns dos \nseus dados.',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                            child: CustomTextFormField(
                              labelText: 'Seu CPF',
                              hint: 'Seu CPF',
                              formatter: loginController.cpfFormatter,
                              textInputType: TextInputType.number,
                              fontWeight: FontWeight.w700,
                              prefixIcon: const Icon(Icons.description),
                              value: loginController.cpf,
                              onChange: (value) => loginController.setCpf(value),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: CustomTextFormField(
                              formatter: loginController.birthdateFormatter,
                              labelText: 'Data de nascimento',
                              hint: 'Data de nascimento',
                              textInputType: TextInputType.number,
                              fontWeight: FontWeight.w700,
                              prefixIcon: const Icon(Icons.cake),
                              value: loginController.birthdate,
                              onChange: (value) => loginController.setBirthdate(value),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),

              // Name and Gender
              loginController.currentStep == 1
                  ? Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const CustomStep(
                            stepTitle: '2/6 etapas',
                            textInfo: 'Informe seus dados conforme seu documento',
                            subtitle: 'Você poderá informar nome e \ngênero social em seguida.',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                            child: CustomTextFormField(
                              controller: loginController.nameController,
                              labelText: 'Nome completo',
                              hint: 'Nome completo',
                              textInputType: TextInputType.number,
                              fontWeight: FontWeight.w700,
                              textColorText: Constants.appTextColor,
                              hintColorText: Constants.textFieldDisable,
                              prefixIcon: const Icon(Icons.person_outlined),
                              value: loginController.nameController,
                              isEnabled: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Constants.textFieldDisable,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5, right: 10, bottom: 5),
                                child: DropdownButtonFormField(
                                  value: loginController.dropdownGenderDocument,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.male_outlined,
                                      color: Constants.appTextColor,
                                    ),
                                  ),
                                  isExpanded: true,
                                  style: GoogleFonts.raleway(
                                    fontSize: 16,
                                    color: Constants.textField,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  items: loginController.listGenderDocument
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),

              // Name and Gender Social
              loginController.currentStep == 2
                  ? Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const CustomStep(
                            stepTitle: '3/6 etapas',
                            textInfo: 'Como podemos te chamar?',
                            subtitle: 'Você pode deixar os campos em \nbranco se preferir.',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                            child: CustomTextFormField(
                              controller: loginController.nameSocialController,
                              labelText: 'Nome Social (opcional)',
                              hint: 'Nome Social (opcional)',
                              textInputType: TextInputType.text,
                              fontWeight: FontWeight.w700,
                              prefixIcon: const Icon(Icons.person_outlined),
                              value: loginController.nameSocialController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Constants.textField,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5, right: 10, bottom: 5),
                                child: DropdownButtonFormField(
                                  value: loginController.dropdownSocialGender,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    prefixIcon: Icon(Icons.transgender_outlined),
                                  ),
                                  isExpanded: true,
                                  style: GoogleFonts.raleway(
                                    fontSize: 16,
                                    color: Constants.textField,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  items: loginController.listSocialGender
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    FocusScope.of(context).requestFocus(loginController.nameSocialFocus);
                                    loginController.setGenderDocument(newValue!);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),

              // Phone
              loginController.currentStep == 3
                  ? Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const CustomStep(
                            stepTitle: '4/6 etapas',
                            textInfo: 'Qual é o seu número?',
                            subtitle: 'Te enviaremos um código por SMS \npara confirmação de dados.',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                            child: CustomTextFormField(
                              labelText: 'Telefone',
                              hint: 'Telefone',
                              formatter: loginController.phoneFormatter,
                              textInputType: TextInputType.number,
                              fontWeight: FontWeight.w700,
                              prefixIcon: const Icon(Icons.smartphone_outlined),
                              value: loginController.phone,
                              onChange: (value) => loginController.setPhone(value),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),

              // SMS Code
              loginController.currentStep == 4
                  ? Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const CustomStep(
                            stepTitle: '5/6 etapas',
                            textInfo: 'Confirme o seu telefone',
                            subtitle: 'Digite o código abaixo para verificar \nsua identidade.',
                          ),
                          CustomVerificationCode(
                            autofocus: true,
                            textStyle: GoogleFonts.raleway(
                              color: Constants.blackColor,
                              fontSize: 57,
                              fontWeight: FontWeight.w400,
                            ),
                            onCompleted: (String value) {
                              setState(() {
                                loginController.codeSms = value;
                              });
                              loginController.isValidButtonNext == true;
                            },
                            onEditing: (bool value) {
                              setState(() {
                                loginController.onEditing = value;
                              });
                              if (!loginController.onEditing) FocusScope.of(context).unfocus();
                            },
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  onSurface: Colors.white,
                                  primary: Constants.transparent,
                                  padding: const EdgeInsets.all(5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                onPressed: loginController.enableButtonCodeSms == true
                                    ? () async {
                                        loginController.phoneNumberVerification();
                                      }
                                    : null,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.refresh_outlined,
                                        color: loginController.enableButtonCodeSms == true
                                            ? Constants.primaryColor
                                            : Constants.textFieldDisable,
                                        size: 18,
                                      ),
                                      Text(
                                        ' re-enviar código',
                                        style: GoogleFonts.raleway(
                                          color: loginController.enableButtonCodeSms == true
                                              ? Constants.primaryColor
                                              : Constants.textFieldDisable,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(),

              // Address
              loginController.currentStep == 5
                  ? Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const CustomStep(
                              stepTitle: '6/6 etapas',
                              textInfo: 'Informe o seu endereço',
                            ),
                            CustomTextFormField(
                              labelText: 'CEP',
                              hint: 'CEP do endereço para atendimento',
                              marginTop: 20.0,
                              marginLeft: 15.0,
                              marginRight: 15.0,
                              formatter: loginController.zipCodeFormatter,
                              textInputType: TextInputType.number,
                              fontWeight: FontWeight.w700,
                              prefixIcon: const Icon(Icons.location_on),
                              value: loginController.zipCode,
                              onChange: (value) => loginController.setZipCode(value),
                            ),
                            CustomTextFormField(
                              controller: loginController.streetController,
                              labelText: 'Logradouro',
                              hint: 'Rua, Avenida, Travessa, etc.',
                              marginTop: 10.0,
                              marginLeft: 15.0,
                              marginRight: 15.0,
                              fontWeight: FontWeight.w700,
                              prefixIcon: const Icon(Icons.location_on),
                              value: loginController.street,
                              onChange: (value) => loginController.setStreet(value),
                            ),
                            CustomTextFormField(
                              labelText: 'Número',
                              hint: 's/n',
                              marginTop: 10.0,
                              marginLeft: 15.0,
                              marginRight: 15.0,
                              fontWeight: FontWeight.w700,
                              prefixIcon: const Icon(Icons.location_on),
                              value: loginController.number,
                              onChange: (value) => loginController.setNumber(value),
                            ),
                            CustomTextFormField(
                              controller: loginController.complementController,
                              labelText: 'Complemento',
                              hint: 'Lote, nome do prédio, apartamento, etc.',
                              marginTop: 10.0,
                              marginLeft: 15.0,
                              marginRight: 15.0,
                              fontWeight: FontWeight.w700,
                              prefixIcon: const Icon(Icons.location_on),
                              value: loginController.complement,
                              onChange: (value) => loginController.setComplement(value),
                            ),
                            CustomTextFormField(
                              controller: loginController.districtController,
                              labelText: 'Bairro',
                              marginTop: 10.0,
                              marginLeft: 15.0,
                              marginRight: 15.0,
                              fontWeight: FontWeight.w700,
                              isEnabled: false,
                              prefixIcon: const Icon(Icons.location_on),
                              value: loginController.district,
                              onChange: (value) => loginController.setDistrict(value),
                            ),
                            CustomTextFormField(
                              controller: loginController.cityController,
                              labelText: 'Cidade',
                              marginTop: 10.0,
                              marginLeft: 15.0,
                              marginRight: 15.0,
                              fontWeight: FontWeight.w700,
                              isEnabled: false,
                              prefixIcon: const Icon(Icons.location_on),
                              value: loginController.city,
                              onChange: (value) => loginController.setCity(value),
                            ),
                            CustomTextFormField(
                              controller: loginController.stateController,
                              labelText: 'Estado',
                              marginTop: 10.0,
                              marginLeft: 15.0,
                              marginRight: 15.0,
                              fontWeight: FontWeight.w700,
                              isEnabled: false,
                              prefixIcon: const Icon(Icons.location_on),
                              value: loginController.state,
                              onChange: (value) => loginController.setState(value),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),

              Padding(
                padding: const EdgeInsets.all(20),
                child: CustomButton(
                  labelText: loginController.currentStep == 4
                      ? 'Inserir código'
                      : (loginController.currentStep == 5
                        ? 'Finalizar cadastro'
                        : 'Proximo'),
                  width: Utils.mediaQuery(context, 1),
                  height: 40,
                  borderRadius: 15,
                  elevation: loginController.isValidButtonNext
                      ? 3
                      : 0,
                  color: loginController.isValidButtonNext
                      ? Constants.primaryColor2
                      : Constants.appTextColor,
                  colorText: Constants.whiteColor,
                  colorButton: loginController.isValidButtonNext
                      ? Constants.primaryColor2
                      : Constants.appTextColor,
                  textSize: 14,
                  fontWeight: FontWeight.w700,
                  iconData: loginController.currentStep == 4
                      ? Icons.phonelink_lock_outlined
                      : (loginController.currentStep == 5
                        ? Icons.done
                        : Icons.arrow_right_outlined),
                  iconSize: 22,
                  onTap: loginController.isValidButtonNext
                      ? () async {
                          if(loginController.currentStep == 0) { // CPF and Birthdate
                            loginController.verifyClientByCpfAndBirthdate();
                          } else if(loginController.currentStep == 1) { // Name and Gender
                            loginController.setCurrentStep(2);
                          } else if(loginController.currentStep == 2) { // Name and Gender Social
                            loginController.setCurrentStep(3);
                          } else if(loginController.currentStep == 3) { // Phone
                            loginController.setCurrentStep(4);

                            loginController.phoneNumberVerification();
                            loginController.enableButtonVerification();
                          } else if(loginController.currentStep == 4) { // SMS Code
                            loginController.setCurrentStep(5);

                            loginController.signInWithPhoneNumber();
                          } else if(loginController.currentStep == 5) { // Address
                            loginController.completeRegistration();
                          }
                        }
                      : null,
                ),
              ),
            ],
          ),
        ),
        loginController.isLoading
            ? Material(
                color: Colors.transparent,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black38,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        'Aguarde...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
