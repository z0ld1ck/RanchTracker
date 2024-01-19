import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:collection/collection.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/widgets/lable_with_asterisk.dart';

class DropdownTextFieldWidget<T> extends StatefulWidget {
  const DropdownTextFieldWidget({
    super.key,
    required this.isRequired,
    required this.label,
    required this.hint,
    this.onChanged,
    required this.optionsMap,
    required this.selectedOption,
    this.addOption,
  });

  final bool isRequired;
  final String label;
  final String hint;
  final Map<String, T> optionsMap;
  final ValueNotifier<T?> selectedOption;
  final Function(T value)? onChanged;
  final Function(String option)? addOption;

  @override
  State<DropdownTextFieldWidget<T>> createState() => _DropdownTextFieldWidgetState<T>();
}

class _DropdownTextFieldWidgetState<T> extends State<DropdownTextFieldWidget<T>> {
  final ScrollController scrollController = ScrollController();
  late final FocusNode focusNode;
  late final GlobalKey<FormFieldState> validationKey;
  late final ExpandableController expandableController;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode()..addListener(() => setState(() {}));
    validationKey = GlobalKey<FormFieldState>();
    expandableController = ExpandableController(initialExpanded: false)..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    focusNode.dispose();
    validationKey.currentState?.dispose();
    expandableController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      controller: expandableController,
      child: ScrollOnExpand(
        child: ExpandablePanel(
          theme: ExpandableThemeData(hasIcon: false),
          header: ExpandableButton(
            theme: ExpandableThemeData(useInkWell: false),
            child: TextFormField(
              key: validationKey,
              readOnly: true,
              controller: null,
              focusNode: focusNode,
              onTap: () => expandableController.toggle(),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.done,
              validator: widget.isRequired
                  ? (_) {
                      return widget.selectedOption.value == null ? 'fieldCannotBeEmpty' : null;
                    }
                  : null,
              // style: AppTextStyles.paragraphSmall(context).copyWith(
              //   fontSize: 14.sp,
              //   color: ((widget.controller?.text.isEmpty ?? false) && !widget.canEdit) ? Color(0xFFABAEA2) : null,
              // ),
              decoration: InputDecoration(
                errorStyle: TextStyle(
                  color: Colors.transparent,
                  fontSize: 0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary(context), width: 2.w),
                  borderRadius:
                      expandableController.expanded && (widget.optionsMap.isNotEmpty || widget.addOption != null)
                      ? BorderRadius.only(
                          topLeft: Radius.circular(6.r),
                          topRight: Radius.circular(6.r),
                        )
                      : BorderRadius.all(Radius.circular(6.r)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grayLight),
                  borderRadius:
                      expandableController.expanded && (widget.optionsMap.isNotEmpty || widget.addOption != null)
                      ? BorderRadius.only(
                          topLeft: Radius.circular(6.r),
                          topRight: Radius.circular(6.r),
                        )
                      : BorderRadius.all(Radius.circular(6.r)),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grayLight),
                  borderRadius:
                      expandableController.expanded && (widget.optionsMap.isNotEmpty || widget.addOption != null)
                      ? BorderRadius.only(
                          topLeft: Radius.circular(6.r),
                          topRight: Radius.circular(6.r),
                        )
                      : BorderRadius.all(Radius.circular(6.r)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.error, width: 2.w),
                  borderRadius:
                      expandableController.expanded && (widget.optionsMap.isNotEmpty || widget.addOption != null)
                      ? BorderRadius.only(
                          topLeft: Radius.circular(6.r),
                          topRight: Radius.circular(6.r),
                        )
                      : BorderRadius.all(Radius.circular(6.r)),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.error, width: 2.w),
                  borderRadius:
                      expandableController.expanded && (widget.optionsMap.isNotEmpty || widget.addOption != null)
                      ? BorderRadius.only(
                          topLeft: Radius.circular(6.r),
                          topRight: Radius.circular(6.r),
                        )
                      : BorderRadius.all(Radius.circular(6.r)),
                ),
                label: widget.isRequired ? LabelWithAsterisk(label: widget.label) : Text(widget.label),
                suffixIcon: InkWell(
                  onTap: () {
                    expandableController.toggle();
                    if (expandableController.expanded)
                      focusNode.requestFocus();
                    else
                      focusNode.unfocus();
                  },
                  child: Container(
                    child: expandableController.expanded
                        ? Tab(
                            icon: Image.asset(
                              'assets/icons/arrow_up.png',
                              height: 30,
                              width: 30,
                              // color:
                              //     Provider.of<ThemeProviderNotifier>(context).isDarkMode ? Colors.white : Colors.black,
                            ),
                          )
                        : Tab(
                            icon: Image.asset(
                              'assets/icons/arrow_down.png',
                              height: 30,
                              width: 30,
                              // color:
                              //     Provider.of<ThemeProviderNotifier>(context).isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                  ),
                ),
                hintText: (widget.selectedOption.value == null)
                    ? widget.hint
                    : widget.optionsMap.entries
                        .firstWhereOrNull((entry) => entry.value == widget.selectedOption.value)
                        ?.key,
                hintStyle: Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(
                      color: (widget.selectedOption.value == null)
                          ? null
                          : Theme.of(context).inputDecorationTheme.labelStyle?.color,
                    ),
              ),
            ),
          ),
          collapsed: const SizedBox.shrink(),
          expanded: widget.optionsMap.isEmpty && widget.addOption == null
              ? const SizedBox.shrink()
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6.r),
                      bottomRight: Radius.circular(6.r),
                    ),
                    border: Border(
                      bottom: BorderSide(
                        width: focusNode.hasFocus ? 2.0 : 1.0,
                        color: focusNode.hasFocus
                            ? (validationKey.currentState?.hasError ?? true
                                ? AppColors.error
                                : AppColors.primary(context))
                            : (validationKey.currentState?.hasError ?? true ? AppColors.error : Color(0xFFDFE2D7)),
                      ),
                      left: BorderSide(
                        width: focusNode.hasFocus ? 2.0 : 1.0,
                        color: focusNode.hasFocus
                            ? (validationKey.currentState?.hasError ?? true
                                ? AppColors.error
                                : AppColors.primary(context))
                            : (validationKey.currentState?.hasError ?? true ? AppColors.error : Color(0xFFDFE2D7)),
                      ),
                      right: BorderSide(
                        width: focusNode.hasFocus ? 2.0 : 1.0,
                        color: focusNode.hasFocus
                            ? (validationKey.currentState?.hasError ?? true
                                ? AppColors.error
                                : AppColors.primary(context))
                            : (validationKey.currentState?.hasError ?? true ? AppColors.error : Color(0xFFDFE2D7)),
                      ),
                      top: BorderSide.none,
                    ),
                  ),
                  height: widget.optionsMap.length > 6 ? 240.h : null,
                  child: RawScrollbar(
                    controller: scrollController,
                    thickness: 5,
                    thumbColor: Color(0xFFDFE2D7),
                    radius: Radius.circular(10.r),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Wrap(
                        children: [
                          for (final entry in widget.optionsMap.entries)
                            InkWell(
                              onTap: () {
                                if (widget.selectedOption.value == entry.value) {
                                  widget.selectedOption.value = null;
                                } else {
                                  widget.selectedOption.value = entry.value;
                                }
                                if (widget.onChanged != null) widget.onChanged!(entry.value);
                                validationKey.currentState?.validate();
                                expandableController.toggle();
                                focusNode.unfocus();
                                setState(() {});
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: ShapeDecoration(
                                      shape: OvalBorder(
                                        side: widget.selectedOption.value == entry.value
                                            ? BorderSide(width: 6, color: AppColors.primary(context))
                                            : BorderSide(width: 1.50, color: Color(0xFFA8A8A8)),
                                      ),
                                    ),
                                  ).paddingOnly(right: 8.w),
                                  Text(entry.key),
                                ],
                              ).paddingSymmetric(horizontal: 16.w, vertical: 8.h),
                            ),
                          // добавление своего поля
                          if (widget.addOption != null)
                            InkWell(
                              onTap: () async {
                                final isAdded = await showDialog(
                                  context: context,
                                  builder: (dialogContext) {
                                    return _NewOptionInputDialog(
                                      text: 'Добавить свой',
                                      buttonText: 'Добавить',
                                      onSave: (newOption) async {
                                        widget.addOption!(newOption);
                                      },
                                    );
                                  },
                                );
                                if (isAdded != null && isAdded is String) {
                                  widget.selectedOption.value = widget.optionsMap[isAdded];

                                  validationKey.currentState?.validate();
                                  expandableController.toggle();
                                  focusNode.unfocus();
                                  setState(() {});
                                }
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/icons/add_blue.svg').paddingOnly(right: 8.w),
                                  Text(
                                    'Добавить',
                                    style: TextStyle(
                                      color: Color(0xFF2EA1D9),
                                      fontSize: 14.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ).paddingSymmetric(horizontal: 14.w, vertical: 6.h),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class _NewOptionInputDialog extends StatefulWidget {
  const _NewOptionInputDialog({
    required this.onSave,
    required this.text,
    required this.buttonText,
  });

  final String text;
  final String buttonText;
  final Function(String name) onSave;

  @override
  State<_NewOptionInputDialog> createState() => _NewOptionInputDialogState();
}

class _NewOptionInputDialogState extends State<_NewOptionInputDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        contentPadding: EdgeInsets.all(16.w),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
        content: SizedBox(
          width: context.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.text,
                  ).expanded(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset('assets/icons/close.svg'),
                  ),
                ],
              ).paddingOnly(bottom: 12.h),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'fieldCannotBeEmpty';
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  label: LabelWithAsterisk(label: widget.text),
                  hintText: 'Введите название',
                ),
                controller: _controller,
              ).paddingOnly(bottom: 12.h),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigator.of(context).pop(_controller.text);
                    widget.onSave(_controller.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.buttonText,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
