import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:client_app/src/app/pages/main/buttom_navigation_bar_controller.dart';
import 'package:client_app/src/app/widgets/custom_button.dart';
import 'package:client_app/src/app/widgets/custom_text_field.dart';
import 'package:client_app/src/core/route/navigation_service.dart';
import 'package:client_app/src/core/utils/constants.dart';
import 'package:client_app/src/core/utils/utils.dart';
import 'package:provider/provider.dart';

import 'address_viewModel.dart';

class AddressView extends StatefulWidget {
  const AddressView({Key? key}) : super(key: key);

  static String get routeName => '/address';

  @override
  _AddressViewState createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  @override
  Widget build(BuildContext context) {
    //Controller do provider
    var addressController = Provider.of<AddressProviderController>(context);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              'Informe seu endereço',
              style: GoogleFonts.raleway(
                color: Constants.blackColor,
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
            elevation: 0,
            backgroundColor: Constants.surface,
            iconTheme: const IconThemeData(color: Constants.blackColor),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                children: [
                  CustomTextFormField(
                    labelText: 'CEP',
                    hint: 'CEP do endereço para atendimento',
                    formatter: addressController.zipCodeFormatter,
                    textInputType: TextInputType.number,
                    prefixIcon: const Icon(Icons.person_outlined),
                    value: addressController.zipCode,
                    onChange: (value) => addressController.setZipCode(value),
                  ),
                  CustomTextFormField(
                    controller: addressController.streetController,
                    labelText: 'Logradouro',
                    hint: 'Rua, Avenida, Travessa, etc.',
                    prefixIcon: const Icon(Icons.person_outlined),
                    value: addressController.getStreet,
                    onChange: (value) => addressController.setStreet(value),
                  ),
                  CustomTextFormField(
                    labelText: 'Número',
                    hint: 's/n',
                    prefixIcon: const Icon(Icons.person_outlined),
                    value: addressController.number,
                    onChange: (value) => addressController.setNumber(value),
                  ),
                  CustomTextFormField(
                    controller: addressController.complementController,
                    labelText: 'Complemento',
                    hint: 'Lote, nome do prédio, apartamento, etc.',
                    prefixIcon: const Icon(Icons.person_outlined),
                    value: addressController.complement,
                    onChange: (value) => addressController.setComplement(value),
                  ),
                  CustomTextFormField(
                    controller: addressController.districtController,
                    labelText: 'Bairro',
                    isEnabled: false,
                    prefixIcon: const Icon(Icons.person_outlined),
                    value: addressController.district,
                    onChange: (value) => addressController.setDistrict(value),
                  ),
                  CustomTextFormField(
                    controller: addressController.cityController,
                    labelText: 'Cidade',
                    isEnabled: false,
                    prefixIcon: const Icon(Icons.person_outlined),
                    value: addressController.city,
                    onChange: (value) => addressController.setCity(value),
                  ),
                  CustomTextFormField(
                    controller: addressController.stateController,
                    labelText: 'Estado',
                    isEnabled: false,
                    prefixIcon: const Icon(Icons.person_outlined),
                    value: addressController.state,
                    onChange: (value) => addressController.setState(value),
                  ),
                  Container(
                    width: Utils.mediaQuery(context, 1),
                    padding: const EdgeInsets.only(top: 50, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: Utils.mediaQuery(context, 0.25)),
                        Text(addressController.street.isNotEmpty ? '' : 'Endereço inválido'),
                        CustomButton(
                          labelText: 'Próximo',
                          width: 110,
                          height: 50,
                          elevation: addressController.isValidButtonNext ? 3 : 0,
                          borderRadius: 15,
                          iconData: Icons.add,
                          color: addressController.isValidButtonNext
                              ? Constants.primaryContainer
                              : Constants.appTextColor,
                          colorText: Constants.blackColor,
                          colorButton: addressController.isValidButtonNext
                              ? Constants.primaryContainer
                              : Constants.appTextColor,
                          onTap: addressController.isValidButtonNext
                              ? () async {
                                  await navigationService.pushReplacement(BottomNavigationBarController.routeName);
                                }
                              : null,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        addressController.isLoading
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
