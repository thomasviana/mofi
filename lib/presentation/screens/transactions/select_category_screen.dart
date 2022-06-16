import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/categories/domain.dart';
import '../../core/settings/settings_bloc.dart';
import '../../resources/resources.dart';
import '../../routes/app_navigator.dart';
import 'edit_transaction_bloc/edit_transaction_screen_bloc.dart';

class SelectCategoryScreen extends StatefulWidget {
  const SelectCategoryScreen({
    Key? key,
  }) : super(key: key);
  @override
  _SelectCategoryScreenState createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late EditTransactionScreenBloc bloc;
  late SettingsBloc settingsBloc;
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    bloc = context.read<EditTransactionScreenBloc>();
    settingsBloc = context.read<SettingsBloc>();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocBuilder<EditTransactionScreenBloc, EditTransactionScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, EditTransactionScreenState state) {
    final categories = settingsBloc.state.categories
        .where(
          (category) =>
              category.type.index == state.transaction.transactionType.index,
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.misc_category),
        leading: IconButton(
          icon: Platform.isIOS
              ? const Icon(Icons.arrow_back_ios)
              : const Icon(Icons.arrow_back),
          onPressed: () {
            if (_controller.index == 1) {
              _controller.animateTo(0);
            } else {
              AppNavigator.navigateBack(context);
            }
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              child: Text(
                AppLocalizations.of(context)!.misc_edit,
                style: TextStyle(
                  color:
                      Platform.isIOS ? AppColors.primaryColor : AppColors.white,
                ),
              ),
              onPressed: () => state.category.fold(
                () {},
                (category) => _controller.index == 0
                    ? AppNavigator.navigateToCategoriesPage(context)
                    : AppNavigator.navigateToEditCategoryPage(
                        context,
                        category: category,
                        then: (_) => bloc.add(GetUserSubcategories()),
                      ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SearchBox(
            text: state.query!,
            hintText: AppLocalizations.of(context)!
                .transactions_select_category_search,
            onChanged: (query) =>
                bloc.add(SearchSubCategory(query: query.trim())),
          ),
          Expanded(
            child: state.query!.isEmpty
                ? TabBarView(
                    controller: _controller,
                    children: [
                      _CategoriesList(
                        categories: categories,
                        controller: _controller,
                      ),
                      _SubCategoriesList()
                    ],
                  )
                : _SubCategorySuggestions(),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SubCategorySuggestions extends StatelessWidget {
  const _SubCategorySuggestions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTransactionScreenBloc, EditTransactionScreenState>(
      builder: (context, state) {
        return ListView(
          shrinkWrap: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: 8,
              ),
              child: Text(
                AppLocalizations.of(context)!
                    .transactions_select_category_suggestions
                    .toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.w200),
                textAlign: TextAlign.start,
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: state.subCategorySuggestions!.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 0),
              itemBuilder: (BuildContext context, int index) {
                final subCategory = state.subCategorySuggestions![index];
                return ListTile(
                  title: Text(subCategory.name),
                  leading: ListTileLeadingIcon(
                    icon: subCategory.icon,
                    color: subCategory.color,
                  ),
                  trailing: state.category.fold(
                    () => null,
                    (stateCategoryt) {
                      if (stateCategoryt.id == subCategory.id) {
                        return const Icon(
                          Icons.check,
                          color: AppColors.primaryColor,
                        );
                      }
                      return null;
                    },
                  ),
                  onTap: () {
                    context
                        .read<EditTransactionScreenBloc>()
                        .add(SubCategorySelected(subCategory: subCategory));
                    AppNavigator.navigateBack(context);
                  },
                );
              },
            ),
            const Divider(height: 0),
          ],
        );
      },
    );
  }
}

class _CategoriesList extends StatelessWidget {
  final List<Category> categories;
  final TabController controller;
  const _CategoriesList({
    Key? key,
    required this.categories,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTransactionScreenBloc, EditTransactionScreenState>(
      builder: (context, state) {
        return ListView(
          shrinkWrap: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: 8,
              ),
              child: Text(
                AppLocalizations.of(context)!.misc_categories.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.w200),
                textAlign: TextAlign.start,
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 0),
              itemBuilder: (BuildContext context, int index) {
                final category = categories[index];
                return ListTile(
                  title: Text(categories[index].name),
                  leading: ListTileLeadingIcon(
                    icon: category.icon,
                    color: category.color,
                  ),
                  trailing: state.category.fold(
                    () => null,
                    (stateCategoryt) {
                      if (stateCategoryt.id == category.id) {
                        return const Icon(
                          Icons.check,
                          color: AppColors.primaryColor,
                        );
                      }
                      return null;
                    },
                  ),
                  onTap: () {
                    context
                        .read<EditTransactionScreenBloc>()
                        .add(CategorySelected(category: category));
                    controller.animateTo(1);
                  },
                );
              },
            ),
            const Divider(height: 0),
          ],
        );
      },
    );
  }
}

class _SubCategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTransactionScreenBloc, EditTransactionScreenState>(
      builder: (context, state) {
        return ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
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
            ListTile(
              title: Text(state.generalSubCategory.name),
              leading: ListTileLeadingIcon(
                icon: state.generalSubCategory.icon,
                color: state.generalSubCategory.color,
              ),
              trailing: state.subCategory.fold(
                () => null,
                (stateSubCategory) {
                  if (stateSubCategory.id == state.generalSubCategory.id) {
                    return const Icon(
                      Icons.check,
                      color: AppColors.primaryColor,
                    );
                  }
                  return null;
                },
              ),
              onTap: () {
                context.read<EditTransactionScreenBloc>().add(
                      SubCategorySelected(
                        subCategory: state.generalSubCategory,
                      ),
                    );
                AppNavigator.navigateBack(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: 8,
              ),
              child: Text(
                AppLocalizations.of(context)!.misc_subcategories.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.w200),
                textAlign: TextAlign.start,
              ),
            ),
            Divider(height: 0),
            if (state.subCategoriesWithoutGeneral.length == 1)
              state.category.fold(
                () => const SizedBox(),
                (category) => Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Text(
                    '${AppLocalizations.of(context)!.transactions_select_category_no_subcategories} ${category.name}.',
                    style: TextStyle(color: AppColors.greySecondary),
                  ),
                ),
              ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.subCategoriesWithoutGeneral.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 0),
              itemBuilder: (BuildContext context, int index) {
                final subCategory = state.subCategoriesWithoutGeneral[index];
                return ListTile(
                  title: Text(subCategory.name),
                  leading: ListTileLeadingIcon(
                    icon: subCategory.icon,
                    color: subCategory.color,
                  ),
                  trailing: state.subCategory.fold(
                    () => null,
                    (stateSubCategoryt) {
                      if (stateSubCategoryt.id == subCategory.id) {
                        return Icon(Icons.check, color: AppColors.primaryColor);
                      }
                      return null;
                    },
                  ),
                  onTap: () {
                    AppNavigator.navigateBack(context);
                    context
                        .read<EditTransactionScreenBloc>()
                        .add(SubCategorySelected(subCategory: subCategory));
                  },
                );
              },
            ),
            const Divider(height: 0),
          ],
        );
      },
    );
  }
}

class SearchBox extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;
  const SearchBox({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: AppColors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;
    final _isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: _isDarkMode ? AppColors.greySecondary : AppColors.white,
        border: Border.all(color: Colors.black26),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: style.color),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(
                    Icons.close,
                    color: style.color,
                  ),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}
