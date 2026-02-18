import 'package:evac_tracker/components/alerts/information/information_widget.dart';

import '/backend/api_requests/api_calls.dart';
import '/components/page_elements/building_q_r/building_q_r_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';

import '/flutter_flow/custom_functions.dart' as functions;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'register_model.dart';
export 'register_model.dart';

class RegisterWidget extends StatefulWidget {
  final bool? isPermContractor;

  const RegisterWidget({super.key, required this.isPermContractor});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget>
    with TickerProviderStateMixin {
  late RegisterModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RegisterModel());

    if (widget.isPermContractor != null && widget.isPermContractor == true) {
      _model.error = 'Invalid QR code';
    } else {
      _model.error =
          'Resident must select a valid QR code and select an apartment to continue.';
    }

    _model.swPermContractorValue = false;
    _model.swPeepValue = false;
    _model.fullNameTextController ??= TextEditingController();
    _model.fullNameFocusNode ??= FocusNode();

    _model.emailAddressRegisterTextController ??= TextEditingController();
    _model.emailAddressRegisterFocusNode ??= FocusNode();

    _model.mobileNumberTextController ??= TextEditingController();
    _model.mobileNumberFocusNode ??= FocusNode();

    _model.passwordResidentTextController ??= TextEditingController();
    _model.passwordResidentFocusNode ??= FocusNode();

    _model.cfmPasswordResidentTextController ??= TextEditingController();
    _model.cfmPasswordResidentFocusNode ??= FocusNode();

    _model.arrivalTimeTextController ??= TextEditingController();
    _model.arrivalTimeFocusNode ??= FocusNode();

    _model.departureTimeTextController ??= TextEditingController();
    _model.departureTimeFocusNode ??= FocusNode();

    _model.dobTextController ??= TextEditingController();
    _model.dobFocusNode ??= FocusNode();

    _model.nomineeNameTextController ??= TextEditingController();
    _model.nomineeNameFocusNode ??= FocusNode();

    _model.nomineeContactTextController ??= TextEditingController();
    _model.nomineeContactFocusNode ??= FocusNode();

    _model.expirationDateTextController ??= TextEditingController();
    _model.expirationDateFocusNode ??= FocusNode();

    _model.reviewDateTextController ??= TextEditingController();
    _model.reviewDateFocusNode ??= FocusNode();

