import '/flutter_flow/custom_functions.dart';
import '../../flutter_flow/nav/nav.dart';
import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/alerts/forgot_password/forgot_password_widget.dart';
import '/components/alerts/register/register_widget.dart';
import '/components/page_elements/building_q_r/building_q_r_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'login_model.dart';
export 'login_model.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late LoginModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginModel());

    if (!isWeb) {
      _keyboardVisibilitySubscription = KeyboardVisibilityController().onChange
          .listen((bool visible) {
            setState(() {});
          });
    }

    _model.emailAddressTextController ??= TextEditingController();
    _model.emailAddressFocusNode ??= FocusNode();

    _model.passwordTextController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();

    _model.fullNameVisitorTextController ??= TextEditingController();
    _model.fullNameVisitorFocusNode ??= FocusNode();

    _model.emailAddressVisitorTextController ??= TextEditingController();
    _model.emailAddressVisitorFocusNode ??= FocusNode();

    _model.mobileNumberVisitorTextController ??= TextEditingController();
    _model.mobileNumberVisitorFocusNode ??= FocusNode();

    _model.timeOutVisitorTextController ??= TextEditingController();
    _model.timeOutVisitorFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
              top: true,
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        5.0,
                        0.0,
                        0.0,
                        0.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              _model.isContractor = false;
                              _model.isTempContractor = false;
                              _model.isFloodContractor = false;

                              setState(() {});
                            },
                            child: Image.asset(
                              'assets/images/logo.83c50365.png',
                              width: 145,
                              height: 145,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Material(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.95,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          15.0,
                          14.0,
                          15.0,
                          10.0,
                        ),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).alternate,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10.0,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              offset: Offset(0.0, 0.0),
                              spreadRadius: 0.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!_model.isContractor &&
                                  !_model.isFloodContractor)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0,
                                    0.0,
                                    0.0,
                                    10.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/user.png',
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.fill,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Sign in',
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily: FlutterFlowTheme.of(
                                                context,
                                              ).labelLargeFamily,
                                              fontSize: 18.0,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (_model.isContractor)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0,
                                    0.0,
                                    0.0,
                                    10.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/user.png',
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.fill,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Register as:',
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily: FlutterFlowTheme.of(
                                                context,
                                              ).labelLargeFamily,
                                              fontSize: 18.0,
                                            ),
                                      ),
                                      if (_model.isTempContractor)
                                        Text(
                                          ' Temporary Contractor',
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                                fontFamily: FlutterFlowTheme.of(
                                                  context,
                                                ).labelLargeFamily,
                                                fontSize: 12.0,
                                              ),
                                        ),
                                      if (_model.isFloodContractor)
                                        Text(
                                          ' Flood Contractor',
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                                fontFamily: FlutterFlowTheme.of(
                                                  context,
                                                ).labelLargeFamily,
                                                fontSize: 12.0,
                                              ),
                                        ),
                                    ],
                                  ),
                                ),
                              if (!_model.isContractor)
                                Form(
                                  key: _model.formKey1,
                                  autovalidateMode: AutovalidateMode.always,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0,
                                          0.0,
                                          0.0,
                                          10.0,
                                        ),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextFormField(
                                            controller: _model
                                                .emailAddressTextController,
                                            focusNode:
                                                _model.emailAddressFocusNode,
                                            onChanged: (_) => EasyDebounce.debounce(
                                              '_model.emailAddressTextController',
                                              Duration(milliseconds: 100),
                                              () => setState(() {}),
                                            ),
                                            autofocus: false,
                                            autofillHints: [
                                              AutofillHints.username,
                                            ],
                                            textInputAction:
                                                TextInputAction.next,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelText: 'Mobile Number',
                                              labelStyle:
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
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                    context,
                                                  ).primaryBackground,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(40.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                    context,
                                                  ).primary,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(40.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                    context,
                                                  ).error,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(40.0),
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
                                              ).accent4,
                                              prefixIcon: Icon(
                                                Icons.person_outline,
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
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
                                            textAlign: TextAlign.start,
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
                                            keyboardType: TextInputType.number,
                                            validator: _model
                                                .emailAddressTextControllerValidator
                                                .asValidator(context),
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                RegExp('[0-9]'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0,
                                          0.0,
                                          0.0,
                                          5.0,
                                        ),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextFormField(
                                            controller:
                                                _model.passwordTextController,
                                            focusNode: _model.passwordFocusNode,
                                            autofocus: false,
                                            autofillHints: [
                                              AutofillHints.password,
                                            ],
                                            textInputAction: TextInputAction.go,
                                            obscureText:
                                                !_model.passwordVisibility,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelText: 'Password',
                                              labelStyle:
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
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                    context,
                                                  ).primaryBackground,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(40.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                    context,
                                                  ).primary,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(40.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                    context,
                                                  ).error,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(40.0),
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
                                              ).accent4,
                                              prefixIcon: Icon(
                                                Icons.lock_outline_sharp,
                                              ),
                                              suffixIcon: InkWell(
                                                onTap: () => setState(
                                                  () => _model.passwordVisibility =
                                                      !_model
                                                          .passwordVisibility,
                                                ),
                                                focusNode: FocusNode(
                                                  skipTraversal: true,
                                                ),
                                                child: Icon(
                                                  _model.passwordVisibility
                                                      ? Icons
                                                            .visibility_outlined
                                                      : Icons
                                                            .visibility_off_outlined,
                                                  color: FlutterFlowTheme.of(
                                                    context,
                                                  ).secondaryText,
                                                  size: 24.0,
                                                ),
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
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
                                            validator: _model
                                                .passwordTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(
                                          1.0,
                                          0.0,
                                        ),
                                        child: Builder(
                                          builder: (context) => InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await showDialog(
                                                context: context,
                                                builder: (dialogContext) {
                                                  return Dialog(
                                                    elevation: 0,
                                                    insetPadding:
                                                        EdgeInsets.zero,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    alignment:
                                                        AlignmentDirectional(
                                                          0.0,
                                                          0.0,
                                                        ).resolve(
                                                          Directionality.of(
                                                            context,
                                                          ),
                                                        ),
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          FocusScope.of(
                                                            dialogContext,
                                                          ).unfocus(),
                                                      child:
                                                          ForgotPasswordWidget(),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Text(
                                              'Forgot Password?',
                                              style:
                                                  FlutterFlowTheme.of(
                                                    context,
                                                  ).bodySmall.override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).bodySmallFamily,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        GoogleFonts.asMap()
                                                            .containsKey(
                                                              FlutterFlowTheme.of(
                                                                context,
                                                              ).bodySmallFamily,
                                                            ),
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(
                                          0.0,
                                          0.0,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                0.0,
                                                5.0,
                                                0.0,
                                                5.0,
                                              ),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              Function() navigate = () {};
                                              if (_model
                                                          .formKey1
                                                          .currentState ==
                                                      null ||
                                                  !_model.formKey1.currentState!
                                                      .validate()) {
                                                return;
                                              }
                                              _model
                                                  .loginResult = await EvacProjGroup
                                                  .loginCall
                                                  .call(
                                                    username: _model
                                                        .emailAddressTextController
                                                        .text,
                                                    password: _model
                                                        .passwordTextController
                                                        .text,
                                                  );

                                              if ((_model
                                                      .loginResult
                                                      ?.succeeded ??
                                                  true)) {
                                                if (EvacProjGroup.loginCall
                                                        .profileStatus(
                                                          (_model
                                                                  .loginResult
                                                                  ?.jsonBody ??
                                                              ''),
                                                        ) ==
                                                    'Approved') {
                                                  FFAppState().updateUserAuthenticationStruct(
                                                    (e) => e
                                                      ..authorization =
                                                          'Bearer ${EvacProjGroup.loginCall.accessToken((_model.loginResult?.jsonBody ?? ''))}'
                                                      ..csrfToken = EvacProjGroup
                                                          .loginCall
                                                          .csrfToken(
                                                            (_model
                                                                    .loginResult
                                                                    ?.jsonBody ??
                                                                ''),
                                                          )
                                                      ..refreshToken = EvacProjGroup
                                                          .loginCall
                                                          .refreshToken(
                                                            (_model
                                                                    .loginResult
                                                                    ?.jsonBody ??
                                                                ''),
                                                          ),
                                                  );
                                                  FFAppState().updateUserStruct(
                                                    (e) => e
                                                      ..displayName = EvacProjGroup
                                                          .loginCall
                                                          .name(
                                                            (_model
                                                                    .loginResult
                                                                    ?.jsonBody ??
                                                                ''),
                                                          )
                                                      ..createTime =
                                                          getCurrentTimestamp
                                                              .toString()
                                                      ..photo = EvacProjGroup
                                                          .loginCall
                                                          .profileImage(
                                                            (_model
                                                                    .loginResult
                                                                    ?.jsonBody ??
                                                                ''),
                                                          )
                                                      ..isVisitor = false
                                                      ..emailAddress = EvacProjGroup
                                                          .loginCall
                                                          .email(
                                                            (_model
                                                                    .loginResult
                                                                    ?.jsonBody ??
                                                                ''),
                                                          )
                                                      ..mobileNumber = EvacProjGroup
                                                          .loginCall
                                                          .mobileNumber(
                                                            (_model
                                                                    .loginResult
                                                                    ?.jsonBody ??
                                                                ''),
                                                          )
                                                      ..uid = EvacProjGroup
                                                          .loginCall
                                                          .uid(
                                                            (_model
                                                                    .loginResult
                                                                    ?.jsonBody ??
                                                                ''),
                                                          )
                                                      ..isPeep = EvacProjGroup
                                                          .loginCall
                                                          .isPeep(
                                                            (_model
                                                                    .loginResult
                                                                    ?.jsonBody ??
                                                                ''),
                                                          )
                                                      ..userType = EvacProjGroup
                                                          .loginCall
                                                          .userType(
                                                            (_model
                                                                    .loginResult
                                                                    ?.jsonBody ??
                                                                ''),
                                                          ),
                                                  );
                                                  setState(() {});
                                                  _model.resUserAddress =
                                                      await EvacProjAfterLoginGroup
                                                          .getActiveFlatCall
                                                          .call(
                                                            authToken: FFAppState()
                                                                .userAuthentication
                                                                .authorization,
                                                          );

                                                  // Log the response for debugging

                                                  // Check if the call succeeded and the response has data
                                                  if ((_model
                                                              .resUserAddress
                                                              ?.succeeded ??
                                                          false) &&
                                                      _model
                                                              .resUserAddress
                                                              ?.jsonBody !=
                                                          null) {
                                                    // Extract building, floor, and flat from the response
                                                    final building =
                                                        EvacProjAfterLoginGroup
                                                            .getActiveFlatCall
                                                            .building(
                                                              _model
                                                                      .resUserAddress
                                                                      ?.jsonBody ??
                                                                  '',
                                                            );
                                                    final floor =
                                                        EvacProjAfterLoginGroup
                                                            .getActiveFlatCall
                                                            .floor(
                                                              _model
                                                                      .resUserAddress
                                                                      ?.jsonBody ??
                                                                  '',
                                                            );
                                                    final flat =
                                                        EvacProjAfterLoginGroup
                                                            .getActiveFlatCall
                                                            .flat(
                                                              _model
                                                                      .resUserAddress
                                                                      ?.jsonBody ??
                                                                  '',
                                                            );

                                                    // Log the extracted values to verify

                                                    // Update the app state if values are present
                                                    if (building != null &&
                                                        floor != null &&
                                                        flat != null) {
                                                      FFAppState().loginHeader =
                                                          generateAddress(
                                                            building,
                                                            floor,
                                                            flat,
                                                          );
                                                    } else {
                                                    }
                                                  } else {
                                                  }
                                                  //FFAppState().loginHeader
                                                  setState(() {});
                                                  GoRouter.of(
                                                    context,
                                                  ).prepareAuthEvent();
                                                  await authManager.signIn(
                                                    authenticationToken:
                                                        EvacProjGroup.loginCall
                                                            .accessToken(
                                                              (_model
                                                                      .loginResult
                                                                      ?.jsonBody ??
                                                                  ''),
                                                            ),
                                                    refreshToken: EvacProjGroup
                                                        .loginCall
                                                        .refreshToken(
                                                          (_model
                                                                  .loginResult
                                                                  ?.jsonBody ??
                                                              ''),
                                                        ),
                                                    authUid: EvacProjGroup
                                                        .loginCall
                                                        .uid(
                                                          (_model
                                                                  .loginResult
                                                                  ?.jsonBody ??
                                                              ''),
                                                        )
                                                        ?.toString(),
                                                    userData: UserStruct(
                                                      displayName: EvacProjGroup
                                                          .loginCall
                                                          .name(
                                                            (_model
                                                                    .loginResult
                                                                    ?.jsonBody ??
                                                                ''),
                                                          ),
                                                      isVisitor: false,
                                                      uid: EvacProjGroup
                                                          .loginCall
                                                          .uid(
                                                            (_model
                                                                    .loginResult
                                                                    ?.jsonBody ??
                                                                ''),
                                                          ),
                                                      mobileNumber: EvacProjGroup
                                                          .loginCall
                                                          .mobileNumber(
                                                            (_model
                                                                    .loginResult
                                                                    ?.jsonBody ??
                                                                ''),
                                                          ),
                                                      isPeep: EvacProjGroup
                                                          .loginCall
                                                          .isPeep(
                                                            (_model
                                                                    .loginResult
                                                                    ?.jsonBody ??
                                                                ''),
                                                          ),
                                                      photo: EvacProjGroup
                                                          .loginCall
                                                          .profileImage(
                                                            (_model
                                                                    .loginResult
                                                                    ?.jsonBody ??
                                                                ''),
                                                          ),
                                                      emailAddress: EvacProjGroup
                                                          .loginCall
                                                          .email(
                                                            (_model
                                                                    .loginResult
                                                                    ?.jsonBody ??
                                                                ''),
                                                          ),
                                                      createTime:
                                                          getCurrentTimestamp
                                                              .toString(),
                                                    ),
                                                  );
                                                  navigate = () =>
                                                      context.goNamedAuth(
                                                        'dashboard',
                                                        queryParameters: {
                                                          'initNotifications':
                                                              true.toString(),
                                                        },
                                                        context.mounted,
                                                      );
                                                } else {
                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'User approval pending. Please contact site administrator.',
                                                        style: TextStyle(
                                                          color:
                                                              FlutterFlowTheme.of(
                                                                context,
                                                              ).primaryText,
                                                        ),
                                                      ),
                                                      duration: Duration(
                                                        milliseconds: 4000,
                                                      ),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                            context,
                                                          ).secondary,
                                                    ),
                                                  );
                                                }
                                              } else {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Invalid credentials provided.',
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                              context,
                                                            ).primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                      milliseconds: 4000,
                                                    ),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).secondary,
                                                  ),
                                                );
                                              }

                                              navigate();

                                              setState(() {});
                                            },
                                            text: 'Sign In',
                                            icon: FaIcon(
                                              FontAwesomeIcons.rightToBracket,
                                              size: 20.0,
                                            ),
                                            options: FFButtonOptions(
                                              width: 200.0,
                                              height: 45.0,
                                              padding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    0.0,
                                                    0.0,
                                                    0.0,
                                                  ),
                                              iconPadding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    0.0,
                                                    0.0,
                                                    0.0,
                                                  ),
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).secondaryText,
                                              textStyle:
                                                  FlutterFlowTheme.of(
                                                    context,
                                                  ).titleSmall.override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).titleSmallFamily,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        GoogleFonts.asMap()
                                                            .containsKey(
                                                              FlutterFlowTheme.of(
                                                                context,
                                                              ).titleSmallFamily,
                                                            ),
                                                  ),
                                              elevation: 5.0,
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(
                                                  context,
                                                ).secondaryText,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (_model.isContractor)
                                Column(
                                  children: [
                                    if (_model.isTempContractor ||
                                        _model
                                            .isFloodContractor) // Temp Contractor Form
                                      Form(
                                        key: _model.formKey2,
                                        autovalidateMode:
                                            AutovalidateMode.disabled,
                                        child: Column(
                                          children: [
                                            wrapWithModel(
                                              model: _model.buildingQRModel,
                                              updateCallback: () =>
                                                  setState(() {}),
                                              child: BuildingQRWidget(
                                                showDropdown: false,
                                              ),
                                            ),
                                            SizedBox(
                                              width: double.infinity,
                                              child: TextFormField(
                                                controller: _model
                                                    .fullNameVisitorTextController,
                                                focusNode: _model
                                                    .fullNameVisitorFocusNode,
                                                autofocus: false,
                                                autofillHints: [
                                                  AutofillHints.name,
                                                ],
                                                textCapitalization:
                                                    TextCapitalization.words,
                                                textInputAction:
                                                    TextInputAction.next,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelText: 'Full name',
                                                  labelStyle:
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
                                                  prefixIcon: Icon(
                                                    Icons.person_outline,
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
                                                    TextInputType.name,
                                                validator: _model
                                                    .fullNameVisitorTextControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ),
                                            SizedBox(
                                              width: double.infinity,
                                              child: TextFormField(
                                                controller: _model
                                                    .emailAddressVisitorTextController,
                                                focusNode: _model
                                                    .emailAddressVisitorFocusNode,
                                                autofocus: false,
                                                autofillHints: [
                                                  AutofillHints.email,
                                                ],
                                                textCapitalization:
                                                    TextCapitalization.none,
                                                textInputAction:
                                                    TextInputAction.next,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelText: 'Email address',
                                                  labelStyle:
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
                                                  prefixIcon: Icon(
                                                    Icons.email_outlined,
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
                                                    .emailAddressVisitorTextControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ),
                                            SizedBox(
                                              width: double.infinity,
                                              child: TextFormField(
                                                controller: _model
                                                    .mobileNumberVisitorTextController,
                                                focusNode: _model
                                                    .mobileNumberVisitorFocusNode,
                                                autofocus: false,
                                                autofillHints: [
                                                  AutofillHints.telephoneNumber,
                                                ],
                                                textInputAction:
                                                    TextInputAction.next,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelText: 'Mobile number',
                                                  labelStyle:
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
                                                  prefixIcon: Icon(Icons.phone),
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
                                                maxLength: 10,
                                                maxLengthEnforcement:
                                                    MaxLengthEnforcement
                                                        .enforced,
                                                buildCounter:
                                                    (
                                                      context, {
                                                      required currentLength,
                                                      required isFocused,
                                                      maxLength,
                                                    }) => null,
                                                keyboardType:
                                                    TextInputType.phone,
                                                validator: _model
                                                    .mobileNumberVisitorTextControllerValidator
                                                    .asValidator(context),
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(
                                                    RegExp('[0-9]'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .timeOutVisitorTextController,
                                                      focusNode: _model
                                                          .timeOutVisitorFocusNode,
                                                      autofocus: false,
                                                      readOnly: true,
                                                      obscureText: false,
                                                      decoration: InputDecoration(
                                                        isDense: true,
                                                        labelText:
                                                            'Expected Time-out',
                                                        labelStyle:
                                                            FlutterFlowTheme.of(
                                                              context,
                                                            ).labelSmall.override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                    context,
                                                                  ).labelSmallFamily,
                                                              letterSpacing:
                                                                  0.0,
                                                              useGoogleFonts: GoogleFonts.asMap()
                                                                  .containsKey(
                                                                    FlutterFlowTheme.of(
                                                                      context,
                                                                    ).labelSmallFamily,
                                                                  ),
                                                            ),
                                                        enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: FlutterFlowTheme.of(
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
                                                        prefixIcon: Icon(
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
                                                          TextInputType
                                                              .datetime,
                                                      validator: _model
                                                          .timeOutVisitorTextControllerValidator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.fromSTEB(
                                                        5.0,
                                                        0.0,
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: FlutterFlowIconButton(
                                                    borderColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).primaryText,
                                                    borderRadius: 20.0,
                                                    borderWidth: 1.0,
                                                    buttonSize: 40.0,
                                                    fillColor:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).secondaryBackground,
                                                    icon: Icon(
                                                      Icons.calendar_month,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                            context,
                                                          ).primaryText,
                                                      size: 24.0,
                                                    ),
                                                    onPressed: () async {
                                                      final datePickedDate = await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            getCurrentTimestamp,
                                                        firstDate:
                                                            getCurrentTimestamp,
                                                        lastDate: DateTime(
                                                          2050,
                                                        ),
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
                                                                  fontSize:
                                                                      32.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  useGoogleFonts:
                                                                      GoogleFonts.asMap().containsKey(
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

                                                      TimeOfDay? datePickedTime;
                                                      if (datePickedDate !=
                                                          null) {
                                                        datePickedTime = await showTimePicker(
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
                                                                    fontSize:
                                                                        32.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    useGoogleFonts: GoogleFonts.asMap().containsKey(
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
                                                      }

                                                      if (datePickedDate !=
                                                              null &&
                                                          datePickedTime !=
                                                              null) {
                                                        safeSetState(() {
                                                          _model.datePicked =
                                                              DateTime(
                                                                datePickedDate
                                                                    .year,
                                                                datePickedDate
                                                                    .month,
                                                                datePickedDate
                                                                    .day,
                                                                datePickedTime!
                                                                    .hour,
                                                                datePickedTime
                                                                    .minute,
                                                              );
                                                        });
                                                      }
                                                      setState(() {
                                                        _model
                                                            .timeOutVisitorTextController
                                                            ?.text = dateTimeFormat(
                                                          "yyyy-MM-dd HH:mm:ss",
                                                          _model.datePicked,
                                                          locale:
                                                              FFLocalizations.of(
                                                                context,
                                                              ).languageCode,
                                                        );
                                                        _model
                                                                .timeOutVisitorTextController
                                                                ?.selection =
                                                            TextSelection.collapsed(
                                                              offset: _model
                                                                  .timeOutVisitorTextController!
                                                                  .text
                                                                  .length,
                                                            );
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                0.0,
                                                0.0,
                                              ),
                                              child: Padding(
                                                padding:
                                                    EdgeInsetsDirectional.fromSTEB(
                                                      0.0,
                                                      10.0,
                                                      0.0,
                                                      10.0,
                                                    ),
                                                child: FFButtonWidget(
                                                  onPressed: () async {
                                                    Function() navigate = () {};
                                                    if (_model
                                                                .formKey2
                                                                .currentState ==
                                                            null ||
                                                        !_model
                                                            .formKey2
                                                            .currentState!
                                                            .validate()) {
                                                      return;
                                                    }
                                                    if ((FFAppState()
                                                                .qrBuilding
                                                                .buildingID ==
                                                            0) ||
                                                        (FFAppState()
                                                                .qrBuilding
                                                                .floorID ==
                                                            0)) {
                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Scan a QR code to continue.',
                                                            style: TextStyle(
                                                              color:
                                                                  FlutterFlowTheme.of(
                                                                    context,
                                                                  ).primaryText,
                                                            ),
                                                          ),
                                                          duration: Duration(
                                                            milliseconds: 4000,
                                                          ),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                context,
                                                              ).secondary,
                                                        ),
                                                      );
                                                    } else {
                                                      if (_model
                                                          .isTempContractor) {
                                                        _model
                                                            .apiResultVisitor = await EvacProjGroup
                                                            .registerVisitorCall
                                                            .call(
                                                              building:
                                                                  FFAppState()
                                                                      .qrBuilding
                                                                      .buildingID,
                                                              floor: FFAppState()
                                                                  .qrBuilding
                                                                  .floorID,
                                                              flat: FFAppState()
                                                                  .qrBuilding
                                                                  .roomID
                                                                  .toString(),
                                                              name: _model
                                                                  .fullNameVisitorTextController
                                                                  .text,
                                                              departureTime: _model
                                                                  .timeOutVisitorTextController
                                                                  .text,
                                                              email: _model
                                                                  .emailAddressVisitorTextController
                                                                  .text,
                                                              mobileNumber: _model
                                                                  .mobileNumberVisitorTextController
                                                                  .text,
                                                            );
                                                      }
                                                      if (_model
                                                          .isFloodContractor) {
                                                        _model
                                                            .apiResultVisitor = await EvacProjGroup
                                                            .registerFloodContractorCall
                                                            .call(
                                                              building:
                                                                  FFAppState()
                                                                      .qrBuilding
                                                                      .buildingID,
                                                              floor: FFAppState()
                                                                  .qrBuilding
                                                                  .floorID,
                                                              flat: FFAppState()
                                                                  .qrBuilding
                                                                  .roomID
                                                                  .toString(),
                                                              name: _model
                                                                  .fullNameVisitorTextController
                                                                  .text,
                                                              departureTime: _model
                                                                  .timeOutVisitorTextController
                                                                  .text,
                                                              email: _model
                                                                  .emailAddressVisitorTextController
                                                                  .text,
                                                              mobileNumber: _model
                                                                  .mobileNumberVisitorTextController
                                                                  .text,
                                                            );
                                                      }

                                                      if ((_model
                                                              .apiResultVisitor
                                                              ?.succeeded ??
                                                          true)) {
                                                        FFAppState().updateUserAuthenticationStruct(
                                                          (e) => e
                                                            ..authorization =
                                                                'Bearer ${EvacProjGroup.registerVisitorCall.accessToken((_model.apiResultVisitor?.jsonBody ?? ''))}'
                                                            ..csrfToken = EvacProjGroup
                                                                .registerVisitorCall
                                                                .csrfToken(
                                                                  (_model
                                                                          .apiResultVisitor
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                )
                                                            ..refreshToken = EvacProjGroup
                                                                .registerVisitorCall
                                                                .refreshToken(
                                                                  (_model
                                                                          .apiResultVisitor
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                ),
                                                        );
                                                        FFAppState().updateUserStruct(
                                                          (e) => e
                                                            ..displayName = EvacProjGroup
                                                                .registerVisitorCall
                                                                .name(
                                                                  (_model
                                                                          .apiResultVisitor
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                )
                                                            ..createTime =
                                                                getCurrentTimestamp
                                                                    .toString()
                                                            ..photo = EvacProjGroup
                                                                .registerVisitorCall
                                                                .photo(
                                                                  (_model
                                                                          .apiResultVisitor
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                )
                                                            ..isVisitor = true
                                                            ..emailAddress = _model
                                                                .emailAddressVisitorTextController
                                                                .text
                                                            ..mobileNumber = _model
                                                                .mobileNumberVisitorTextController
                                                                .text
                                                            ..uid = EvacProjGroup
                                                                .registerVisitorCall
                                                                .uid(
                                                                  (_model
                                                                          .apiResultVisitor
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                )
                                                            ..isPeep = false
                                                            ..userType = EvacProjGroup
                                                                .registerVisitorCall
                                                                .status(
                                                                  (_model
                                                                          .apiResultVisitor
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                )
                                                            ..arrivalTime =
                                                                getCurrentTimestamp
                                                            ..departureTime =
                                                                _model
                                                                    .datePicked,
                                                        );
                                                        FFAppState()
                                                                .visitorBuilding =
                                                            FFAppState()
                                                                .qrBuilding;
                                                        if (_model
                                                            .isTempContractor) {
                                                          FFAppState()
                                                                  .isTempVisitor =
                                                              true;
                                                        }
                                                        if (_model
                                                            .isFloodContractor) {
                                                          FFAppState()
                                                                  .isFloodVisitor =
                                                              true;
                                                        }
                                                        setState(() {});
                                                        GoRouter.of(
                                                          context,
                                                        ).prepareAuthEvent();
                                                        await authManager.signIn(
                                                          authenticationToken: EvacProjGroup
                                                              .registerVisitorCall
                                                              .accessToken(
                                                                (_model
                                                                        .apiResultVisitor
                                                                        ?.jsonBody ??
                                                                    ''),
                                                              ),
                                                          refreshToken: EvacProjGroup
                                                              .registerVisitorCall
                                                              .refreshToken(
                                                                (_model
                                                                        .apiResultVisitor
                                                                        ?.jsonBody ??
                                                                    ''),
                                                              ),
                                                          authUid: EvacProjGroup
                                                              .registerVisitorCall
                                                              .uid(
                                                                (_model
                                                                        .apiResultVisitor
                                                                        ?.jsonBody ??
                                                                    ''),
                                                              )
                                                              ?.toString(),
                                                          userData: UserStruct(
                                                            displayName: EvacProjGroup
                                                                .registerVisitorCall
                                                                .name(
                                                                  (_model
                                                                          .apiResultVisitor
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                ),
                                                            isVisitor: true,
                                                            emailAddress: _model
                                                                .emailAddressVisitorTextController
                                                                .text,
                                                            mobileNumber: _model
                                                                .mobileNumberVisitorTextController
                                                                .text,
                                                            createTime:
                                                                getCurrentTimestamp
                                                                    .toString(),
                                                            uid: EvacProjGroup
                                                                .registerVisitorCall
                                                                .uid(
                                                                  (_model
                                                                          .apiResultVisitor
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                ),
                                                          ),
                                                        );
                                                        navigate = () =>
                                                            context.goNamedAuth(
                                                              'dashboard',
                                                              queryParameters: {
                                                                'initNotifications':
                                                                    true.toString(),
                                                              },
                                                              context.mounted,
                                                            );
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                          context,
                                                        ).showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'Error inserting record.',
                                                              style: TextStyle(
                                                                color:
                                                                    FlutterFlowTheme.of(
                                                                      context,
                                                                    ).primaryText,
                                                              ),
                                                            ),
                                                            duration: Duration(
                                                              milliseconds:
                                                                  4000,
                                                            ),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                  context,
                                                                ).secondary,
                                                          ),
                                                        );
                                                      }
                                                    }

                                                    navigate();

                                                    setState(() {});
                                                  },
                                                  text: 'Submit',
                                                  icon: FaIcon(
                                                    FontAwesomeIcons
                                                        .rightToBracket,
                                                    size: 20.0,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: 200.0,
                                                    height: 45.0,
                                                    padding:
                                                        EdgeInsetsDirectional.fromSTEB(
                                                          0.0,
                                                          0.0,
                                                          0.0,
                                                          0.0,
                                                        ),
                                                    iconPadding:
                                                        EdgeInsetsDirectional.fromSTEB(
                                                          0.0,
                                                          0.0,
                                                          0.0,
                                                          0.0,
                                                        ),
                                                    color: FlutterFlowTheme.of(
                                                      context,
                                                    ).secondaryText,
                                                    textStyle:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).titleSmall.override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                context,
                                                              ).titleSmallFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              GoogleFonts.asMap()
                                                                  .containsKey(
                                                                    FlutterFlowTheme.of(
                                                                      context,
                                                                    ).titleSmallFamily,
                                                                  ),
                                                        ),
                                                    elevation: 5.0,
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                            context,
                                                          ).secondaryText,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          40.0,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ].divide(SizedBox(height: 5.0)),
                                        ),
                                      ),
                                  ],
                                ),
                              if (_model.isContractor &&
                                  !_model.isTempContractor &&
                                  !_model.isFloodContractor)
                                Column(
                                  children: [
                                    Builder(
                                      builder: (context) => Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0,
                                          0.0,
                                          0.0,
                                          5.0,
                                        ),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            await showDialog(
                                              context: context,
                                              builder: (dialogContext) {
                                                return Dialog(
                                                  elevation: 0,
                                                  insetPadding: EdgeInsets.zero,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  alignment:
                                                      AlignmentDirectional(
                                                        0.0,
                                                        0.0,
                                                      ).resolve(
                                                        Directionality.of(
                                                          context,
                                                        ),
                                                      ),
                                                  child: GestureDetector(
                                                    onTap: () => FocusScope.of(
                                                      dialogContext,
                                                    ).unfocus(),
                                                    child: RegisterWidget(
                                                      isPermContractor: true,
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              20.0,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.of(
                                                  context,
                                                ).secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: 80.0,
                                                      height: 80.0,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.asset(
                                                        'assets/images/PermContractor.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional.fromSTEB(
                                                            8.0,
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                          ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Permanent Contractor',
                                                            style:
                                                                FlutterFlowTheme.of(
                                                                  context,
                                                                ).labelLarge.override(
                                                                  fontFamily:
                                                                      FlutterFlowTheme.of(
                                                                        context,
                                                                      ).labelLargeFamily,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  useGoogleFonts:
                                                                      GoogleFonts.asMap().containsKey(
                                                                        FlutterFlowTheme.of(
                                                                          context,
                                                                        ).labelLargeFamily,
                                                                      ),
                                                                ),
                                                          ),
                                                          Container(
                                                            width:
                                                                MediaQuery.sizeOf(
                                                                  context,
                                                                ).width *
                                                                0.6,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Text(
                                                              'Carries out tasks in a building according to a set schedule with defined entry and exit times',
                                                              textAlign:
                                                                  TextAlign
                                                                      .justify,
                                                              maxLines: 3,
                                                              style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                fontFamily:
                                                                    FlutterFlowTheme.of(
                                                                      context,
                                                                    ).labelSmallFamily,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts: GoogleFonts.asMap()
                                                                    .containsKey(
                                                                      FlutterFlowTheme.of(
                                                                        context,
                                                                      ).labelSmallFamily,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0,
                                        0.0,
                                        0.0,
                                        5.0,
                                      ),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.isTempContractor = true;
                                          setState(() {});
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            20.0,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 80.0,
                                                    height: 80.0,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.asset(
                                                      'assets/images/TempContractor.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional.fromSTEB(
                                                          8.0,
                                                          0.0,
                                                          0.0,
                                                          0.0,
                                                        ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Temporary Contractor ',
                                                          style:
                                                              FlutterFlowTheme.of(
                                                                context,
                                                              ).labelLarge.override(
                                                                fontFamily:
                                                                    FlutterFlowTheme.of(
                                                                      context,
                                                                    ).labelLargeFamily,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                useGoogleFonts: GoogleFonts.asMap()
                                                                    .containsKey(
                                                                      FlutterFlowTheme.of(
                                                                        context,
                                                                      ).labelLargeFamily,
                                                                    ),
                                                              ),
                                                        ),
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                context,
                                                              ).width *
                                                              0.6,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Text(
                                                            'Performs tasks in a building for a short, specified period and departs upon completion',
                                                            textAlign: TextAlign
                                                                .justify,
                                                            maxLines: 3,
                                                            style:
                                                                FlutterFlowTheme.of(
                                                                  context,
                                                                ).labelSmall.override(
                                                                  fontFamily:
                                                                      FlutterFlowTheme.of(
                                                                        context,
                                                                      ).labelSmallFamily,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      GoogleFonts.asMap().containsKey(
                                                                        FlutterFlowTheme.of(
                                                                          context,
                                                                        ).labelSmallFamily,
                                                                      ),
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        _model.isFloodContractor = true;
                                        setState(() {});
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          20.0,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).secondaryBackground,
                                            borderRadius: BorderRadius.circular(
                                              20.0,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 80.0,
                                                  height: 80.0,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/FloodContractor.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.fromSTEB(
                                                        8.0,
                                                        0.0,
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Flood Contractor ',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                              context,
                                                            ).labelLarge.override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                    context,
                                                                  ).labelLargeFamily,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              useGoogleFonts: GoogleFonts.asMap()
                                                                  .containsKey(
                                                                    FlutterFlowTheme.of(
                                                                      context,
                                                                    ).labelLargeFamily,
                                                                  ),
                                                            ),
                                                      ),
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                              context,
                                                            ).width *
                                                            0.6,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Text(
                                                          'Enters building to perform plumbing tasks in response to a flood alert raised by a resident',
                                                          textAlign:
                                                              TextAlign.justify,
                                                          maxLines: 3,
                                                          style:
                                                              FlutterFlowTheme.of(
                                                                context,
                                                              ).labelSmall.override(
                                                                fontFamily:
                                                                    FlutterFlowTheme.of(
                                                                      context,
                                                                    ).labelSmallFamily,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts: GoogleFonts.asMap()
                                                                    .containsKey(
                                                                      FlutterFlowTheme.of(
                                                                        context,
                                                                      ).labelSmallFamily,
                                                                    ),
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              // You will have to add an action on this rich text to go to your login page.
                              if (!_model.isContractor)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0,
                                    5.0,
                                    0.0,
                                    5.0,
                                  ),
                                  child: RichText(
                                    textScaler: MediaQuery.of(
                                      context,
                                    ).textScaler,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Don\'t have an account?  ',
                                          style: TextStyle(),
                                        ),
                                        TextSpan(
                                          text: 'Register',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: FlutterFlowTheme.of(
                                                  context,
                                                ).bodyMediumFamily,
                                                color: FlutterFlowTheme.of(
                                                  context,
                                                ).primary,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts:
                                                    GoogleFonts.asMap()
                                                        .containsKey(
                                                          FlutterFlowTheme.of(
                                                            context,
                                                          ).bodyMediumFamily,
                                                        ),
                                              ),
                                          mouseCursor: SystemMouseCursors.click,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              await showDialog(
                                                context: context,
                                                builder: (dialogContext) {
                                                  return Dialog(
                                                    elevation: 0,
                                                    insetPadding:
                                                        EdgeInsets.zero,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    alignment:
                                                        AlignmentDirectional(
                                                          0.0,
                                                          0.0,
                                                        ).resolve(
                                                          Directionality.of(
                                                            context,
                                                          ),
                                                        ),
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          FocusScope.of(
                                                            dialogContext,
                                                          ).unfocus(),
                                                      child: RegisterWidget(
                                                        isPermContractor: false,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                        ),
                                      ],
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(
                                              context,
                                            ).labelMediumFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                  FlutterFlowTheme.of(
                                                    context,
                                                  ).labelMediumFamily,
                                                ),
                                          ),
                                    ),
                                  ),
                                ),

                              //if (!_model.isContractor)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (!isKeyboardVisible)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                          10.0,
                          0.0,
                          10.0,
                          10.0,
                        ),
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 60.0,
                          child: custom_widgets.SlideToAct(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: 60.0,
                            text: _model.isContractor
                                ? 'Sign In'
                                : 'Register as Contractor',
                            innerColor: FlutterFlowTheme.of(
                              context,
                            ).primaryBackground,
                            outerColor: FlutterFlowTheme.of(context).alternate,
                            iconSize: 5.0,
                            textColor: FlutterFlowTheme.of(
                              context,
                            ).secondaryText,
                            onSubmit: () async {
                              _model.isContractor = !_model.isContractor;
                              _model.isTempContractor = false;
                              _model.isFloodContractor = false;

                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
