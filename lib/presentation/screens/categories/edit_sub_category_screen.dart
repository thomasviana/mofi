import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import '../../../core/categories/domain.dart';
import '../../resources/resources.dart';
import '../../routes/app_navigator.dart';
import 'edit_sub_category_bloc/edit_sub_category_screen_bloc.dart';

class EditSubCategoryScreen extends StatefulWidget {
  final SubCategory subCategory;
  const EditSubCategoryScreen({
    Key? key,
    required this.subCategory,
  }) : super(key: key);
  @override
  _EditSubCategoryScreenState createState() => _EditSubCategoryScreenState();
}

class _EditSubCategoryScreenState extends State<EditSubCategoryScreen> {
  late EditSubCategoryScreenBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<EditSubCategoryScreenBloc>()
      ..add(CheckSubCategory(subCategory: widget.subCategory));
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: CustomScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            CupertinoSliverNavigationBar(
              stretch: true,
              largeTitle: Text(AppLocalizations.of(context)!.misc_subcategory),
              previousPageTitle: AppLocalizations.of(context)!.misc_back,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    child: Icon(
                      CupertinoIcons.trash_circle,
                      color: AppColors.red,
                      size: 24,
                    ),
                    onTap: () {
                      bloc.add(SubCategoryDeleted());
                      AppNavigator.navigateBack(context);
                    },
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    child: Icon(
                      CupertinoIcons.checkmark_circle,
                      color: AppColors.primaryColor,
                      size: 24,
                    ),
                    onTap: () {
                      bloc.add(SubCategorySaved());
                      AppNavigator.navigateBack(context);
                    },
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Material(
                child: EditSubCategoryContent(),
              ),
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.misc_subcategory,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: AppColors.red,
              ),
              onPressed: () {
                bloc.add(SubCategoryDeleted());
                AppNavigator.navigateBack(context);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.check,
                color: AppColors.white,
              ),
              onPressed: () {
                bloc.add(SubCategorySaved());
                AppNavigator.navigateBack(context);
              },
            ),
          ],
        ),
        body: EditSubCategoryContent(),
      );
    }
  }
}

class EditSubCategoryContent extends StatelessWidget {
  const EditSubCategoryContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditSubCategoryScreenBloc, EditSubCategoryScreenState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Center(
                  child: InkWell(
                    onTap: () {
                      final bloc = context.read<EditSubCategoryScreenBloc>();
                      _showEditOptions(
                        context,
                        state,
                        onColorUpdated: (color) =>
                            bloc.add(ColorUpdated(color)),
                        onIconUpdated: (icon) => bloc.add(IconUpdated(icon)),
                      );
                    },
                    child: Stack(
                      alignment: Alignment(1, 1.2),
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Color(state.subCategory!.color),
                          child: CircleAvatar(
                            radius: 36,
                            child: Icon(
                              IconData(
                                state.subCategory!.icon,
                                fontFamily: 'MaterialIcons',
                              ),
                              color: Color(state.subCategory!.color),
                              size: 40,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          maxRadius: 15,
                          child: Icon(
                            Icons.edit,
                            color: AppColors.white,
                            size: 15,
                          ),
                          backgroundColor: AppColors.greySecondary,
                        ),
                      ],
                    ),
                  ),
                ),
                if (Platform.isAndroid) ...[
                  SizedBox(height: 20),
                  Divider(height: 2),
                ],
                Padding(
                  padding: const EdgeInsets.only(
                    top: kDefaultPadding,
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                    bottom: 8,
                  ),
                  child: Text(
                    'GENERAL',
                    style: TextStyle(fontWeight: FontWeight.w200),
                    textAlign: TextAlign.start,
                  ),
                ),
                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.drive_file_rename_outline_outlined),
                      minLeadingWidth: 2,
                      title: Text(AppLocalizations.of(context)!.misc_name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (state.subCategory!.name.isNotEmpty)
                            Text(
                              state.subCategory!.name,
                              style: TextStyle(color: AppColors.greySecondary),
                            ),
                          if (state.subCategory!.name.isEmpty)
                            Text(
                              AppLocalizations.of(context)!.misc_required,
                              style: TextStyle(color: AppColors.red),
                            ),
                          SizedBox(width: 10),
                          if (Platform.isIOS)
                            const Icon(CupertinoIcons.forward),
                        ],
                      ),
                      onTap: () =>
                          AppNavigator.navigateToEditSubCategoryNamePage(
                        context,
                        name: state.subCategory!.name,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

Future<void> _showEditOptions(
  BuildContext context,
  EditSubCategoryScreenState state, {
  required Function(int color) onColorUpdated,
  required Function(int icon) onIconUpdated,
}) async {
  await showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          child: Text(AppLocalizations.of(context)!.global_change_icon),
          onPressed: () {
            Navigator.pop(context);
            _pickIcon(
              context,
              onIconUpdated: onIconUpdated,
            );
          },
        ),
        CupertinoActionSheetAction(
          child: Text(AppLocalizations.of(context)!.global_change_color),
          onPressed: () {
            Navigator.pop(context);
            _pickColor(
              context,
              state,
              onColorUpdated: onColorUpdated,
            );
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          AppLocalizations.of(context)!.misc_cancel,
          style: TextStyle(color: AppColors.red),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
  );
}

Future _pickColor(
  BuildContext context,
  EditSubCategoryScreenState state, {
  required Function(int color) onColorUpdated,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      title: Text(
        AppLocalizations.of(context)!.global_select_color,
        textAlign: TextAlign.center,
      ),
      content: MaterialColorPicker(
        allowShades: false,
        selectedColor: Color(state.subCategory!.color),
        onMainColorChange: (colorSwatch) {
          onColorUpdated(colorSwatch!.value);
          Navigator.of(context).pop();
        },
      ),
    ),
  );
}

Future<void> _pickIcon(
  BuildContext context, {
  required Function(int icon) onIconUpdated,
}) async {
  final materialIcons = AppIcons.materialIcons();
  final icon = await FlutterIconPicker.showIconPicker(
    context,
    title: Text(
      AppLocalizations.of(context)!.global_select_icon,
      textAlign: TextAlign.center,
    ),
    iconPickerShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
    ),
    searchHintText: AppLocalizations.of(context)!.misc_search,
    closeChild: Text(AppLocalizations.of(context)!.misc_close),
    iconSize: 30,
    customIconPack: materialIcons,
    iconColor: AppColors.black,
    iconPackModes: [IconPack.custom],
  );

  if (icon != null) {
    onIconUpdated(icon.codePoint);
  }
}