    FFAppState().qrBuilding.buildingID = 0;
    FFAppState().qrBuilding.floorID = 0;
    FFAppState().qrBuilding.roomID = 0;

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          TiltEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0, 0),
            end: const Offset(0, 0.349),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where(
        (anim) =>
            anim.trigger == AnimationTrigger.onActionTrigger ||
            !anim.applyInitialState,
      ),
      this,
    );
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return IntrinsicHeight(
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.95,
        padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).alternate,
          boxShadow: [
            BoxShadow(
              blurRadius: 10.0,
              color: FlutterFlowTheme.of(context).secondaryText,
              offset: const Offset(0.0, 0.0),
              spreadRadius: 0.0,
            ),
          ],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Register as:',
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                          fontFamily: FlutterFlowTheme.of(
                            context,
                          ).labelLargeFamily,
                          letterSpacing: 0.0,
                        ),
                      ),
                      widget.isPermContractor ?? false
                          ? Text(
                              ' Permanent Contractor',
                              style: FlutterFlowTheme.of(context).labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(
                                      context,
                                    ).labelMediumFamily,
                                  ),
                            )
                          : Text(
                              ' Resident',
                              style: FlutterFlowTheme.of(context).labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(
                                      context,
                                    ).labelMediumFamily,
                                  ),
                            ),
                    ],
                  ),

                  if (widget.isPermContractor ?? true)
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0,
                        5.0,
                        0.0,
                        5.0,
                      ),
                      child: wrapWithModel(
                        model: _model.buildingQRModel,
                        updateCallback: () => setState(() {}),
                        child: const BuildingQRWidget(showDropdown: false),
                      ),
                    ),
                  if (!(widget.isPermContractor ?? false))
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0,
                        5.0,
                        0.0,
                        5.0,
                      ),
                      child: wrapWithModel(
                        model: _model.buildingQRModel,
                        updateCallback: () => setState(() {}),
                        child: const BuildingQRWidget(showDropdown: true),
                      ),
                    ),
                  if (_model.qrValid)
                    Align(
                      alignment: const AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          16.0,
                          0.0,
                          0.0,
                          0.0,
                        ),
                        child: Text(
                          _model.error,
                          style: FlutterFlowTheme.of(context).bodySmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(
                                  context,
                                ).bodySmallFamily,
                                color: FlutterFlowTheme.of(context).error,
                                letterSpacing: 0.0,
                                fontStyle: FontStyle.italic,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodySmallFamily,
                                ),
                              ),
                        ),
                      ),
                    ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Form(
                              key: _model.formKey3,
                              autovalidateMode: AutovalidateMode.disabled,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 1),

                                  SizedBox(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: _model.fullNameTextController,
                                      focusNode: _model.fullNameFocusNode,
                                      // autofocus: true,
                                      autofillHints: [AutofillHints.email],
                                      textCapitalization:
                                          TextCapitalization.words,
                                      textInputAction: TextInputAction.next,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: 'Name',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: FlutterFlowTheme.of(
                                                context,
                                              ).labelMediumFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey(
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).labelMediumFamily,
                                                      ),
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).primaryBackground,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            40.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).primary,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            40.0,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).error,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            40.0,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).error,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            40.0,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(
                                          context,
                                        ).secondaryBackground,
                                        prefixIcon: const Icon(
                                          Icons.person_outline,
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(
                                              context,
                                            ).labelSmallFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                  FlutterFlowTheme.of(
                                                    context,
                                                  ).labelSmallFamily,
                                                ),
                                          ),
                                      maxLength: 50,
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.enforced,
                                      buildCounter:
                                          (
                                            context, {
                                            required currentLength,
                                            required isFocused,
                                            maxLength,
                                          }) => null,
                                      keyboardType: TextInputType.name,
                                      validator: _model
                                          .fullNameTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                  const SizedBox(height: 1),
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: _model
                                          .emailAddressRegisterTextController,
                                      focusNode:
                                          _model.emailAddressRegisterFocusNode,
                                      // autofocus: true,
                                      autofillHints: [AutofillHints.email],
                                      textInputAction: TextInputAction.next,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: 'Email Address',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: FlutterFlowTheme.of(
                                                context,
                                              ).labelMediumFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey(
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).labelMediumFamily,
                                                      ),
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).primaryBackground,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            40.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).primary,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            40.0,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).error,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            40.0,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).error,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            40.0,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(
                                          context,
                                        ).secondaryBackground,
                                        prefixIcon: const Icon(
                                          Icons.email_outlined,
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(
                                              context,
                                            ).labelSmallFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                  FlutterFlowTheme.of(
                                                    context,
                                                  ).labelSmallFamily,
                                                ),
                                          ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: _model
                                          .emailAddressRegisterTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                  const SizedBox(height: 1),
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller:
                                          _model.mobileNumberTextController,
                                      focusNode: _model.mobileNumberFocusNode,
                                      // autofocus: true,
                                      autofillHints: [
                                        AutofillHints.telephoneNumber,
                                      ],
                                      textInputAction: TextInputAction.next,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: 'Mobile Number',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: FlutterFlowTheme.of(
                                                context,
                                              ).labelMediumFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey(
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).labelMediumFamily,
                                                      ),
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).primaryBackground,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            40.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).primary,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            40.0,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).error,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            40.0,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).error,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            40.0,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(
                                          context,
                                        ).secondaryBackground,
                                        prefixIcon: const Icon(Icons.phone),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(
                                              context,
                                            ).labelSmallFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                  FlutterFlowTheme.of(
                                                    context,
                                                  ).labelSmallFamily,
                                                ),
                                          ),
                                      maxLength: 10,
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.enforced,
                                      buildCounter:
                                          (
                                            context, {
                                            required currentLength,
                                            required isFocused,
                                            maxLength,
                                          }) => null,
                                      keyboardType: TextInputType.phone,
                                      validator: _model
                                          .mobileNumberTextControllerValidator
                                          .asValidator(context),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegExp('[0-9]'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 1),
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller:
                                          _model.passwordResidentTextController,
                                      focusNode:
                                          _model.passwordResidentFocusNode,
                                      // autofocus: true,
                                      textInputAction: TextInputAction.next,
                                      obscureText:
                                          !_model.passwordResidentVisibility,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: 'Password',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: FlutterFlowTheme.of(
                                                context,
                                              ).labelMediumFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey(
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).labelMediumFamily,
                                                      ),
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).primaryBackground,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            40.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).primary,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            40.0,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).error,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            40.0,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).error,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            40.0,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(
                                          context,
                                        ).secondaryBackground,
                                        prefixIcon: const Icon(
                                          Icons.lock_outline,
                                        ),
                                        suffixIcon: InkWell(
                                          onTap: () => setState(
                                            () => _model.passwordResidentVisibility =
                                                !_model
                                                    .passwordResidentVisibility,
                                          ),
                                          focusNode: FocusNode(
                                            skipTraversal: true,
                                          ),
                                          child: Icon(
                                            _model.passwordResidentVisibility
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: const Color(0xFF757575),
                                            size: 22.0,
                                          ),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(
                                              context,
                                            ).labelSmallFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                  FlutterFlowTheme.of(
                                                    context,
                                                  ).labelSmallFamily,
                                                ),
                                          ),
                                      validator: _model
                                          .passwordResidentTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                  const SizedBox(height: 1),

                                  if (FFAppState().passwordMatch)
                                    Align(
                                      alignment: const AlignmentDirectional(
                                        -1.0,
                                        0.0,
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                              16.0,
                                              0.0,
                                              0.0,
                                              0.0,
                                            ),
                                        child:
                                            Text(
                                              'Password does not match',
                                              style:
                                                  FlutterFlowTheme.of(
                                                    context,
                                                  ).bodySmall.override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).bodySmallFamily,
                                                    color: FlutterFlowTheme.of(
                                                      context,
                                                    ).error,
                                                    letterSpacing: 0.0,
                                                    fontStyle: FontStyle.italic,
                                                    useGoogleFonts:
                                                        GoogleFonts.asMap()
                                                            .containsKey(
                                                              FlutterFlowTheme.of(
                                                                context,
                                                              ).bodySmallFamily,
                                                            ),
                                                  ),
                                            ).animateOnActionTrigger(
                                              animationsMap['textOnActionTriggerAnimation']!,
                                            ),
                                      ),
                                    ),
                                ].divide(const SizedBox(height: 4.0)),
                              ),
                            ),
                            //if (_model.swPermContractorValue ?? true)
                            if (widget.isPermContractor ?? true)
                              Form(
                                key: _model.formKey1,
                                autovalidateMode: AutovalidateMode.disabled,
                                child: Column(
                                  children: [
                                    const SizedBox.shrink(),
                                    FlutterFlowDropDown<String>(
                                      multiSelectController:
                                          _model.dropDownValueController ??=
                                              FormListFieldController<String>(
                                                null,
                                              ),
                                      options: [
                                        'Mon',
                                        'Tue',
                                        'Wed',
                                        'Thu',
                                        'Fri',
                                        'Sat',
                                        'Sun',
                                      ],
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMediumFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                  FlutterFlowTheme.of(
                                                    context,
                                                  ).bodyMediumFamily,
                                                ),
                                          ),
                                      hintText: 'Please select days...',
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: FlutterFlowTheme.of(
                                          context,
                                        ).secondaryText,
                                        size: 24.0,
                                      ),
                                      fillColor: FlutterFlowTheme.of(
                                        context,
                                      ).secondaryBackground,
                                      elevation: 2.0,
                                      borderColor: FlutterFlowTheme.of(
                                        context,
                                      ).primaryBackground,
                                      borderWidth: 2.0,
                                      borderRadius: 20.0,
                                      margin:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            16.0,
                                            0.0,
                                            0.0,
                                            0.0,
                                          ),
                                      hidesUnderline: true,
                                      isOverButton: true,
                                      isSearchable: false,
                                      isMultiSelect: true,
                                      onMultiSelectChanged: (val) => setState(
                                        () => _model.dropDownValue = val,
                                      ),
                                    ),
                                    const SizedBox(height: 1),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: TextFormField(
                                              controller: _model
                                                  .arrivalTimeTextController,
                                              focusNode:
                                                  _model.arrivalTimeFocusNode,
                                              autofocus: false,
                                              readOnly: true,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelText: 'Arrival Time',
                                                labelStyle:
                                                    FlutterFlowTheme.of(
                                                      context,
                                                    ).labelMedium.override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                            context,
                                                          ).labelMediumFamily,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          GoogleFonts.asMap()
                                                              .containsKey(
                                                                FlutterFlowTheme.of(
                                                                  context,
                                                                ).labelMediumFamily,
                                                              ),
                                                    ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                              context,
                                                            ).primaryBackground,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            40.0,
                                                          ),
                                                    ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                              context,
                                                            ).primary,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            40.0,
                                                          ),
                                                    ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                      context,
                                                    ).error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        40.0,
                                                      ),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                              context,
                                                            ).error,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            40.0,
                                                          ),
                                                    ),
                                                filled: true,
                                                fillColor: FlutterFlowTheme.of(
                                                  context,
                                                ).secondaryBackground,
                                                prefixIcon: const Icon(
                                                  Icons.timer_outlined,
                                                ),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(
                                                    context,
                                                  ).labelSmall.override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).labelSmallFamily,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        GoogleFonts.asMap()
                                                            .containsKey(
                                                              FlutterFlowTheme.of(
                                                                context,
                                                              ).labelSmallFamily,
                                                            ),
                                                  ),
                                              keyboardType:
                                                  TextInputType.datetime,
                                              validator: _model
                                                  .arrivalTimeTextControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                5.0,
                                                0.0,
                                                0.0,
                                                0.0,
                                              ),
                                          child: FlutterFlowIconButton(
                                            borderColor: FlutterFlowTheme.of(
                                              context,
                                            ).primaryText,
                                            borderRadius: 20.0,
                                            borderWidth: 1.0,
                                            buttonSize: 40.0,
                                            fillColor: FlutterFlowTheme.of(
                                              context,
                                            ).secondaryBackground,
                                            icon: Icon(
                                              Icons.calendar_month,
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).primaryText,
                                              size: 24.0,
                                            ),
                                            onPressed: () async {
                                              final _datePicked1Time = await showTimePicker(
                                                context: context,
                                                initialTime:
                                                    TimeOfDay.fromDateTime(
                                                      getCurrentTimestamp,
                                                    ),
                                                builder: (context, child) {
                                                  return wrapInMaterialTimePickerTheme(
                                                    context,
                                                    child!,
                                                    headerBackgroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).primary,
                                                    headerForegroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).info,
                                                    headerTextStyle:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).headlineLarge.override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                context,
                                                              ).headlineLargeFamily,
                                                          fontSize: 32.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts:
                                                              GoogleFonts.asMap()
                                                                  .containsKey(
                                                                    FlutterFlowTheme.of(
                                                                      context,
                                                                    ).headlineLargeFamily,
                                                                  ),
                                                        ),
                                                    pickerBackgroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).secondaryBackground,
                                                    pickerForegroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).primaryText,
                                                    selectedDateTimeBackgroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).primary,
                                                    selectedDateTimeForegroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).info,
                                                    actionButtonForegroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).primaryText,
                                                    iconSize: 24.0,
                                                  );
                                                },
                                              );
                                              if (_datePicked1Time != null) {
                                                safeSetState(() {
                                                  _model.datePicked1 = DateTime(
                                                    getCurrentTimestamp.year,
                                                    getCurrentTimestamp.month,
                                                    getCurrentTimestamp.day,
                                                    _datePicked1Time.hour,
                                                    _datePicked1Time.minute,
                                                  );
                                                });
                                              }
                                              setState(() {
                                                _model
                                                    .arrivalTimeTextController
                                                    ?.text = dateTimeFormat(
                                                  "Hms",
                                                  _model.datePicked1,
                                                  locale: FFLocalizations.of(
                                                    context,
                                                  ).languageCode,
                                                );
                                                _model
                                                        .arrivalTimeTextController
                                                        ?.selection =
                                                    TextSelection.collapsed(
                                                      offset: _model
                                                          .arrivalTimeTextController!
                                                          .text
                                                          .length,
                                                    );
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 1),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: TextFormField(
                                              controller: _model
                                                  .departureTimeTextController,
                                              focusNode:
                                                  _model.departureTimeFocusNode,
                                              autofocus: false,
                                              readOnly: true,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelText: 'Departure Time',
                                                labelStyle:
                                                    FlutterFlowTheme.of(
                                                      context,
                                                    ).labelMedium.override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                            context,
                                                          ).labelMediumFamily,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          GoogleFonts.asMap()
                                                              .containsKey(
                                                                FlutterFlowTheme.of(
                                                                  context,
                                                                ).labelMediumFamily,
                                                              ),
                                                    ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                              context,
                                                            ).primaryBackground,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            40.0,
                                                          ),
                                                    ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                              context,
                                                            ).primary,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            40.0,
                                                          ),
                                                    ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                      context,
                                                    ).error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        40.0,
                                                      ),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                              context,
                                                            ).error,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            40.0,
                                                          ),
                                                    ),
                                                filled: true,
                                                fillColor: FlutterFlowTheme.of(
                                                  context,
                                                ).secondaryBackground,
                                                prefixIcon: const Icon(
                                                  Icons.timer_outlined,
                                                ),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(
                                                    context,
                                                  ).labelSmall.override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).labelSmallFamily,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        GoogleFonts.asMap()
                                                            .containsKey(
                                                              FlutterFlowTheme.of(
                                                                context,
                                                              ).labelSmallFamily,
                                                            ),
                                                  ),
                                              keyboardType:
                                                  TextInputType.datetime,
                                              validator: _model
                                                  .departureTimeTextControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                5.0,
                                                0.0,
                                                0.0,
                                                0.0,
                                              ),
                                          child: FlutterFlowIconButton(
                                            borderColor: FlutterFlowTheme.of(
                                              context,
                                            ).primaryText,
                                            borderRadius: 20.0,
                                            borderWidth: 1.0,
                                            buttonSize: 40.0,
                                            fillColor: FlutterFlowTheme.of(
                                              context,
                                            ).secondaryBackground,
                                            icon: Icon(
                                              Icons.calendar_month,
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).primaryText,
                                              size: 24.0,
                                            ),
                                            onPressed: () async {
                                              final _datePicked2Time = await showTimePicker(
                                                context: context,
                                                initialTime:
                                                    TimeOfDay.fromDateTime(
                                                      getCurrentTimestamp,
                                                    ),
                                                builder: (context, child) {
                                                  return wrapInMaterialTimePickerTheme(
                                                    context,
                                                    child!,
                                                    headerBackgroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).primary,
                                                    headerForegroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).info,
                                                    headerTextStyle:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).headlineLarge.override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                context,
                                                              ).headlineLargeFamily,
                                                          fontSize: 32.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts:
                                                              GoogleFonts.asMap()
                                                                  .containsKey(
                                                                    FlutterFlowTheme.of(
                                                                      context,
                                                                    ).headlineLargeFamily,
                                                                  ),
                                                        ),
                                                    pickerBackgroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).secondaryBackground,
                                                    pickerForegroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).primaryText,
                                                    selectedDateTimeBackgroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).primary,
                                                    selectedDateTimeForegroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).info,
                                                    actionButtonForegroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).primaryText,
                                                    iconSize: 24.0,
                                                  );
                                                },
                                              );
                                              if (_datePicked2Time != null) {
                                                safeSetState(() {
                                                  _model.datePicked2 = DateTime(
                                                    getCurrentTimestamp.year,
                                                    getCurrentTimestamp.month,
                                                    getCurrentTimestamp.day,
                                                    _datePicked2Time.hour,
                                                    _datePicked2Time.minute,
                                                  );
                                                });
                                              }
                                              setState(() {
                                                _model
                                                    .departureTimeTextController
                                                    ?.text = dateTimeFormat(
                                                  "Hms",
                                                  _model.datePicked2,
                                                  locale: FFLocalizations.of(
                                                    context,
                                                  ).languageCode,
                                                );
                                                _model
                                                        .departureTimeTextController
                                                        ?.selection =
                                                    TextSelection.collapsed(
                                                      offset: _model
                                                          .departureTimeTextController!
                                                          .text
                                                          .length,
                                                    );
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ].divide(const SizedBox(height: 5.0)),
                                ),
                              ),
                            if (_model.swPeepValue ?? true)
                              Form(
                                key: _model.formKey2,
                                autovalidateMode: AutovalidateMode.disabled,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const SizedBox.shrink(),
                                    SizedBox(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller:
                                            _model.nomineeNameTextController,
                                        focusNode: _model.nomineeNameFocusNode,
                                        // autofocus: true,
                                        autofillHints: [AutofillHints.name],
                                        textCapitalization:
                                            TextCapitalization.words,
                                        textInputAction: TextInputAction.next,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          labelText: 'Nominee Name',
                                          labelStyle:
                                              FlutterFlowTheme.of(
                                                context,
                                              ).labelMedium.override(
                                                fontFamily: FlutterFlowTheme.of(
                                                  context,
                                                ).labelMediumFamily,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    GoogleFonts.asMap()
                                                        .containsKey(
                                                          FlutterFlowTheme.of(
                                                            context,
                                                          ).labelMediumFamily,
                                                        ),
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).primaryBackground,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              40.0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).primary,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              40.0,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).error,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              40.0,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                    context,
                                                  ).error,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(40.0),
                                              ),
                                          filled: true,
                                          fillColor: FlutterFlowTheme.of(
                                            context,
                                          ).secondaryBackground,
                                          prefixIcon: const Icon(
                                            Icons.person_outline,
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .override(
                                              fontFamily: FlutterFlowTheme.of(
                                                context,
                                              ).labelSmallFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey(
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).labelSmallFamily,
                                                      ),
                                            ),
                                        keyboardType: TextInputType.name,
                                        validator: _model
                                            .nomineeNameTextControllerValidator
                                            .asValidator(context),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp('[a-zA-Z]'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller:
                                            _model.nomineeContactTextController,
                                        focusNode:
                                            _model.nomineeContactFocusNode,
                                        // autofocus: true,
                                        autofillHints: [AutofillHints.name],
                                        textInputAction: TextInputAction.next,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          labelText: 'Nominee Contact',
                                          labelStyle:
                                              FlutterFlowTheme.of(
                                                context,
                                              ).labelMedium.override(
                                                fontFamily: FlutterFlowTheme.of(
                                                  context,
                                                ).labelMediumFamily,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    GoogleFonts.asMap()
                                                        .containsKey(
                                                          FlutterFlowTheme.of(
                                                            context,
                                                          ).labelMediumFamily,
                                                        ),
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).primaryBackground,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              40.0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).primary,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              40.0,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).error,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              40.0,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                    context,
                                                  ).error,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(40.0),
                                              ),
                                          filled: true,
                                          fillColor: FlutterFlowTheme.of(
                                            context,
                                          ).secondaryBackground,
                                          prefixIcon: const Icon(
                                            Icons.person_outline,
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .override(
                                              fontFamily: FlutterFlowTheme.of(
                                                context,
                                              ).labelSmallFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey(
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).labelSmallFamily,
                                                      ),
                                            ),
                                        maxLength: 10,
                                        maxLengthEnforcement:
                                            MaxLengthEnforcement.enforced,
                                        buildCounter:
                                            (
                                              context, {
                                              required currentLength,
                                              required isFocused,
                                              maxLength,
                                            }) => null,
                                        keyboardType: TextInputType.phone,
                                        validator: _model
                                            .nomineeContactTextControllerValidator
                                            .asValidator(context),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: const AlignmentDirectional(
                                        -1.0,
                                        0.0,
                                      ),
                                      child: FlutterFlowDropDown<String>(
                                        controller:
                                            _model.peepTypeValueController ??=
                                                FormFieldController<String>(
                                                  _model.peepTypeValue ??=
                                                      'Permanent',
                                                ),
                                        options: ['Permanent', 'Temporary'],
                                        onChanged: (val) => setState(
                                          () => _model.peepTypeValue = val,
                                        ),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: FlutterFlowTheme.of(
                                                context,
                                              ).labelMediumFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey(
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).labelMediumFamily,
                                                      ),
                                            ),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).secondaryText,
                                          size: 24.0,
                                        ),
                                        fillColor: FlutterFlowTheme.of(
                                          context,
                                        ).secondaryBackground,
                                        elevation: 2.0,
                                        borderColor: FlutterFlowTheme.of(
                                          context,
                                        ).primaryBackground,
                                        borderWidth: 2.0,
                                        borderRadius: 40.0,
                                        margin:
                                            const EdgeInsetsDirectional.fromSTEB(
                                              16.0,
                                              0.0,
                                              16.0,
                                              0.0,
                                            ),
                                        hidesUnderline: true,
                                        isOverButton: true,
                                        isSearchable: false,
                                        isMultiSelect: false,
                                        labelText: 'Evacuation Method',
                                        labelTextStyle:
                                            FlutterFlowTheme.of(
                                              context,
                                            ).labelSmall.override(
                                              fontFamily: FlutterFlowTheme.of(
                                                context,
                                              ).labelSmallFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey(
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).labelSmallFamily,
                                                      ),
                                            ),
                                      ),
                                    ),
                                    if (_model.peepTypeValue == 'Temporary')
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: TextFormField(
                                                controller: _model
                                                    .expirationDateTextController,
                                                focusNode: _model
                                                    .expirationDateFocusNode,
                                                // autofocus: true,
                                                readOnly: true,
                                                autofillHints: [
                                                  AutofillHints.name,
                                                ],
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelText: 'Expiration Date',
                                                  labelStyle:
                                                      FlutterFlowTheme.of(
                                                        context,
                                                      ).labelMedium.override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                              context,
                                                            ).labelMediumFamily,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            GoogleFonts.asMap()
                                                                .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                    context,
                                                                  ).labelMediumFamily,
                                                                ),
                                                      ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                            context,
                                                          ).primaryBackground,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          40.0,
                                                        ),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                            context,
                                                          ).primary,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          40.0,
                                                        ),
                                                  ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                            context,
                                                          ).error,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          40.0,
                                                        ),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              FlutterFlowTheme.of(
                                                                context,
                                                              ).error,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              40.0,
                                                            ),
                                                      ),
                                                  filled: true,
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                        context,
                                                      ).secondaryBackground,
                                                  prefixIcon: const Icon(
                                                    Icons.calendar_month,
                                                  ),
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(
                                                      context,
                                                    ).labelSmall.override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                            context,
                                                          ).labelSmallFamily,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          GoogleFonts.asMap()
                                                              .containsKey(
                                                                FlutterFlowTheme.of(
                                                                  context,
                                                                ).labelSmallFamily,
                                                              ),
                                                    ),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                validator: _model
                                                    .expirationDateTextControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          ),
                                          FlutterFlowIconButton(
                                            borderColor: FlutterFlowTheme.of(
                                              context,
                                            ).primaryText,
                                            borderRadius: 20.0,
                                            borderWidth: 1.0,
                                            buttonSize: 40.0,
                                            fillColor: FlutterFlowTheme.of(
                                              context,
                                            ).secondaryBackground,
                                            icon: Icon(
                                              Icons.calendar_month,
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).primaryText,
                                              size: 24.0,
                                            ),
                                            onPressed: () async {
                                              final _datePicked4Date = await showDatePicker(
                                                context: context,
                                                initialDate:
                                                    getCurrentTimestamp,
                                                firstDate: getCurrentTimestamp,
                                                lastDate: DateTime(2050),
                                                builder: (context, child) {
                                                  return wrapInMaterialDatePickerTheme(
                                                    context,
                                                    child!,
                                                    headerBackgroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).primary,
                                                    headerForegroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).info,
                                                    headerTextStyle:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).headlineLarge.override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                context,
                                                              ).headlineLargeFamily,
                                                          fontSize: 32.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts:
                                                              GoogleFonts.asMap()
                                                                  .containsKey(
                                                                    FlutterFlowTheme.of(
                                                                      context,
                                                                    ).headlineLargeFamily,
                                                                  ),
                                                        ),
                                                    pickerBackgroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).secondaryBackground,
                                                    pickerForegroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).primaryText,
                                                    selectedDateTimeBackgroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).primary,
                                                    selectedDateTimeForegroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).info,
                                                    actionButtonForegroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).primaryText,
                                                    iconSize: 24.0,
                                                  );
                                                },
                                              );

                                              if (_datePicked4Date != null) {
                                                safeSetState(() {
                                                  _model.datePicked4 = DateTime(
                                                    _datePicked4Date.year,
                                                    _datePicked4Date.month,
                                                    _datePicked4Date.day,
                                                  );
                                                });
                                              }
                                              setState(() {
                                                _model
                                                    .expirationDateTextController
                                                    ?.text = dateTimeFormat(
                                                  "y-M-d",
                                                  _model.datePicked4,
                                                  locale: FFLocalizations.of(
                                                    context,
                                                  ).languageCode,
                                                );
                                                _model
                                                        .expirationDateTextController
                                                        ?.selection =
                                                    TextSelection.collapsed(
                                                      offset: _model
                                                          .expirationDateTextController!
                                                          .text
                                                          .length,
                                                    );
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    if (_model.peepTypeValue == 'Temporary')
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: TextFormField(
                                                controller: _model
                                                    .reviewDateTextController,
                                                focusNode:
                                                    _model.reviewDateFocusNode,
                                                // autofocus: true,
                                                readOnly: true,
                                                autofillHints: [
                                                  AutofillHints.name,
                                                ],
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelText: 'Review Date',
                                                  labelStyle:
                                                      FlutterFlowTheme.of(
                                                        context,
                                                      ).labelMedium.override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                              context,
                                                            ).labelMediumFamily,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            GoogleFonts.asMap()
                                                                .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                    context,
                                                                  ).labelMediumFamily,
                                                                ),
                                                      ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                            context,
                                                          ).primaryBackground,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          40.0,
                                                        ),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                            context,
                                                          ).primary,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          40.0,
                                                        ),
                                                  ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                            context,
                                                          ).error,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          40.0,
                                                        ),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              FlutterFlowTheme.of(
                                                                context,
                                                              ).error,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              40.0,
                                                            ),
                                                      ),
                                                  filled: true,
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                        context,
                                                      ).secondaryBackground,
                                                  prefixIcon: const Icon(
                                                    Icons.calendar_month,
                                                  ),
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(
                                                      context,
                                                    ).labelSmall.override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                            context,
                                                          ).labelSmallFamily,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          GoogleFonts.asMap()
                                                              .containsKey(
                                                                FlutterFlowTheme.of(
                                                                  context,
                                                                ).labelSmallFamily,
                                                              ),
                                                    ),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                validator: _model
                                                    .reviewDateTextControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          ),
                                          FlutterFlowIconButton(
                                            borderColor: FlutterFlowTheme.of(
                                              context,
                                            ).primaryText,
                                            borderRadius: 20.0,
                                            borderWidth: 1.0,
                                            buttonSize: 40.0,
                                            fillColor: FlutterFlowTheme.of(
                                              context,
                                            ).secondaryBackground,
                                            icon: Icon(
                                              Icons.calendar_month,
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).primaryText,
                                              size: 24.0,
                                            ),
                                            onPressed: () async {
                                              final _datePicked5Date = await showDatePicker(
                                                context: context,
                                                initialDate:
                                                    getCurrentTimestamp,
                                                firstDate: getCurrentTimestamp,
                                                lastDate: DateTime(2050),
                                                builder: (context, child) {
                                                  return wrapInMaterialDatePickerTheme(
                                                    context,
                                                    child!,
                                                    headerBackgroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).primary,
                                                    headerForegroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).info,
                                                    headerTextStyle:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).headlineLarge.override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                context,
                                                              ).headlineLargeFamily,
                                                          fontSize: 32.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts:
                                                              GoogleFonts.asMap()
                                                                  .containsKey(
                                                                    FlutterFlowTheme.of(
                                                                      context,
                                                                    ).headlineLargeFamily,
                                                                  ),
                                                        ),
                                                    pickerBackgroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).secondaryBackground,
                                                    pickerForegroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).primaryText,
                                                    selectedDateTimeBackgroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).primary,
                                                    selectedDateTimeForegroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).info,
                                                    actionButtonForegroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).primaryText,
                                                    iconSize: 24.0,
                                                  );
                                                },
                                              );

                                              if (_datePicked5Date != null) {
                                                safeSetState(() {
                                                  _model.datePicked5 = DateTime(
                                                    _datePicked5Date.year,
                                                    _datePicked5Date.month,
                                                    _datePicked5Date.day,
                                                  );
                                                });
                                              }
                                              setState(() {
                                                _model
                                                    .reviewDateTextController
                                                    ?.text = dateTimeFormat(
                                                  "y-M-d",
                                                  _model.datePicked5,
                                                  locale: FFLocalizations.of(
                                                    context,
                                                  ).languageCode,
                                                );
                                                _model
                                                        .reviewDateTextController
                                                        ?.selection =
                                                    TextSelection.collapsed(
                                                      offset: _model
                                                          .reviewDateTextController!
                                                          .text
                                                          .length,
                                                    );
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    Align(
                                      alignment: const AlignmentDirectional(
                                        -1.0,
                                        0.0,
                                      ),
                                      child: FlutterFlowDropDown<String>(
                                        controller:
                                            _model.assistanceTypeValueController ??=
                                                FormFieldController<String>(
                                                  _model.assistanceTypeValue ??=
                                                      'Physical',
                                                ),
                                        options: [
                                          'Physical',
                                          'Verbal (Visually impaired)',
                                        ],
                                        onChanged: (val) => setState(
                                          () =>
                                              _model.assistanceTypeValue = val,
                                        ),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: FlutterFlowTheme.of(
                                                context,
                                              ).labelMediumFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey(
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).labelMediumFamily,
                                                      ),
                                            ),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).secondaryText,
                                          size: 24.0,
                                        ),
                                        fillColor: FlutterFlowTheme.of(
                                          context,
                                        ).secondaryBackground,
                                        elevation: 2.0,
                                        borderColor: FlutterFlowTheme.of(
                                          context,
                                        ).primaryBackground,
                                        borderWidth: 2.0,
                                        borderRadius: 40.0,
                                        margin:
                                            const EdgeInsetsDirectional.fromSTEB(
                                              16.0,
                                              0.0,
                                              16.0,
                                              0.0,
                                            ),
                                        hidesUnderline: true,
                                        isOverButton: true,
                                        isSearchable: false,
                                        isMultiSelect: false,
                                        labelText: 'Assistance Type',
                                        labelTextStyle:
                                            FlutterFlowTheme.of(
                                              context,
                                            ).labelSmall.override(
                                              fontFamily: FlutterFlowTheme.of(
                                                context,
                                              ).labelSmallFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey(
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).labelSmallFamily,
                                                      ),
                                            ),
                                      ),
                                    ),
                                  ].divide(const SizedBox(height: 5.0)),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      0.0,
                      2.0,
                      0.0,
                      0.0,
                    ),
                    child: FFButtonWidget(
                      onPressed: () async {
                        if (_model.formKey3.currentState == null ||
                            !_model.formKey3.currentState!.validate()) {
                          return;
                        }
                        if (true) {
                          // if (_model.passwordResidentTextController.text == _model.cfmPasswordResidentTextController.text) {
                          if (widget.isPermContractor!) {
                            if (_model.formKey1.currentState == null ||
                                !_model.formKey1.currentState!.validate()) {
                              return;
                            }
                            if (_model.dropDownValue == null) {
                              return;
                            }
                            if (((FFAppState().qrBuilding.buildingID == 0)) ||
                                ((FFAppState().qrBuilding.floorID == 0))) {
                              _model.qrValid = true;
                              setState(() {});
                            } else {
                              if (_model.swPeepValue!) {
                                if (_model.formKey2.currentState == null ||
                                    !_model.formKey2.currentState!.validate()) {
                                  return;
                                }
                                if (_model.peepTypeValue == null) {
                                  return;
                                }
                                if (_model.assistanceTypeValue == null) {
                                  return;
                                }
                                _model.resVisitor = await EvacProjGroup
                                    .registerVisitorCall
                                    .call(
                                      building:
                                          FFAppState().qrBuilding.buildingID,
                                      floor: FFAppState().qrBuilding.floorID,
                                      flat: FFAppState().qrBuilding.roomID
                                          .toString(),
                                      name: _model.fullNameTextController.text,
                                      email: _model
                                          .emailAddressRegisterTextController
                                          .text,
                                      mobileNumber: _model
                                          .mobileNumberTextController
                                          .text,
                                      password: _model
                                          .passwordResidentTextController
                                          .text,
                                      days: functions
                                          .convertListToCommaSeparatedString(
                                            _model.dropDownValue?.toList(),
                                          ),
                                      arrivalTime:
                                          _model.arrivalTimeTextController.text,
                                      departureTime: _model
                                          .departureTimeTextController
                                          .text,
                                      isPeep: 'True',
                                      nomineeName:
                                          _model.nomineeNameTextController.text,
                                      nomineeContact: _model
                                          .nomineeContactTextController
                                          .text,
                                      peepType: _model.peepTypeValue,
                                      expirationDate:
                                          _model.peepTypeValue == 'Permanent'
                                          ? '1000-10-10'
                                          : _model
                                                .expirationDateTextController
                                                .text,
                                      reviewDate:
                                          _model.peepTypeValue == 'Permanent'
                                          ? '1000-10-10'
                                          : _model
                                                .reviewDateTextController
                                                .text,
                                      assistanceType:
                                          _model.assistanceTypeValue,
                                    );

                                if ((_model.resVisitor?.succeeded ?? true)) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'User approval pending.',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).primaryText,
                                        ),
                                      ),
                                      duration: const Duration(
                                        milliseconds: 4000,
                                      ),
                                      backgroundColor: FlutterFlowTheme.of(
                                        context,
                                      ).secondary,
                                    ),
                                  );
                                } else {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'User with same credentials already exists.',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).primaryText,
                                        ),
                                      ),
                                      duration: const Duration(
                                        milliseconds: 4000,
                                      ),
                                      backgroundColor: FlutterFlowTheme.of(
                                        context,
                                      ).secondary,
                                    ),
                                  );
                                }
                              } else {
                                _model.resVisitorNoPeep = await EvacProjGroup
                                    .registerVisitorCall
                                    .call(
                                      building:
                                          FFAppState().qrBuilding.buildingID,
                                      floor: FFAppState().qrBuilding.floorID,
                                      flat: FFAppState().qrBuilding.roomID
                                          .toString(),
                                      name: _model.fullNameTextController.text,
                                      email: _model
                                          .emailAddressRegisterTextController
                                          .text,
                                      mobileNumber: _model
                                          .mobileNumberTextController
                                          .text,
                                      password: _model
                                          .passwordResidentTextController
                                          .text,
                                      days: functions
                                          .convertListToCommaSeparatedString(
                                            _model.dropDownValue?.toList(),
                                          ),
                                      arrivalTime:
                                          _model.arrivalTimeTextController.text,
                                      departureTime: _model
                                          .departureTimeTextController
                                          .text,
                                      isPeep: 'False',
                                    );

                                if ((_model.resVisitorNoPeep?.succeeded ??
                                    true)) {
                                  dynamic data = jsonDecode(
                                    _model.resVisitorNoPeep!.bodyText
                                        .toString(),
                                  );
                                  Navigator.pop(context);
                                  await showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return Dialog(
                                        elevation: 0,
                                        insetPadding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        child: GestureDetector(
                                          onTap: () => FocusScope.of(
                                            dialogContext,
                                          ).unfocus(),
                                          child: InformationWidget(
                                            body: data['msg'].toString(),
                                            iconColor: FlutterFlowTheme.of(
                                              context,
                                            ).primary,
                                            heading: ' ',
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'User with same credentials already exists.',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).primaryText,
                                        ),
                                      ),
                                      duration: const Duration(
                                        milliseconds: 4000,
                                      ),
                                      backgroundColor: FlutterFlowTheme.of(
                                        context,
                                      ).secondary,
                                    ),
                                  );
                                }
                              }
                            }
                          } else {
                            if (((FFAppState().qrBuilding.buildingID == 0)) ||
                                ((FFAppState().qrBuilding.floorID == 0)) ||
                                ((FFAppState().qrBuilding.roomID == 0))) {
                              _model.qrValid = true;
                              setState(() {});
                            } else {
                              if (_model.swPeepValue!) {
                                if (_model.formKey2.currentState == null ||
                                    !_model.formKey2.currentState!.validate()) {
                                  return;
                                }
                                if (_model.peepTypeValue == null) {
                                  return;
                                }
                                if (_model.assistanceTypeValue == null) {
                                  return;
                                }
                                _model.resRes = await EvacProjGroup
                                    .registerResidentCall
                                    .call(
                                      name: _model.fullNameTextController.text,
                                      email: _model
                                          .emailAddressRegisterTextController
                                          .text,
                                      mobileNumber: _model
                                          .mobileNumberTextController
                                          .text,
                                      profileImage: _model.uploadedLocalFile,
                                      password: _model
                                          .passwordResidentTextController
                                          .text,
                                      building:
                                          FFAppState().qrBuilding.buildingID,
                                      floor: FFAppState().qrBuilding.floorID,
                                      flat: FFAppState().qrBuilding.roomID,
                                      isPeep: 'True',
                                      nomineeName:
                                          _model.nomineeNameTextController.text,
                                      nomineeContact: _model
                                          .nomineeContactTextController
                                          .text,
                                      peepType: _model.peepTypeValue,
                                      assistanceType:
                                          _model.assistanceTypeValue,
                                      expirationDate:
                                          _model.peepTypeValue == 'Permanent'
                                          ? '1000-10-10'
                                          : _model
                                                .expirationDateTextController
                                                .text,
                                      reviewDate:
                                          _model.peepTypeValue == 'Permanent'
                                          ? '1000-10-10'
                                          : _model
                                                .reviewDateTextController
                                                .text,
                                    );

                                if ((_model.resRes?.succeeded ?? true)) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'User approval pending.',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).primaryText,
                                        ),
                                      ),
                                      duration: const Duration(
                                        milliseconds: 4000,
                                      ),
                                      backgroundColor: FlutterFlowTheme.of(
                                        context,
                                      ).secondary,
                                    ),
                                  );
                                } else {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'User with same credentials already exists.',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).primaryText,
                                        ),
                                      ),
                                      duration: const Duration(
                                        milliseconds: 4000,
                                      ),
                                      backgroundColor: FlutterFlowTheme.of(
                                        context,
                                      ).secondary,
                                    ),
                                  );
                                }
                              } else {
                                _model.resResNoPeep = await EvacProjGroup
                                    .registerResidentCall
                                    .call(
                                      name: _model.fullNameTextController.text,
                                      email: _model
                                          .emailAddressRegisterTextController
                                          .text,
                                      mobileNumber: _model
                                          .mobileNumberTextController
                                          .text,
                                      password: _model
                                          .passwordResidentTextController
                                          .text,
                                      building:
                                          FFAppState().qrBuilding.buildingID,
                                      floor: FFAppState().qrBuilding.floorID,
                                      flat: FFAppState().qrBuilding.roomID,
                                      profileImage: _model.uploadedLocalFile,
                                      peepType: 'False',
                                    );

                                if ((_model.resResNoPeep?.succeeded ?? true)) {
                                  dynamic data = jsonDecode(
                                    _model.resResNoPeep!.bodyText.toString(),
                                  );
                                  Navigator.pop(context);
                                  await showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return Dialog(
                                        elevation: 0,
                                        insetPadding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        child: GestureDetector(
                                          onTap: () => FocusScope.of(
                                            dialogContext,
                                          ).unfocus(),
                                          child: InformationWidget(
                                            body: data['msg'].toString(),
                                            iconColor: FlutterFlowTheme.of(
                                              context,
                                            ).primary,
                                            heading: ' ',
                                          ),
                                        ),
                                      );
                                    },
                                  );

                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(
                                  //     content: Text(
                                  //       data['msg'].toString(),
                                  //       style: TextStyle(
                                  //         color: FlutterFlowTheme.of(context)
                                  //             .primaryText,
                                  //       ),
                                  //     ),
                                  //     duration:
                                  //         const Duration(milliseconds: 4000),
                                  //     backgroundColor:
                                  //         FlutterFlowTheme.of(context)
                                  //             .secondary,
                                  //   ),
                                  // );
                                } else {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'User with same credentials already exists.',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).primaryText,
                                        ),
                                      ),
                                      duration: const Duration(
                                        milliseconds: 4000,
                                      ),
                                      backgroundColor: FlutterFlowTheme.of(
                                        context,
                                      ).secondary,
                                    ),
                                  );
                                }
                              }
                            }
                          }
                        } 

                        setState(() {});
                      },
                      text: 'Submit',
                      icon: const Icon(Icons.arrow_forward_ios, size: 25.0),
                      options: FFButtonOptions(
                        width: 200.0,
                        height: 45.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                        ),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                        ),
                        color: FlutterFlowTheme.of(context).secondaryText,
                        textStyle: FlutterFlowTheme.of(context).titleSmall
                            .override(
                              fontFamily: FlutterFlowTheme.of(
                                context,
                              ).titleSmallFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleSmallFamily,
                              ),
                            ),
                        elevation: 5.0,
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).secondaryText,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 20.0,
                buttonSize: 40.0,
                icon: Icon(
                  Icons.cancel,
                  color: FlutterFlowTheme.of(context).error,
                ),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
    );
  }
}
