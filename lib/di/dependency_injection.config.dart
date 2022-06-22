// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i47;
import 'package:firebase_auth/firebase_auth.dart' as _i46;
import 'package:firebase_storage/firebase_storage.dart' as _i48;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i52;
import 'package:image_picker/image_picker.dart' as _i54;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i65;

import '../core/accounts/application.dart' as _i38;
import '../core/accounts/domain.dart' as _i6;
import '../core/accounts/infrastructure.dart' as _i8;
import '../core/accounts/src/application/back_up_accounts.dart' as _i14;
import '../core/accounts/src/application/create_account.dart' as _i30;
import '../core/accounts/src/application/delete_account.dart' as _i34;
import '../core/accounts/src/application/get_accounts.dart' as _i49;
import '../core/accounts/src/application/reset_accounts.dart' as _i59;
import '../core/accounts/src/application/set_default_accounts.dart' as _i61;
import '../core/accounts/src/application/update_account.dart' as _i77;
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
import '../core/accounts/src/infrastructure/datasources/remote/accounts_firebase_provider.dart'
    as _i83;
import '../core/accounts/src/infrastructure/datasources/remote/accounts_remote_data_source.dart'
    as _i10;
import '../core/budgets/application.dart' as _i40;
import '../core/budgets/domain.dart' as _i18;
import '../core/budgets/infrastructure.dart' as _i20;
import '../core/budgets/src/application/back_up_budgets.dart' as _i87;
import '../core/budgets/src/application/create_budget.dart' as _i31;
import '../core/budgets/src/application/delete_budget.dart' as _i35;
import '../core/budgets/src/application/get_budgets.dart' as _i50;
import '../core/budgets/src/application/reset_budgets.dart' as _i60;
import '../core/budgets/src/application/set_default_budgets.dart' as _i62;
import '../core/budgets/src/application/update_budget.dart' as _i78;
import '../core/budgets/src/infrastructure/budget_repository_impl.dart' as _i19;
import '../core/budgets/src/infrastructure/datasources/local/budget_mapper.dart'
    as _i17;
import '../core/budgets/src/infrastructure/datasources/local/budgets_db.dart'
    as _i16;
import '../core/budgets/src/infrastructure/datasources/local/budgets_local_data_source.dart'
    as _i21;
import '../core/budgets/src/infrastructure/datasources/local/budgets_table.dart'
    as _i15;
import '../core/categories/application.dart' as _i42;
import '../core/categories/domain.dart' as _i28;
import '../core/categories/infrastructure.dart' as _i22;
import '../core/categories/src/application/back_up_categories.dart' as _i88;
import '../core/categories/src/application/create_category.dart' as _i32;
import '../core/categories/src/application/create_sub_category.dart' as _i91;
import '../core/categories/src/application/delete_category.dart' as _i36;
import '../core/categories/src/application/delete_sub_category.dart' as _i93;
import '../core/categories/src/application/get_categories.dart' as _i51;
import '../core/categories/src/application/get_sub_categories.dart' as _i96;
import '../core/categories/src/application/reset_categories.dart' as _i100;
import '../core/categories/src/application/set_default_categories.dart' as _i63;
import '../core/categories/src/application/set_default_sub_categories.dart'
    as _i101;
import '../core/categories/src/application/update_category.dart' as _i79;
import '../core/categories/src/application/update_sub_category.dart' as _i80;
import '../core/categories/src/infrastructure/category_repository_impl.dart'
    as _i29;
import '../core/categories/src/infrastructure/datasources/local/categories_db.dart'
    as _i26;
import '../core/categories/src/infrastructure/datasources/local/categories_local_data_source.dart'
    as _i23;
import '../core/categories/src/infrastructure/datasources/local/categories_table.dart'
    as _i25;
import '../core/categories/src/infrastructure/datasources/local/category_mapper.dart'
    as _i27;
import '../core/categories/src/infrastructure/datasources/local/sub_category_mapper.dart'
    as _i67;
import '../core/categories/src/infrastructure/datasources/remote/categories_firebase_provider.dart'
    as _i89;
import '../core/categories/src/infrastructure/datasources/remote/categories_remote_data_source.dart'
    as _i24;
import '../core/categories/src/infrastructure/sub_category_repository_impl.dart'
    as _i68;
import '../core/transactions/application.dart' as _i45;
import '../core/transactions/domain.dart' as _i72;
import '../core/transactions/infrastructure.dart' as _i74;
import '../core/transactions/src/application/add_transaction.dart' as _i84;
import '../core/transactions/src/application/delete_transaction.dart' as _i94;
import '../core/transactions/src/application/get_transactions.dart' as _i97;
import '../core/transactions/src/application/update_transaction.dart' as _i81;
import '../core/transactions/src/infrastructure/datasources/local/transaction_mapper.dart'
    as _i71;
import '../core/transactions/src/infrastructure/datasources/local/transactions_db.dart'
    as _i70;
import '../core/transactions/src/infrastructure/datasources/local/transactions_local_data_source.dart'
    as _i76;
import '../core/transactions/src/infrastructure/datasources/local/transactions_table.dart'
    as _i69;
import '../core/transactions/src/infrastructure/transaction_repository_impl.dart'
    as _i73;
import '../core/user/application.dart' as _i12;
import '../core/user/domain.dart' as _i85;
import '../core/user/src/application/check_auth_status.dart' as _i90;
import '../core/user/src/application/create_user.dart' as _i92;
import '../core/user/src/application/get_is_first_time_open.dart' as _i105;
import '../core/user/src/application/get_profile_info.dart' as _i95;
import '../core/user/src/application/log_out.dart' as _i98;
import '../core/user/src/application/pick_user_image.dart' as _i57;
import '../core/user/src/application/set_is_first_time_open_false.dart'
    as _i102;
import '../core/user/src/application/sign_in.dart' as _i103;
import '../core/user/src/application/update_user_info.dart' as _i104;
import '../core/user/src/infrastructure/auth/auth_service_impl.dart' as _i86;
import '../core/user/src/infrastructure/auth/user_firebase_provider.dart'
    as _i82;
import '../core/user/src/infrastructure/preferences/preferences_service_impl.dart'
    as _i99;
import '../presentation/core/auth/auth_bloc.dart' as _i11;
import '../presentation/core/date/date_bloc.dart' as _i33;
import '../presentation/core/settings/settings_bloc.dart' as _i64;
import '../presentation/core/stats/stats_bloc.dart' as _i66;
import '../presentation/core/transactions/transactions_bloc.dart' as _i75;
import '../presentation/screens/accounts/edit_account_bloc/edit_account_screen_bloc.dart'
    as _i37;
import '../presentation/screens/auth/cubit/auth_screen_cubit.dart' as _i13;
import '../presentation/screens/budgets/edit_budget_bloc/edit_budget_screen_bloc.dart'
    as _i39;
import '../presentation/screens/categories/edit_category_bloc/edit_category_screen_bloc.dart'
    as _i41;
import '../presentation/screens/categories/edit_sub_category_bloc/edit_sub_category_screen_bloc.dart'
    as _i43;
import '../presentation/screens/home/home_bloc/home_screen_bloc.dart' as _i53;
import '../presentation/screens/main/main_app_cubit/main_screen_cubit.dart'
    as _i55;
import '../presentation/screens/profile/profile_screen_bloc/profile_sceen_bloc.dart'
    as _i58;
import '../presentation/screens/transactions/edit_transaction_bloc/edit_transaction_screen_bloc.dart'
    as _i44;
import '../presentation/screens/transactions/manage_income_bloc/manage_income_screen_bloc.dart'
    as _i56;
import 'db_injectable_module.dart' as _i106;
import 'firebase_injectable_module.dart' as _i107;
import 'image_picker_injectable_module.dart' as _i108;
import 'preferences_injectable_module.dart'
    as _i109; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i6.AccountRepository>(() => _i7.AccountRepositoryImpl(
      get<_i8.AccountsLocalDataSource>(), get<_i8.AccountsRemoteDataSource>()));
  gh.lazySingleton<_i8.AccountsDatabase>(
      () => dbInjectableModule.accountsDatabase);
  gh.lazySingleton<_i9.AccountsLocalDataSource>(() =>
      _i9.AccountsLocalDataSourceImpl(
          get<_i8.AccountDao>(), get<_i8.AccountMapper>()));
  gh.lazySingleton<_i10.AccountsRemoteDataSource>(() =>
      _i10.AccountsRemoteDataSourceImpl(get<_i8.AccountsFirebaseProvider>()));
  gh.factory<_i11.AuthBloc>(
      () => _i11.AuthBloc(get<_i12.CheckAuthStatus>(), get<_i12.LogOut>()));
  gh.factory<_i13.AuthScreenCubit>(
      () => _i13.AuthScreenCubit(get<_i12.SignIn>(), get<_i12.CreateUser>()));
  gh.factory<_i14.BackUpAccounts>(() => _i14.BackUpAccounts(
      get<_i12.GetProfileInfo>(), get<_i6.AccountRepository>()));
  gh.lazySingleton<_i15.BudgetDao>(
      () => _i15.BudgetDao(get<_i16.BudgetsDatabase>()));
  gh.lazySingleton<_i17.BudgetMapper>(() => _i17.BudgetMapper());
  gh.lazySingleton<_i18.BudgetRepository>(
      () => _i19.BudgetRepositoryImpl(get<_i20.BudgetsLocalDataSource>()));
  gh.lazySingleton<_i20.BudgetsDatabase>(
      () => dbInjectableModule.budgetsDatabase);
  gh.lazySingleton<_i21.BudgetsLocalDataSource>(() =>
      _i21.BudgetsLocalDataSourceImpl(
          get<_i20.BudgetDao>(), get<_i20.BudgetMapper>()));
  gh.lazySingleton<_i22.CategoriesDatabase>(
      () => dbInjectableModule.categoriesDatabase);
  gh.lazySingleton<_i23.CategoriesLocalDataSource>(() =>
      _i23.CategoriesLocalDataSourceImpl(
          get<_i22.CategoryDao>(),
          get<_i22.SubCategoryDao>(),
          get<_i22.CategoryMapper>(),
          get<_i22.SubCategoryMapper>()));
  gh.lazySingleton<_i24.CategoriesRemoteDataSource>(() =>
      _i24.CategoriesRemoteDataSourceImpl(
          get<_i22.CategoriesFirebaseProvider>()));
  gh.lazySingleton<_i25.CategoryDao>(
      () => _i25.CategoryDao(get<_i26.CategoriesDatabase>()));
  gh.lazySingleton<_i27.CategoryMapper>(() => _i27.CategoryMapper());
  gh.lazySingleton<_i28.CategoryRepository>(() => _i29.CategoryRepositoryImpl(
      get<_i22.CategoriesLocalDataSource>(),
      get<_i22.CategoriesRemoteDataSource>()));
  gh.factory<_i30.CreateAccount>(() => _i30.CreateAccount(
      get<_i6.AccountRepository>(), get<_i12.GetProfileInfo>()));
  gh.factory<_i31.CreateBudget>(() => _i31.CreateBudget(
      get<_i18.BudgetRepository>(), get<_i12.GetProfileInfo>()));
  gh.factory<_i32.CreateCategory>(() => _i32.CreateCategory(
      get<_i28.CategoryRepository>(), get<_i12.GetProfileInfo>()));
  gh.factory<_i33.DateBloc>(() => _i33.DateBloc());
  gh.factory<_i34.DeleteAccount>(
      () => _i34.DeleteAccount(get<_i6.AccountRepository>()));
  gh.factory<_i35.DeleteBudget>(
      () => _i35.DeleteBudget(get<_i18.BudgetRepository>()));
  gh.factory<_i36.DeleteCategory>(
      () => _i36.DeleteCategory(get<_i28.CategoryRepository>()));
  gh.factory<_i37.EditAccountScreenBloc>(() => _i37.EditAccountScreenBloc(
      get<_i38.UpdateAccount>(),
      get<_i38.DeleteAccount>(),
      get<_i12.GetProfileInfo>(),
      get<_i38.CreateAccount>()));
  gh.factory<_i39.EditBudgetScreenBloc>(() => _i39.EditBudgetScreenBloc(
      get<_i40.UpdateBudget>(),
      get<_i40.DeleteBudget>(),
      get<_i40.CreateBudget>()));
  gh.factory<_i41.EditCategoryScreenBloc>(() => _i41.EditCategoryScreenBloc(
      get<_i42.UpdateCategory>(),
      get<_i42.UpdateSubCategory>(),
      get<_i42.DeleteCategory>(),
      get<_i42.GetSubCategories>(),
      get<_i42.CreateSubCategory>(),
      get<_i42.CreateCategory>()));
  gh.factory<_i43.EditSubCategoryScreenBloc>(() =>
      _i43.EditSubCategoryScreenBloc(
          get<_i42.UpdateSubCategory>(), get<_i42.DeleteSubCategory>()));
  gh.factory<_i44.EditTransactionScreenBloc>(() =>
      _i44.EditTransactionScreenBloc(
          get<_i45.UpdateTransaction>(),
          get<_i45.DeleteTransaction>(),
          get<_i45.AddTransaction>(),
          get<_i42.GetSubCategories>()));
  gh.lazySingleton<_i46.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i47.FirebaseFirestore>(
      () => firebaseInjectableModule.firebaseFirestore);
  gh.lazySingleton<_i48.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseStorage);
  gh.factory<_i49.GetAccounts>(() => _i49.GetAccounts(
      get<_i6.AccountRepository>(), get<_i12.GetProfileInfo>()));
  gh.factory<_i50.GetBudgets>(() => _i50.GetBudgets(
      get<_i18.BudgetRepository>(), get<_i12.GetProfileInfo>()));
  gh.factory<_i51.GetCategories>(() => _i51.GetCategories(
      get<_i28.CategoryRepository>(), get<_i12.GetProfileInfo>()));
  gh.lazySingleton<_i52.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.factory<_i53.HomeScreenBloc>(
      () => _i53.HomeScreenBloc(get<_i12.GetProfileInfo>()));
  gh.lazySingleton<_i54.ImagePicker>(
      () => imagePickerInjectableModule.imagePicker);
  gh.factory<_i55.MainScreenCubit>(() => _i55.MainScreenCubit());
  gh.factory<_i56.ManageIncomeScreenBloc>(() => _i56.ManageIncomeScreenBloc(
      get<_i40.UpdateBudget>(), get<_i45.UpdateTransaction>()));
  gh.factory<_i57.PickUserImage>(
      () => _i57.PickUserImage(get<_i54.ImagePicker>()));
  gh.factory<_i58.ProfileScreenBloc>(() => _i58.ProfileScreenBloc(
      get<_i12.GetProfileInfo>(),
      get<_i12.UpdateUserInfo>(),
      get<_i12.PickUserImage>()));
  gh.factory<_i59.ResetAccounts>(
      () => _i59.ResetAccounts(get<_i6.AccountRepository>()));
  gh.factory<_i60.ResetBudgets>(
      () => _i60.ResetBudgets(get<_i18.BudgetRepository>()));
  gh.factory<_i61.SetDefaultAccounts>(() => _i61.SetDefaultAccounts(
      get<_i12.GetProfileInfo>(), get<_i6.AccountRepository>()));
  gh.factory<_i62.SetDefaultBudgets>(() => _i62.SetDefaultBudgets(
      get<_i18.BudgetRepository>(), get<_i12.GetProfileInfo>()));
  gh.factory<_i63.SetDefaultCategories>(() => _i63.SetDefaultCategories(
      get<_i12.GetProfileInfo>(), get<_i28.CategoryRepository>()));
  gh.factory<_i64.SettingsBloc>(() => _i64.SettingsBloc(
      get<_i12.GetIsFirstTimeOpen>(),
      get<_i12.SetFirstTimeOpenToFalse>(),
      get<_i38.GetAccounts>(),
      get<_i42.GetCategories>(),
      get<_i40.GetBudgets>(),
      get<_i38.SetDefaultAccounts>(),
      get<_i42.SetDefaultCategories>(),
      get<_i42.SetDefaultSubCategories>(),
      get<_i40.SetDefaultBudgets>(),
      get<_i38.ResetAccounts>(),
      get<_i42.ResetCategories>(),
      get<_i40.ResetBudgets>(),
      get<_i42.BackUpCategories>(),
      get<_i38.BackUpAccounts>()));
  await gh.factoryAsync<_i65.SharedPreferences>(
      () => preferencesInjectableModule.preferences,
      preResolve: true);
  gh.factory<_i66.StatsBloc>(() => _i66.StatsBloc(
      get<_i12.GetIsFirstTimeOpen>(),
      get<_i12.SetFirstTimeOpenToFalse>(),
      get<_i40.GetBudgets>(),
      get<_i42.GetCategories>(),
      get<_i38.GetAccounts>(),
      get<_i45.GetTransactions>()));
  gh.lazySingleton<_i25.SubCategoryDao>(
      () => _i25.SubCategoryDao(get<_i26.CategoriesDatabase>()));
  gh.lazySingleton<_i67.SubCategoryMapper>(() => _i67.SubCategoryMapper());
  gh.lazySingleton<_i28.SubCategoryRepository>(() =>
      _i68.SubCategoryRepositoryImpl(get<_i22.CategoriesLocalDataSource>(),
          get<_i22.CategoriesRemoteDataSource>()));
  gh.lazySingleton<_i69.TransactionDao>(
      () => _i69.TransactionDao(get<_i70.TransactionsDatabase>()));
  gh.lazySingleton<_i71.TransactionMapper>(() => _i71.TransactionMapper());
  gh.lazySingleton<_i72.TransactionRepository>(() =>
      _i73.TransactionRepositoryImpl(get<_i74.TransactionsLocalDataSource>()));
  gh.factory<_i75.TransactionsBloc>(() => _i75.TransactionsBloc(
      get<_i45.GetTransactions>(), get<_i45.DeleteTransaction>()));
  gh.lazySingleton<_i74.TransactionsDatabase>(
      () => dbInjectableModule.transctionsDatabase);
  gh.lazySingleton<_i76.TransactionsLocalDataSource>(() =>
      _i76.TransactionsLocalDataSourceImpl(
          get<_i74.TransactionDao>(), get<_i74.TransactionMapper>()));
  gh.factory<_i77.UpdateAccount>(() => _i77.UpdateAccount(
      get<_i6.AccountRepository>(), get<_i49.GetAccounts>()));
  gh.factory<_i78.UpdateBudget>(() =>
      _i78.UpdateBudget(get<_i18.BudgetRepository>(), get<_i40.GetBudgets>()));
  gh.factory<_i79.UpdateCategory>(() => _i79.UpdateCategory(
      get<_i28.CategoryRepository>(), get<_i42.GetCategories>()));
  gh.factory<_i80.UpdateSubCategory>(() => _i80.UpdateSubCategory(
      get<_i28.SubCategoryRepository>(), get<_i42.GetSubCategories>()));
  gh.factory<_i81.UpdateTransaction>(() => _i81.UpdateTransaction(
      get<_i72.TransactionRepository>(), get<_i45.GetTransactions>()));
  gh.lazySingleton<_i82.UserFirebaseProvider>(() => _i82.UserFirebaseProvider(
      get<_i48.FirebaseStorage>(), get<_i47.FirebaseFirestore>()));
  gh.lazySingleton<_i83.AccountsFirebaseProvider>(
      () => _i83.AccountsFirebaseProvider(get<_i47.FirebaseFirestore>()));
  gh.factory<_i84.AddTransaction>(() => _i84.AddTransaction(
      get<_i72.TransactionRepository>(), get<_i12.GetProfileInfo>()));
  gh.lazySingleton<_i85.AuthService>(() => _i86.AuthServiceImpl(
      get<_i46.FirebaseAuth>(),
      get<_i52.GoogleSignIn>(),
      get<_i82.UserFirebaseProvider>()));
  gh.factory<_i87.BackUpBudgets>(() => _i87.BackUpBudgets(
      get<_i12.GetProfileInfo>(), get<_i18.BudgetRepository>()));
  gh.factory<_i88.BackUpCategories>(() => _i88.BackUpCategories(
      get<_i12.GetProfileInfo>(), get<_i28.CategoryRepository>()));
  gh.lazySingleton<_i89.CategoriesFirebaseProvider>(
      () => _i89.CategoriesFirebaseProvider(get<_i47.FirebaseFirestore>()));
  gh.factory<_i90.CheckAuthStatus>(
      () => _i90.CheckAuthStatus(get<_i85.AuthService>()));
  gh.factory<_i91.CreateSubCategory>(
      () => _i91.CreateSubCategory(get<_i28.SubCategoryRepository>()));
  gh.factory<_i92.CreateUser>(() => _i92.CreateUser(get<_i85.AuthService>()));
  gh.factory<_i93.DeleteSubCategory>(
      () => _i93.DeleteSubCategory(get<_i28.SubCategoryRepository>()));
  gh.factory<_i94.DeleteTransaction>(
      () => _i94.DeleteTransaction(get<_i72.TransactionRepository>()));
  gh.factory<_i95.GetProfileInfo>(
      () => _i95.GetProfileInfo(get<_i85.AuthService>()));
  gh.factory<_i96.GetSubCategories>(
      () => _i96.GetSubCategories(get<_i28.SubCategoryRepository>()));
  gh.factory<_i97.GetTransactions>(() => _i97.GetTransactions(
      get<_i72.TransactionRepository>(), get<_i12.GetProfileInfo>()));
  gh.factory<_i98.LogOut>(() => _i98.LogOut(get<_i85.AuthService>()));
  gh.lazySingleton<_i85.PreferencesService>(
      () => _i99.ImplPreferencesService(get<_i65.SharedPreferences>()));
  gh.factory<_i100.ResetCategories>(() => _i100.ResetCategories(
      get<_i28.CategoryRepository>(), get<_i28.SubCategoryRepository>()));
  gh.factory<_i101.SetDefaultSubCategories>(
      () => _i101.SetDefaultSubCategories(get<_i28.SubCategoryRepository>()));
  gh.factory<_i102.SetFirstTimeOpenToFalse>(
      () => _i102.SetFirstTimeOpenToFalse(get<_i85.PreferencesService>()));
  gh.factory<_i103.SignIn>(() => _i103.SignIn(get<_i85.AuthService>()));
  gh.factory<_i104.UpdateUserInfo>(
      () => _i104.UpdateUserInfo(get<_i85.AuthService>()));
  gh.factory<_i105.GetIsFirstTimeOpen>(
      () => _i105.GetIsFirstTimeOpen(get<_i85.PreferencesService>()));
  return get;
}

class _$DbInjectableModule extends _i106.DbInjectableModule {}

class _$FirebaseInjectableModule extends _i107.FirebaseInjectableModule {}

class _$ImagePickerInjectableModule extends _i108.ImagePickerInjectableModule {}

class _$PreferencesInjectableModule extends _i109.PreferencesInjectableModule {}
