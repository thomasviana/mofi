// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i45;
import 'package:firebase_auth/firebase_auth.dart' as _i44;
import 'package:firebase_storage/firebase_storage.dart' as _i46;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i50;
import 'package:image_picker/image_picker.dart' as _i52;
import 'package:injectable/injectable.dart' as _i2;
<<<<<<< Updated upstream
import 'package:shared_preferences/shared_preferences.dart' as _i63;
=======
import 'package:shared_preferences/shared_preferences.dart' as _i64;
>>>>>>> Stashed changes

import '../core/accounts/application.dart' as _i36;
import '../core/accounts/domain.dart' as _i6;
import '../core/accounts/infrastructure.dart' as _i8;
<<<<<<< Updated upstream
import '../core/accounts/src/application/create_account.dart' as _i27;
import '../core/accounts/src/application/delete_account.dart' as _i31;
import '../core/accounts/src/application/get_accounts.dart' as _i46;
import '../core/accounts/src/application/reset_accounts.dart' as _i56;
import '../core/accounts/src/application/set_default_accounts.dart' as _i58;
import '../core/accounts/src/application/update_account.dart' as _i75;
=======
import '../core/accounts/src/application/create_account.dart' as _i28;
import '../core/accounts/src/application/delete_account.dart' as _i32;
import '../core/accounts/src/application/get_accounts.dart' as _i47;
import '../core/accounts/src/application/reset_accounts.dart' as _i57;
import '../core/accounts/src/application/set_default_accounts.dart' as _i59;
import '../core/accounts/src/application/update_account.dart' as _i76;
>>>>>>> Stashed changes
import '../core/accounts/src/infrastructure/account_repository_impl.dart'
    as _i7;
import '../core/accounts/src/infrastructure/datasources/local/account_mapper.dart'
    as _i5;
import '../core/accounts/src/infrastructure/datasources/local/accounts_db.dart'
    as _i4;
import '../core/accounts/src/infrastructure/datasources/local/accounts_local_data_source.dart'
    as _i9;
import '../core/accounts/src/infrastructure/datasources/local/accounts_table.dart'
    as _i3;
import '../core/budgets/application.dart' as _i38;
import '../core/budgets/domain.dart' as _i16;
import '../core/budgets/infrastructure.dart' as _i18;
<<<<<<< Updated upstream
import '../core/budgets/src/application/create_budget.dart' as _i28;
import '../core/budgets/src/application/delete_budget.dart' as _i32;
import '../core/budgets/src/application/get_budgets.dart' as _i47;
import '../core/budgets/src/application/reset_budgets.dart' as _i57;
import '../core/budgets/src/application/set_default_budgets.dart' as _i59;
import '../core/budgets/src/application/update_budget.dart' as _i76;
=======
import '../core/budgets/src/application/create_budget.dart' as _i29;
import '../core/budgets/src/application/delete_budget.dart' as _i33;
import '../core/budgets/src/application/get_budgets.dart' as _i48;
import '../core/budgets/src/application/reset_budgets.dart' as _i58;
import '../core/budgets/src/application/set_default_budgets.dart' as _i60;
import '../core/budgets/src/application/update_budget.dart' as _i77;
>>>>>>> Stashed changes
import '../core/budgets/src/infrastructure/budget_repository_impl.dart' as _i17;
import '../core/budgets/src/infrastructure/datasources/local/budget_mapper.dart'
    as _i15;
import '../core/budgets/src/infrastructure/datasources/local/budgets_db.dart'
    as _i14;
import '../core/budgets/src/infrastructure/datasources/local/budgets_local_data_source.dart'
    as _i19;
import '../core/budgets/src/infrastructure/datasources/local/budgets_table.dart'
    as _i13;
import '../core/categories/application.dart' as _i40;
import '../core/categories/domain.dart' as _i26;
import '../core/categories/infrastructure.dart' as _i20;
<<<<<<< Updated upstream
import '../core/categories/src/application/create_category.dart' as _i29;
import '../core/categories/src/application/create_sub_category.dart' as _i85;
import '../core/categories/src/application/delete_category.dart' as _i33;
import '../core/categories/src/application/delete_sub_category.dart' as _i87;
import '../core/categories/src/application/get_categories.dart' as _i48;
import '../core/categories/src/application/get_sub_categories.dart' as _i90;
import '../core/categories/src/application/reset_categories.dart' as _i93;
import '../core/categories/src/application/set_default_categories.dart' as _i60;
import '../core/categories/src/application/set_default_sub_categories.dart'
    as _i94;
import '../core/categories/src/application/update_category.dart' as _i77;
import '../core/categories/src/application/update_sub_category.dart' as _i78;
=======
import '../core/categories/src/application/create_category.dart' as _i30;
import '../core/categories/src/application/create_sub_category.dart' as _i87;
import '../core/categories/src/application/delete_category.dart' as _i34;
import '../core/categories/src/application/delete_sub_category.dart' as _i89;
import '../core/categories/src/application/get_categories.dart' as _i49;
import '../core/categories/src/application/get_sub_categories.dart' as _i92;
import '../core/categories/src/application/reset_categories.dart' as _i96;
import '../core/categories/src/application/set_default_categories.dart' as _i61;
import '../core/categories/src/application/set_default_sub_categories.dart'
    as _i97;
import '../core/categories/src/application/update_category.dart' as _i78;
import '../core/categories/src/application/update_sub_category.dart' as _i79;
>>>>>>> Stashed changes
import '../core/categories/src/infrastructure/category_repository_impl.dart'
    as _i27;
import '../core/categories/src/infrastructure/datasources/local/categories_db.dart'
    as _i24;
import '../core/categories/src/infrastructure/datasources/local/categories_local_data_source.dart'
    as _i21;
import '../core/categories/src/infrastructure/datasources/local/categories_table.dart'
    as _i23;
import '../core/categories/src/infrastructure/datasources/local/category_mapper.dart'
    as _i25;
import '../core/categories/src/infrastructure/datasources/local/sub_category_mapper.dart'
<<<<<<< Updated upstream
    as _i65;
import '../core/categories/src/infrastructure/sub_category_repository_impl.dart'
    as _i66;
import '../core/transactions/application.dart' as _i42;
import '../core/transactions/domain.dart' as _i70;
import '../core/transactions/infrastructure.dart' as _i72;
import '../core/transactions/src/application/add_transaction.dart' as _i81;
import '../core/transactions/src/application/delete_transaction.dart' as _i88;
import '../core/transactions/src/application/get_transactions.dart' as _i91;
import '../core/transactions/src/application/update_transaction.dart' as _i79;
import '../core/transactions/src/infrastructure/datasources/local/transaction_mapper.dart'
    as _i69;
import '../core/transactions/src/infrastructure/datasources/local/transactions_db.dart'
    as _i68;
import '../core/transactions/src/infrastructure/datasources/local/transactions_local_data_source.dart'
    as _i74;
import '../core/transactions/src/infrastructure/datasources/local/transactions_table.dart'
    as _i67;
import '../core/transactions/src/infrastructure/transaction_repository_impl.dart'
    as _i71;
import '../core/user/application.dart' as _i11;
import '../core/user/domain.dart' as _i82;
import '../core/user/src/application/check_auth_status.dart' as _i84;
import '../core/user/src/application/create_user.dart' as _i86;
import '../core/user/src/application/get_profile_info.dart' as _i89;
import '../core/user/src/application/log_out.dart' as _i92;
import '../core/user/src/application/pick_user_image.dart' as _i54;
import '../core/user/src/application/sign_in.dart' as _i95;
import '../core/user/src/application/update_user_info.dart' as _i96;
import '../core/user/src/infrastructure/auth/auth_service_impl.dart' as _i83;
import '../core/user/src/infrastructure/auth/user_firebase_prov.dart' as _i80;
import '../presentation/core/auth/auth_bloc.dart' as _i10;
import '../presentation/core/date/date_bloc.dart' as _i30;
import '../presentation/core/settings/settings_bloc.dart' as _i61;
import '../presentation/core/stats/stats_bloc.dart' as _i64;
import '../presentation/core/transactions/transactions_bloc.dart' as _i73;
=======
    as _i66;
import '../core/categories/src/infrastructure/datasources/remote/categories_firebase_provider.dart'
    as _i85;
import '../core/categories/src/infrastructure/datasources/remote/categories_remote_data_source.dart'
    as _i22;
import '../core/categories/src/infrastructure/sub_category_repository_impl.dart'
    as _i67;
import '../core/transactions/application.dart' as _i43;
import '../core/transactions/domain.dart' as _i71;
import '../core/transactions/infrastructure.dart' as _i73;
import '../core/transactions/src/application/add_transaction.dart' as _i82;
import '../core/transactions/src/application/delete_transaction.dart' as _i90;
import '../core/transactions/src/application/get_transactions.dart' as _i93;
import '../core/transactions/src/application/update_transaction.dart' as _i80;
import '../core/transactions/src/infrastructure/datasources/local/transaction_mapper.dart'
    as _i70;
import '../core/transactions/src/infrastructure/datasources/local/transactions_db.dart'
    as _i69;
import '../core/transactions/src/infrastructure/datasources/local/transactions_local_data_source.dart'
    as _i75;
import '../core/transactions/src/infrastructure/datasources/local/transactions_table.dart'
    as _i68;
import '../core/transactions/src/infrastructure/transaction_repository_impl.dart'
    as _i72;
import '../core/user/application.dart' as _i11;
import '../core/user/domain.dart' as _i83;
import '../core/user/src/application/check_auth_status.dart' as _i86;
import '../core/user/src/application/create_user.dart' as _i88;
import '../core/user/src/application/get_is_first_time_open.dart' as _i101;
import '../core/user/src/application/get_profile_info.dart' as _i91;
import '../core/user/src/application/log_out.dart' as _i94;
import '../core/user/src/application/pick_user_image.dart' as _i55;
import '../core/user/src/application/set_is_first_time_open_false.dart' as _i98;
import '../core/user/src/application/sign_in.dart' as _i99;
import '../core/user/src/application/update_user_info.dart' as _i100;
import '../core/user/src/infrastructure/auth/auth_service_impl.dart' as _i84;
import '../core/user/src/infrastructure/auth/user_firebase_provider.dart'
    as _i81;
import '../core/user/src/infrastructure/preferences/preferences_service_impl.dart'
    as _i95;
import '../presentation/core/auth/auth_bloc.dart' as _i10;
import '../presentation/core/date/date_bloc.dart' as _i31;
import '../presentation/core/settings/settings_bloc.dart' as _i62;
import '../presentation/core/stats/stats_bloc.dart' as _i65;
import '../presentation/core/transactions/transactions_bloc.dart' as _i74;
>>>>>>> Stashed changes
import '../presentation/screens/accounts/edit_account_bloc/edit_account_screen_bloc.dart'
    as _i35;
import '../presentation/screens/auth/cubit/auth_screen_cubit.dart' as _i12;
import '../presentation/screens/budgets/edit_budget_bloc/edit_budget_screen_bloc.dart'
    as _i37;
import '../presentation/screens/categories/edit_category_bloc/edit_category_screen_bloc.dart'
    as _i39;
import '../presentation/screens/categories/edit_sub_category_bloc/edit_sub_category_screen_bloc.dart'
    as _i41;
import '../presentation/screens/home/home_bloc/home_screen_bloc.dart' as _i51;
import '../presentation/screens/main/main_app_cubit/main_screen_cubit.dart'
    as _i53;
import '../presentation/screens/profile/profile_screen_bloc/profile_sceen_bloc.dart'
    as _i56;
import '../presentation/screens/settings/cubit/settings_screen_cubit.dart'
    as _i63;
import '../presentation/screens/transactions/edit_transaction_bloc/edit_transaction_screen_bloc.dart'
    as _i42;
import '../presentation/screens/transactions/manage_income_bloc/manage_income_screen_bloc.dart'
<<<<<<< Updated upstream
    as _i53;
import 'db_injectable_module.dart' as _i97;
import 'firebase_injectable_module.dart' as _i98;
import 'image_picker_injectable_module.dart' as _i99;
import 'preferences_injectable_module.dart'
    as _i100; // ignore_for_file: unnecessary_lambdas
=======
    as _i54;
import 'db_injectable_module.dart' as _i102;
import 'firebase_injectable_module.dart' as _i103;
import 'image_picker_injectable_module.dart' as _i104;
import 'preferences_injectable_module.dart'
    as _i105; // ignore_for_file: unnecessary_lambdas
>>>>>>> Stashed changes

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final dbInjectableModule = _$DbInjectableModule();
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  final imagePickerInjectableModule = _$ImagePickerInjectableModule();
  final preferencesInjectableModule = _$PreferencesInjectableModule();
  gh.lazySingleton<_i3.AccountDao>(
      () => _i3.AccountDao(get<_i4.AccountsDatabase>()));
  gh.lazySingleton<_i5.AccountMapper>(() => _i5.AccountMapper());
  gh.lazySingleton<_i6.AccountRepository>(
      () => _i7.AccountRepositoryImpl(get<_i8.AccountsLocalDataSource>()));
  gh.lazySingleton<_i8.AccountsDatabase>(
      () => dbInjectableModule.accountsDatabase);
  gh.lazySingleton<_i9.AccountsLocalDataSource>(() =>
      _i9.AccountsLocalDataSourceImpl(
          get<_i8.AccountDao>(), get<_i8.AccountMapper>()));
  gh.factory<_i10.AuthBloc>(
      () => _i10.AuthBloc(get<_i11.CheckAuthStatus>(), get<_i11.LogOut>()));
  gh.factory<_i12.AuthScreenCubit>(
      () => _i12.AuthScreenCubit(get<_i11.SignIn>(), get<_i11.CreateUser>()));
  gh.lazySingleton<_i13.BudgetDao>(
      () => _i13.BudgetDao(get<_i14.BudgetsDatabase>()));
  gh.lazySingleton<_i15.BudgetMapper>(() => _i15.BudgetMapper());
  gh.lazySingleton<_i16.BudgetRepository>(
      () => _i17.BudgetRepositoryImpl(get<_i18.BudgetsLocalDataSource>()));
  gh.lazySingleton<_i18.BudgetsDatabase>(
      () => dbInjectableModule.budgetsDatabase);
  gh.lazySingleton<_i19.BudgetsLocalDataSource>(() =>
      _i19.BudgetsLocalDataSourceImpl(
          get<_i18.BudgetDao>(), get<_i18.BudgetMapper>()));
  gh.lazySingleton<_i20.CategoriesDatabase>(
      () => dbInjectableModule.categoriesDatabase);
  gh.lazySingleton<_i21.CategoriesLocalDataSource>(() =>
      _i21.CategoriesLocalDataSourceImpl(
          get<_i20.CategoryDao>(),
          get<_i20.SubCategoryDao>(),
          get<_i20.CategoryMapper>(),
          get<_i20.SubCategoryMapper>()));
  gh.lazySingleton<_i22.CategoriesRemoteDataSource>(() =>
      _i22.CategoriesRemoteDataSourceImpl(
          get<_i20.CategoriesFirebaseProvider>()));
  gh.lazySingleton<_i23.CategoryDao>(
      () => _i23.CategoryDao(get<_i24.CategoriesDatabase>()));
  gh.lazySingleton<_i25.CategoryMapper>(() => _i25.CategoryMapper());
  gh.lazySingleton<_i26.CategoryRepository>(() => _i27.CategoryRepositoryImpl(
      get<_i20.CategoriesLocalDataSource>(),
      get<_i20.CategoriesRemoteDataSource>()));
  gh.factory<_i28.CreateAccount>(() => _i28.CreateAccount(
      get<_i6.AccountRepository>(), get<_i11.GetProfileInfo>()));
  gh.factory<_i29.CreateBudget>(() => _i29.CreateBudget(
      get<_i16.BudgetRepository>(), get<_i11.GetProfileInfo>()));
  gh.factory<_i30.CreateCategory>(() => _i30.CreateCategory(
      get<_i26.CategoryRepository>(), get<_i11.GetProfileInfo>()));
  gh.factory<_i31.DateBloc>(() => _i31.DateBloc());
  gh.factory<_i32.DeleteAccount>(
      () => _i32.DeleteAccount(get<_i6.AccountRepository>()));
  gh.factory<_i33.DeleteBudget>(
      () => _i33.DeleteBudget(get<_i16.BudgetRepository>()));
  gh.factory<_i34.DeleteCategory>(
      () => _i34.DeleteCategory(get<_i26.CategoryRepository>()));
  gh.factory<_i35.EditAccountScreenBloc>(() => _i35.EditAccountScreenBloc(
      get<_i36.UpdateAccount>(),
      get<_i36.DeleteAccount>(),
      get<_i11.GetProfileInfo>(),
      get<_i36.CreateAccount>()));
  gh.factory<_i37.EditBudgetScreenBloc>(() => _i37.EditBudgetScreenBloc(
      get<_i38.UpdateBudget>(),
      get<_i38.DeleteBudget>(),
      get<_i38.CreateBudget>()));
  gh.factory<_i39.EditCategoryScreenBloc>(() => _i39.EditCategoryScreenBloc(
      get<_i40.UpdateCategory>(),
      get<_i40.UpdateSubCategory>(),
      get<_i40.DeleteCategory>(),
      get<_i40.GetSubCategories>(),
      get<_i40.SetDefaultSubCategories>(),
      get<_i40.CreateSubCategory>(),
      get<_i40.CreateCategory>()));
  gh.factory<_i41.EditSubCategoryScreenBloc>(() =>
      _i41.EditSubCategoryScreenBloc(
          get<_i40.UpdateSubCategory>(), get<_i40.DeleteSubCategory>()));
  gh.factory<_i42.EditTransactionScreenBloc>(() =>
      _i42.EditTransactionScreenBloc(
          get<_i43.UpdateTransaction>(),
          get<_i43.DeleteTransaction>(),
          get<_i43.AddTransaction>(),
          get<_i40.GetSubCategories>(),
          get<_i40.SetDefaultSubCategories>()));
  gh.lazySingleton<_i44.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i45.FirebaseFirestore>(
      () => firebaseInjectableModule.firebaseFirestore);
  gh.lazySingleton<_i46.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseStorage);
  gh.factory<_i47.GetAccounts>(() => _i47.GetAccounts(
      get<_i6.AccountRepository>(), get<_i11.GetProfileInfo>()));
  gh.factory<_i48.GetBudgets>(() => _i48.GetBudgets(
      get<_i16.BudgetRepository>(), get<_i11.GetProfileInfo>()));
  gh.factory<_i49.GetCategories>(() => _i49.GetCategories(
      get<_i26.CategoryRepository>(), get<_i11.GetProfileInfo>()));
  gh.lazySingleton<_i50.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.factory<_i51.HomeScreenBloc>(
      () => _i51.HomeScreenBloc(get<_i11.GetProfileInfo>()));
  gh.lazySingleton<_i52.ImagePicker>(
      () => imagePickerInjectableModule.imagePicker);
  gh.factory<_i53.MainScreenCubit>(() => _i53.MainScreenCubit());
  gh.factory<_i54.ManageIncomeScreenBloc>(() => _i54.ManageIncomeScreenBloc(
      get<_i38.UpdateBudget>(), get<_i43.UpdateTransaction>()));
  gh.factory<_i55.PickUserImage>(
      () => _i55.PickUserImage(get<_i52.ImagePicker>()));
  gh.factory<_i56.ProfileScreenBloc>(() => _i56.ProfileScreenBloc(
      get<_i11.GetProfileInfo>(),
      get<_i11.UpdateUserInfo>(),
      get<_i11.PickUserImage>()));
  gh.factory<_i57.ResetAccounts>(
      () => _i57.ResetAccounts(get<_i6.AccountRepository>()));
  gh.factory<_i58.ResetBudgets>(
      () => _i58.ResetBudgets(get<_i16.BudgetRepository>()));
  gh.factory<_i59.SetDefaultAccounts>(() => _i59.SetDefaultAccounts(
      get<_i11.GetProfileInfo>(), get<_i6.AccountRepository>()));
  gh.factory<_i60.SetDefaultBudgets>(() => _i60.SetDefaultBudgets(
      get<_i16.BudgetRepository>(), get<_i11.GetProfileInfo>()));
  gh.factory<_i61.SetDefaultCategories>(() => _i61.SetDefaultCategories(
      get<_i11.GetProfileInfo>(), get<_i26.CategoryRepository>()));
  gh.factory<_i62.SettingsBloc>(() => _i62.SettingsBloc(
      get<_i11.GetIsFirstTimeOpen>(),
      get<_i11.SetFirstTimeOpenToFalse>(),
      get<_i36.GetAccounts>(),
      get<_i40.GetCategories>(),
      get<_i38.GetBudgets>(),
      get<_i36.SetDefaultAccounts>(),
      get<_i40.SetDefaultCategories>(),
      get<_i40.SetDefaultSubCategories>(),
      get<_i38.SetDefaultBudgets>(),
      get<_i36.ResetAccounts>(),
      get<_i40.ResetCategories>(),
      get<_i38.ResetBudgets>()));
  gh.factory<_i63.SettingsScreenCubit>(() => _i63.SettingsScreenCubit(
      get<_i11.CheckAuthStatus>(), get<_i11.GetProfileInfo>()));
<<<<<<< Updated upstream
  await gh.factoryAsync<_i63.SharedPreferences>(
      () => preferencesInjectableModule.preferences,
      preResolve: true);
  gh.factory<_i64.StatsBloc>(() => _i64.StatsBloc(
      get<_i37.GetBudgets>(),
      get<_i39.GetCategories>(),
      get<_i35.GetAccounts>(),
      get<_i42.GetTransactions>()));
  gh.lazySingleton<_i22.SubCategoryDao>(
      () => _i22.SubCategoryDao(get<_i23.CategoriesDatabase>()));
  gh.lazySingleton<_i65.SubCategoryMapper>(() => _i65.SubCategoryMapper());
  gh.lazySingleton<_i25.SubCategoryRepository>(() =>
      _i66.SubCategoryRepositoryImpl(get<_i20.CategoriesLocalDataSource>()));
  gh.lazySingleton<_i67.TransactionDao>(
      () => _i67.TransactionDao(get<_i68.TransactionsDatabase>()));
  gh.lazySingleton<_i69.TransactionMapper>(() => _i69.TransactionMapper());
  gh.lazySingleton<_i70.TransactionRepository>(() =>
      _i71.TransactionRepositoryImpl(get<_i72.TransactionsLocalDataSource>()));
  gh.factory<_i73.TransactionsBloc>(() => _i73.TransactionsBloc(
      get<_i42.GetTransactions>(), get<_i42.DeleteTransaction>()));
  gh.lazySingleton<_i72.TransactionsDatabase>(
      () => dbInjectableModule.transctionsDatabase);
  gh.lazySingleton<_i74.TransactionsLocalDataSource>(() =>
      _i74.TransactionsLocalDataSourceImpl(
          get<_i72.TransactionDao>(), get<_i72.TransactionMapper>()));
  gh.factory<_i75.UpdateAccount>(() => _i75.UpdateAccount(
      get<_i6.AccountRepository>(), get<_i46.GetAccounts>()));
  gh.factory<_i76.UpdateBudget>(() =>
      _i76.UpdateBudget(get<_i16.BudgetRepository>(), get<_i37.GetBudgets>()));
  gh.factory<_i77.UpdateCategory>(() => _i77.UpdateCategory(
      get<_i25.CategoryRepository>(), get<_i39.GetCategories>()));
  gh.factory<_i78.UpdateSubCategory>(() => _i78.UpdateSubCategory(
      get<_i25.SubCategoryRepository>(), get<_i39.GetSubCategories>()));
  gh.factory<_i79.UpdateTransaction>(() => _i79.UpdateTransaction(
      get<_i70.TransactionRepository>(), get<_i42.GetTransactions>()));
  gh.lazySingleton<_i80.UserFirebaseProv>(() => _i80.UserFirebaseProv(
      get<_i45.FirebaseStorage>(), get<_i44.FirebaseFirestore>()));
  gh.factory<_i81.AddTransaction>(() => _i81.AddTransaction(
      get<_i70.TransactionRepository>(), get<_i11.GetProfileInfo>()));
  gh.lazySingleton<_i82.AuthService>(() => _i83.AuthServiceImpl(
      get<_i43.FirebaseAuth>(),
      get<_i49.GoogleSignIn>(),
      get<_i80.UserFirebaseProv>()));
  gh.factory<_i84.CheckAuthStatus>(
      () => _i84.CheckAuthStatus(get<_i82.AuthService>()));
  gh.factory<_i85.CreateSubCategory>(
      () => _i85.CreateSubCategory(get<_i25.SubCategoryRepository>()));
  gh.factory<_i86.CreateUser>(() => _i86.CreateUser(get<_i82.AuthService>()));
  gh.factory<_i87.DeleteSubCategory>(
      () => _i87.DeleteSubCategory(get<_i25.SubCategoryRepository>()));
  gh.factory<_i88.DeleteTransaction>(
      () => _i88.DeleteTransaction(get<_i70.TransactionRepository>()));
  gh.factory<_i89.GetProfileInfo>(
      () => _i89.GetProfileInfo(get<_i82.AuthService>()));
  gh.factory<_i90.GetSubCategories>(
      () => _i90.GetSubCategories(get<_i25.SubCategoryRepository>()));
  gh.factory<_i91.GetTransactions>(() => _i91.GetTransactions(
      get<_i70.TransactionRepository>(), get<_i11.GetProfileInfo>()));
  gh.factory<_i92.LogOut>(() => _i92.LogOut(get<_i82.AuthService>()));
  gh.factory<_i93.ResetCategories>(() => _i93.ResetCategories(
      get<_i25.CategoryRepository>(), get<_i25.SubCategoryRepository>()));
  gh.factory<_i94.SetDefaultSubCategories>(
      () => _i94.SetDefaultSubCategories(get<_i25.SubCategoryRepository>()));
  gh.factory<_i95.SignIn>(() => _i95.SignIn(get<_i82.AuthService>()));
  gh.factory<_i96.UpdateUserInfo>(
      () => _i96.UpdateUserInfo(get<_i82.AuthService>()));
  return get;
}

class _$DbInjectableModule extends _i97.DbInjectableModule {}

class _$FirebaseInjectableModule extends _i98.FirebaseInjectableModule {}

class _$ImagePickerInjectableModule extends _i99.ImagePickerInjectableModule {}

class _$PreferencesInjectableModule extends _i100.PreferencesInjectableModule {}
=======
  await gh.factoryAsync<_i64.SharedPreferences>(
      () => preferencesInjectableModule.preferences,
      preResolve: true);
  gh.factory<_i65.StatsBloc>(() => _i65.StatsBloc(
      get<_i11.GetIsFirstTimeOpen>(),
      get<_i11.SetFirstTimeOpenToFalse>(),
      get<_i38.GetBudgets>(),
      get<_i40.GetCategories>(),
      get<_i36.GetAccounts>(),
      get<_i43.GetTransactions>()));
  gh.lazySingleton<_i23.SubCategoryDao>(
      () => _i23.SubCategoryDao(get<_i24.CategoriesDatabase>()));
  gh.lazySingleton<_i66.SubCategoryMapper>(() => _i66.SubCategoryMapper());
  gh.lazySingleton<_i26.SubCategoryRepository>(() =>
      _i67.SubCategoryRepositoryImpl(get<_i20.CategoriesLocalDataSource>(),
          get<_i20.CategoriesRemoteDataSource>()));
  gh.lazySingleton<_i68.TransactionDao>(
      () => _i68.TransactionDao(get<_i69.TransactionsDatabase>()));
  gh.lazySingleton<_i70.TransactionMapper>(() => _i70.TransactionMapper());
  gh.lazySingleton<_i71.TransactionRepository>(() =>
      _i72.TransactionRepositoryImpl(get<_i73.TransactionsLocalDataSource>()));
  gh.factory<_i74.TransactionsBloc>(() => _i74.TransactionsBloc(
      get<_i43.GetTransactions>(), get<_i43.DeleteTransaction>()));
  gh.lazySingleton<_i73.TransactionsDatabase>(
      () => dbInjectableModule.transctionsDatabase);
  gh.lazySingleton<_i75.TransactionsLocalDataSource>(() =>
      _i75.TransactionsLocalDataSourceImpl(
          get<_i73.TransactionDao>(), get<_i73.TransactionMapper>()));
  gh.factory<_i76.UpdateAccount>(() => _i76.UpdateAccount(
      get<_i6.AccountRepository>(), get<_i47.GetAccounts>()));
  gh.factory<_i77.UpdateBudget>(() =>
      _i77.UpdateBudget(get<_i16.BudgetRepository>(), get<_i38.GetBudgets>()));
  gh.factory<_i78.UpdateCategory>(() => _i78.UpdateCategory(
      get<_i26.CategoryRepository>(), get<_i40.GetCategories>()));
  gh.factory<_i79.UpdateSubCategory>(() => _i79.UpdateSubCategory(
      get<_i26.SubCategoryRepository>(), get<_i40.GetSubCategories>()));
  gh.factory<_i80.UpdateTransaction>(() => _i80.UpdateTransaction(
      get<_i71.TransactionRepository>(), get<_i43.GetTransactions>()));
  gh.lazySingleton<_i81.UserFirebaseProvider>(() => _i81.UserFirebaseProvider(
      get<_i46.FirebaseStorage>(), get<_i45.FirebaseFirestore>()));
  gh.factory<_i82.AddTransaction>(() => _i82.AddTransaction(
      get<_i71.TransactionRepository>(), get<_i11.GetProfileInfo>()));
  gh.lazySingleton<_i83.AuthService>(() => _i84.AuthServiceImpl(
      get<_i44.FirebaseAuth>(),
      get<_i50.GoogleSignIn>(),
      get<_i81.UserFirebaseProvider>()));
  gh.lazySingleton<_i85.CategoriesFirebaseProvider>(
      () => _i85.CategoriesFirebaseProvider(get<_i45.FirebaseFirestore>()));
  gh.factory<_i86.CheckAuthStatus>(
      () => _i86.CheckAuthStatus(get<_i83.AuthService>()));
  gh.factory<_i87.CreateSubCategory>(
      () => _i87.CreateSubCategory(get<_i26.SubCategoryRepository>()));
  gh.factory<_i88.CreateUser>(() => _i88.CreateUser(get<_i83.AuthService>()));
  gh.factory<_i89.DeleteSubCategory>(
      () => _i89.DeleteSubCategory(get<_i26.SubCategoryRepository>()));
  gh.factory<_i90.DeleteTransaction>(
      () => _i90.DeleteTransaction(get<_i71.TransactionRepository>()));
  gh.factory<_i91.GetProfileInfo>(
      () => _i91.GetProfileInfo(get<_i83.AuthService>()));
  gh.factory<_i92.GetSubCategories>(
      () => _i92.GetSubCategories(get<_i26.SubCategoryRepository>()));
  gh.factory<_i93.GetTransactions>(() => _i93.GetTransactions(
      get<_i71.TransactionRepository>(), get<_i11.GetProfileInfo>()));
  gh.factory<_i94.LogOut>(() => _i94.LogOut(get<_i83.AuthService>()));
  gh.lazySingleton<_i83.PreferencesService>(
      () => _i95.ImplPreferencesService(get<_i64.SharedPreferences>()));
  gh.factory<_i96.ResetCategories>(() => _i96.ResetCategories(
      get<_i26.CategoryRepository>(), get<_i26.SubCategoryRepository>()));
  gh.factory<_i97.SetDefaultSubCategories>(
      () => _i97.SetDefaultSubCategories(get<_i26.SubCategoryRepository>()));
  gh.factory<_i98.SetFirstTimeOpenToFalse>(
      () => _i98.SetFirstTimeOpenToFalse(get<_i83.PreferencesService>()));
  gh.factory<_i99.SignIn>(() => _i99.SignIn(get<_i83.AuthService>()));
  gh.factory<_i100.UpdateUserInfo>(
      () => _i100.UpdateUserInfo(get<_i83.AuthService>()));
  gh.factory<_i101.GetIsFirstTimeOpen>(
      () => _i101.GetIsFirstTimeOpen(get<_i83.PreferencesService>()));
  return get;
}

class _$DbInjectableModule extends _i102.DbInjectableModule {}

class _$FirebaseInjectableModule extends _i103.FirebaseInjectableModule {}

class _$ImagePickerInjectableModule extends _i104.ImagePickerInjectableModule {}

class _$PreferencesInjectableModule extends _i105.PreferencesInjectableModule {}
>>>>>>> Stashed changes
