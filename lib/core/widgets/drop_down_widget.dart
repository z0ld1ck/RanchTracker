// import 'package:awesome_extensions/awesome_extensions.dart' hide StringExtension, NavigatorExt;
// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:super_app/app_localizations.dart';
// import 'package:super_app/core/functions/extensions.dart';
// import 'package:super_app/core/components/text_field_floating_label.dart';
// import 'package:super_app/core/constants/app_colors.dart';
// import 'package:super_app/core/constants/app_text_styles.dart';
// import 'package:super_app/features/app/theme_provider.dart';
//
// class DropdownTextFieldWidget extends StatefulWidget {
//   const DropdownTextFieldWidget({
//     super.key,
//     this.controller,
//     required this.isRequired,
//     required this.label,
//     required this.hint,
//     required this.options,
//     required this.optionsString,
//     this.canEdit = false,
//     this.onChanged,
//     this.selectedOptions,
//   });
//
//   final TextEditingController? controller;
//   final bool isRequired;
//   final String label;
//   final String hint;
//   final List<dynamic> options;
//   final List<dynamic>? selectedOptions;
//   final List<String> optionsString;
//   final bool canEdit;
//   final Function(String value)? onChanged;
//
//   @override
//   State<DropdownTextFieldWidget> createState() => _DropdownTextFieldWidgetState();
// }
//
// class _DropdownTextFieldWidgetState extends State<DropdownTextFieldWidget> {
//   final ScrollController scrollController = ScrollController();
//   List<dynamic> get selectedOptions => widget.selectedOptions ?? [];
//   late final FocusNode focusNode;
//   late final GlobalKey<FormFieldState> validationKey;
//   late final ExpandableController expandableController;
//
//   @override
//   void initState() {
//     super.initState();
//     focusNode = FocusNode()..addListener(() => setState(() {}));
//     validationKey = GlobalKey<FormFieldState>();
//     expandableController = ExpandableController(initialExpanded: false)..addListener(() => setState(() {}));
//   }
//
//   @override
//   void dispose() {
//     focusNode.dispose();
//     validationKey.currentState?.dispose();
//     expandableController.dispose();
//     scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<String> filteredOptionsString = [...widget.optionsString];
//     List<dynamic> filteredOptions = [...widget.options];
//     if (widget.canEdit) {
//       for (int i = 0; i < widget.optionsString.length; i++) {
//         if (!widget.optionsString[i].toLowerCase().contains(widget.controller?.text.toLowerCase() ?? '')) {
//           filteredOptionsString.remove(widget.optionsString[i]);
//           filteredOptions.remove(widget.options[i]);
//         }
//       }
//     }
//     return ExpandableNotifier(
//       controller: expandableController,
//       child: ScrollOnExpand(
//         child: ExpandablePanel(
//           theme: ExpandableThemeData(hasIcon: false),
//           header: ExpandableButton(
//             theme: ExpandableThemeData(useInkWell: false),
//             child: TextFormField(
//               key: validationKey,
//               readOnly: !widget.canEdit,
//               controller: widget.canEdit ? widget.controller : null,
//               focusNode: focusNode,
//               onTap: () {
//                 if (widget.canEdit) {
//                   if (!expandableController.expanded) {
//                     expandableController.toggle();
//                   }
//                 } else {
//                   expandableController.toggle();
//                 }
//               },
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               textInputAction: TextInputAction.done,
//               onChanged: (value) {
//                 if (widget.onChanged != null) widget.onChanged!(value);
//                 validationKey.currentState?.validate();
//                 setState(() {});
//               },
//               validator: widget.isRequired
//                   ? (_) {
//                 return (widget.controller == null || widget.controller!.text.isEmpty)
//                     ? AppLocalizations.of(context)!.fieldCannotBeEmpty.capitalize()
//                     : null;
//               }
//                   : null,
//               style: AppTextStyles.paragraphSmall(context).copyWith(
//                 fontSize: 14.sp,
//                 color: ((widget.controller?.text.isEmpty ?? false) && !widget.canEdit) ? Color(0xFFABAEA2) : null,
//               ),
//               decoration: InputDecoration(
//                 errorStyle: TextStyle(
//                   color: Colors.transparent,
//                   fontSize: 0,
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Color(0xFF4B970F), width: 2.w),
//                   borderRadius: expandableController.expanded && filteredOptions.isNotEmpty
//                       ? BorderRadius.only(
//                     topLeft: Radius.circular(6.r),
//                     topRight: Radius.circular(6.r),
//                   )
//                       : BorderRadius.all(Radius.circular(6.r)),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Color(0xFFE0E2D8)),
//                   borderRadius: expandableController.expanded && filteredOptions.isNotEmpty
//                       ? BorderRadius.only(
//                     topLeft: Radius.circular(6.r),
//                     topRight: Radius.circular(6.r),
//                   )
//                       : BorderRadius.all(Radius.circular(6.r)),
//                 ),
//                 disabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Color(0xFF878882)),
//                   borderRadius: expandableController.expanded && filteredOptions.isNotEmpty
//                       ? BorderRadius.only(
//                     topLeft: Radius.circular(6.r),
//                     topRight: Radius.circular(6.r),
//                   )
//                       : BorderRadius.all(Radius.circular(6.r)),
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: AppColors.error, width: 2.w),
//                   borderRadius: expandableController.expanded && filteredOptions.isNotEmpty
//                       ? BorderRadius.only(
//                     topLeft: Radius.circular(6.r),
//                     topRight: Radius.circular(6.r),
//                   )
//                       : BorderRadius.all(Radius.circular(6.r)),
//                 ),
//                 errorBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: AppColors.error, width: 2.w),
//                   borderRadius: expandableController.expanded && filteredOptions.isNotEmpty
//                       ? BorderRadius.only(
//                     topLeft: Radius.circular(6.r),
//                     topRight: Radius.circular(6.r),
//                   )
//                       : BorderRadius.all(Radius.circular(6.r)),
//                 ),
//                 label: widget.isRequired ? LabelWithAsterisk(label: widget.label) : Text(widget.label),
//                 suffixIcon: InkWell(
//                   onTap: () {
//                     expandableController.toggle();
//                     if (expandableController.expanded)
//                       focusNode.requestFocus();
//                     else
//                       focusNode.unfocus();
//                   },
//                   child: Container(
//                     child: expandableController.expanded
//                         ? Tab(
//                       icon: Image.asset(
//                         'assets/icons/arrow_up.png',
//                         height: 30,
//                         width: 30,
//                         color:
//                         Provider.of<ThemeProviderNotifier>(context).isDarkMode ? Colors.white : Colors.black,
//                       ),
//                     )
//                         : Tab(
//                       icon: Image.asset(
//                         'assets/icons/arrow_down.png',
//                         height: 30,
//                         width: 30,
//                         color:
//                         Provider.of<ThemeProviderNotifier>(context).isDarkMode ? Colors.white : Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//                 hintText: (widget.canEdit && (widget.controller?.text.isNotEmpty ?? false))
//                     ? widget.controller?.text
//                     : (widget.controller?.text.isEmpty ?? true)
//                     ? widget.hint
//                     : filteredOptions.indexOf(widget.controller?.text).isNegative
//                     ? widget.hint
//                     : filteredOptionsString.elementAt(
//                   filteredOptions.indexOf(widget.controller?.text),
//                 ),
//                 hintStyle: Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(
//                   color: (widget.controller?.text.isEmpty ?? true)
//                       ? null
//                       : Theme.of(context).inputDecorationTheme.labelStyle?.color,
//                 ),
//               ),
//             ),
//           ),
//           collapsed: const SizedBox.shrink(),
//           expanded: filteredOptions.isEmpty
//               ? const SizedBox.shrink()
//               : Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(6.r),
//                 bottomRight: Radius.circular(6.r),
//               ),
//               border: Border(
//                 bottom: BorderSide(
//                   width: focusNode.hasFocus ? 2.0 : 1.0,
//                   color: focusNode.hasFocus
//                       ? (validationKey.currentState?.hasError ?? true
//                       ? AppColors.error
//                       : AppColors.primary(context))
//                       : (validationKey.currentState?.hasError ?? true ? AppColors.error : Color(0xFFDFE2D7)),
//                 ),
//                 left: BorderSide(
//                   width: focusNode.hasFocus ? 2.0 : 1.0,
//                   color: focusNode.hasFocus
//                       ? (validationKey.currentState?.hasError ?? true
//                       ? AppColors.error
//                       : AppColors.primary(context))
//                       : (validationKey.currentState?.hasError ?? true ? AppColors.error : Color(0xFFDFE2D7)),
//                 ),
//                 right: BorderSide(
//                   width: focusNode.hasFocus ? 2.0 : 1.0,
//                   color: focusNode.hasFocus
//                       ? (validationKey.currentState?.hasError ?? true
//                       ? AppColors.error
//                       : AppColors.primary(context))
//                       : (validationKey.currentState?.hasError ?? true ? AppColors.error : Color(0xFFDFE2D7)),
//                 ),
//                 top: BorderSide.none,
//               ),
//             ),
//             height: filteredOptions.length > 6 ? 240.h : null,
//             child: RawScrollbar(
//               controller: scrollController,
//               thickness: 5,
//               thumbColor: Color(0xFFDFE2D7),
//               radius: Radius.circular(10.r),
//               child: SingleChildScrollView(
//                 controller: scrollController,
//                 child: Wrap(
//                   children: [
//                     for (int i = 0; i < filteredOptionsString.length; i++)
//                       if (!selectedOptions.contains(filteredOptions[i]))
//                         InkWell(
//                           onTap: () {
//                             widget.controller?.text = filteredOptions[i];
//                             validationKey.currentState?.validate();
//                             expandableController.toggle();
//                             if (widget.canEdit) {
//                               widget.controller?.selection =
//                                   TextSelection.collapsed(offset: widget.controller?.text.length ?? 0);
//                             }
//                             widget.onChanged?.call(filteredOptions[i]);
//                             focusNode.unfocus();
//                             setState(() {});
//                           },
//                           child: Row(
//                             children: [
//                               Container(
//                                 width: 20,
//                                 height: 20,
//                                 decoration: ShapeDecoration(
//                                   shape: OvalBorder(
//                                     side: widget.controller?.text == filteredOptions[i]
//                                         ? BorderSide(width: 6, color: Color(0xFF4B970F))
//                                         : BorderSide(
//                                         width: 1.50,
//                                         color: Provider.of<ThemeProviderNotifier>(context).isDarkMode
//                                             ? Colors.grey
//                                             : Color(0x1E283146)),
//                                   ),
//                                 ),
//                               ).paddingSymmetric(horizontal: 12.w, vertical: 8.h),
//                               Text(filteredOptionsString[i]),
//                             ],
//                           ),
//                         ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }