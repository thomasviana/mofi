// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i48;
import 'package:firebase_auth/firebase_auth.dart' as _i47;
import 'package:firebase_storage/firebase_storage.dart' as _i49;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i53;
import 'package:image_picker/image_picker.dart' as _i55;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i66;

import '../core/accounts/application.dart' as _i39;
import '../core/accounts/domain.dart' as _i6;
import '../core/accounts/infrastructure.dart' as _i8;
import '../core/accounts/src/application/back_up_accounts.dart' as _i14;
import '../core/accounts/src/application/create_account.dart' as _i31;
import '../core/accounts/src/application/delete_account.dart' as _i35;
import '../core/accounts/src/application/get_accounts.dart' as _i50;
import '../core/accounts/src/application/reset_accounts.dart' as _i60;
import '../core/accounts/src/application/set_default_accounts.dart' as _i62;
import '../core/accounts/src/application/update_account.dart' as _i80;
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
    as _i86;
import '../core/accounts/src/infrastructure/datasources/remote/accounts_remote_data_source.dart'
    as _i10;
import '../core/budgets/application.dart' as _i41;
import '../core/budgets/domain.dart' as _i18;
import '../core/budgets/infrastructure.dart' as _i20;
import '../core/budgets/src/application/back_up_budgets.dart' as _i90;
import '../core/budgets/src/application/create_budget.dart' as _i32;
import '../core/budgets/src/application/delete_budget.dart' as _i36;
import '../core/budgets/src/application/get_budgets.dart' as _i51;
import '../core/budgets/src/application/reset_budgets.dart' as _i61;
import '../core/budgets/src/application/set_default_budgets.dart' as _i63;
import '../core/budgets/src/application/update_budget.dart' as _i81;
import '../core/budgets/src/infrastructure/budget_repository_impl.dart' as _i19;
import '../core/budgets/src/infrastructure/datasources/local/budget_mapper.dart'
    as _i17;
import '../core/budgets/src/infrastructure/datasources/local/budgets_db.dart'
    as _i16;
import '../core/budgets/src/infrastructure/datasources/local/budgets_local_data_source.dart'
    as _i21;
import '../core/budgets/src/infrastructure/datasources/local/budgets_table.dart'
    as _i15;
import '../core/budgets/src/infrastructure/datasources/remote/budgets_firebase_provider.dart'
    as _i93;
import '../core/budgets/src/infrastructure/datasources/remote/budgets_remote_data_source.dart'
    as _i22;
import '../core/categories/application.dart' as _i43;
import '../core/categories/domain.dart' as _i29;
import '../core/categories/infrastructure.dart' as _i23;
import '../core/categories/src/application/back_up_categories.dart' as _i91;
import '../core/categories/src/application/create_category.dart' as _i33;
import '../core/categories/src/application/create_sub_category.dart' as _i96;
import '../core/categories/src/application/delete_category.dart' as _i37;
import '../core/categories/src/application/delete_sub_category.dart' as _i98;
import '../core/categories/src/application/get_categories.dart' as _i52;
import '../core/categories/src/application/get_sub_categories.dart' as _i101;
import '../core/categories/src/application/reset_categories.dart' as _i105;
import '../core/categories/src/application/set_default_categories.dart' as _i64;
import '../core/categories/src/application/set_default_sub_categories.dart'
    as _i107;
import '../core/categories/src/application/update_category.dart' as _i82;
import '../core/categories/src/application/update_sub_category.dart' as _i83;
import '../core/categories/src/infrastructure/category_repository_impl.dart'
    as _i30;
import '../core/categories/src/infrastructure/datasources/local/categories_db.dart'
    as _i27;
import '../core/categories/src/infrastructure/datasources/local/categories_local_data_source.dart'
    as _i24;
import '../core/categories/src/infrastructure/datasources/local/categories_table.dart'
    as _i26;
import '../core/categories/src/infrastructure/datasources/local/category_mapper.dart'
    as _i28;
import '../core/categories/src/infrastructure/datasources/local/sub_category_mapper.dart'
    as _i68;
import '../core/categories/src/infrastructure/datasources/remote/categories_firebase_provider.dart'
    as _i94;
import '../core/categories/src/infrastructure/datasources/remote/categories_remote_data_source.dart'
    as _i25;
import '../core/categories/src/infrastructure/sub_category_repository_impl.dart'
    as _i69;
import '../core/transactions/application.dart' as _i46;
import '../core/transactions/domain.dart' as _i73;
import '../core/transactions/infrastructure.dart' as _i75;
import '../core/transactions/src/application/add_transaction.dart' as _i87;
import '../core/transactions/src/application/back_up_transactions.dart' as _i92;
import '../core/transactions/src/application/delete_transaction.dart' as _i99;
import '../core/transactions/src/application/get_transactions.dart' as _i102;
import '../core/transactions/src/application/reset_transactions.dart' as _i106;
import '../core/transactions/src/application/update_transaction.dart' as _i84;
import '../core/transactions/src/infrastructure/datasources/local/transaction_mapper.dart'
    as _i72;
import '../core/transactions/src/infrastructure/datasources/local/transactions_db.dart'
    as _i71;
import '../core/transactions/src/infrastructure/datasources/local/transactions_local_data_source.dart'
    as _i78;
import '../core/transactions/src/infrastructure/datasources/local/transactions_table.dart'
    as _i70;
import '../core/transactions/src/infrastructure/datasources/remote/transactions_firebase_provider.dart'
    as _i77;
import '../core/transactions/src/infrastructure/datasources/remote/transactions_remote_data_source.dart'
    as _i79;
import '../core/transactions/src/infrastructure/transaction_repository_impl.dart'
    as _i74;
import '../core/user/application.dart' as _i12;
import '../core/user/domain.dart' as _i88;
import '../core/user/src/application/check_auth_status.dart' as _i95;
import '../core/user/src/application/create_user.dart' as _i97;
import '../core/user/src/application/get_is_first_time_open.dart' as _i111;
import '../core/user/src/application/get_profile_info.dart' as _i100;
import '../core/user/src/application/log_out.dart' as _i103;
import '../core/user/src/application/pick_user_image.dart' as _i58;
import '../core/user/src/application/set_is_first_time_open_false.dart'
    as _i108;
import '../core/user/src/application/sign_in.dart' as _i109;
import '../core/user/src/application/update_user_info.dart' as _i110;
import '../core/user/src/infrastructure/auth/auth_service_impl.dart' as _i89;
import '../core/user/src/infrastructure/auth/user_firebase_provider.dart'
    as _i85;
import '../core/user/src/infrastructure/preferences/preferences_service_impl.dart'
    as _i104;
import '../presentation/core/auth/auth_bloc.dart' as _i11;
import '../presentation/core/date/date_bloc.dart' as _i34;
import '../presentation/core/settings/settings_bloc.dart' as _i65;
import '../presentation/core/stats/stats_bloc.dart' as _i67;
import '../presentation/core/transactions/transactions_bloc.dart' as _i76;
import '../presentation/screens/accounts/edit_account_bloc/edit_account_screen_bloc.dart'
    as _i38;
import '../presentation/screens/auth/cubit/auth_screen_cubit.dart' as _i13;
import '../presentation/screens/budgets/edit_budget_bloc/edit_budget_screen_bloc.dart'
    as _i40;
import '../presentation/screens/categories/edit_category_bloc/edit_category_screen_bloc.dart'
    as _i42;
import '../presentation/screens/categories/edit_sub_category_bloc/edit_sub_category_screen_bloc.dart'
    as _i44;
import '../presentation/screens/home/home_bloc/home_screen_bloc.dart' as _i54;
import '../presentation/screens/main/main_app_cubit/main_screen_cubit.dart'
    as _i56;
import '../presentation/screens/profile/profile_screen_bloc/profile_sceen_bloc.dart'
    as _i59;
import '../presentation/screens/transactions/edit_transaction_bloc/edit_transaction_screen_bloc.dart'
    as _i45;
import '../presentation/screens/transactions/manage_income_bloc/manage_income_screen_bloc.dart'
    as _i57;
import 'db_injectable_module.dart' as _i112;
import 'firebase_injectable_module.dart' as _i113;
import 'image_picker_injectable_module.dart' as _i114;
import 'preferences_injectable_module.dart'
    as _i115; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i18.BudgetRepository>(() => _i19.BudgetRepositoryImpl(
      get<_i20.BudgetsLocalDataSource>(), get<_i20.BudgetsRemoteDataSource>()));
  gh.lazySingleton<_i20.BudgetsDatabase>(
      () => dbInjectableModule.budgetsDatabase);
  gh.lazySingleton<_i21.BudgetsLocalDataSource>(() =>
      _i21.BudgetsLocalDataSourceImpl(
          get<_i20.BudgetDao>(), get<_i20.BudgetMapper>()));
  gh.lazySingleton<_i22.BudgetsRemoteDataSource>(() =>
      _i22.BudgetsRemoteDataSourceImpl(get<_i20.BudgetsFirebaseProvider>()));
  gh.lazySingleton<_i23.CategoriesDatabase>(
      () => dbInjectableModule.categoriesDatabase);
  gh.lazySingleton<_i24.CategoriesLocalDataSource>(() =>
      _i24.CategoriesLocalDataSourceImpl(
          get<_i23.CategoryDao>(),
          get<_i23.SubCategoryDao>(),
          get<_i23.CategoryMapper>(),
          get<_i23.SubCategoryMapper>()));
  gh.lazySingleton<_i25.CategoriesRemoteDataSource>(() =>
      _i25.CategoriesRemoteDataSourceImpl(
          get<_i23.CategoriesFirebaseProvider>()));
  gh.lazySingleton<_i26.CategoryDao>(
      () => _i26.CategoryDao(get<_i27.CategoriesDatabase>()));
  gh.lazySingleton<_i28.CategoryMapper>(() => _i28.CategoryMapper());
  gh.lazySingleton<_i29.CategoryRepository>(() => _i30.CategoryRepositoryImpl(
      get<_i23.CategoriesLocalDataSource>(),
      get<_i23.CategoriesRemoteDataSource>()));
  gh.factory<_i31.CreateAccount>(() => _i31.CreateAccount(
      get<_i6.AccountRepository>(), get<_i12.GetProfileInfo>()));
  gh.factory<_i32.CreateBudget>(() => _i32.CreateBudget(
      get<_i18.BudgetRepository>(), get<_i12.GetProfileInfo>()));
  gh.factory<_i33.CreateCategory>(() => _i33.CreateCategory(
      get<_i29.CategoryRepository>(), get<_i12.GetProfileInfo>()));
  gh.factory<_i34.DateBloc>(() => _i34.DateBloc());
  gh.factory<_i35.DeleteAccount>(
      () => _i35.DeleteAccount(get<_i6.AccountRepository>()));
  gh.factory<_i36.DeleteBudget>(
      () => _i36.DeleteBudget(get<_i18.BudgetRepository>()));
  gh.factory<_i37.DeleteCategory>(
      () => _i37.DeleteCategory(get<_i29.CategoryRepository>()));
  gh.factory<_i38.EditAccountScreenBloc>(() => _i38.EditAccountScreenBloc(
      get<_i39.UpdateAccount>(),
      get<_i39.DeleteAccount>(),
      get<_i12.GetProfileInfo>(),
      get<_i39.CreateAccount>()));
  gh.factory<_i40.EditBudgetScreenBloc>(() => _i40.EditBudgetScreenBloc(
      get<_i41.UpdateBudget>(),
      get<_i41.DeleteBudget>(),
      get<_i41.CreateBudget>()));
  gh.factory<_i42.EditCategoryScreenBloc>(() => _i42.EditCategoryScreenBloc(
      get<_i43.UpdateCategory>(),
      get<_i43.UpdateSubCategory>(),
      get<_i43.DeleteCategory>(),
      get<_i43.GetSubCategories>(),
      get<_i43.CreateSubCategory>(),
      get<_i43.CreateCategory>()));
  gh.factory<_i44.EditSubCategoryScreenBloc>(() =>
      _i44.EditSubCategoryScreenBloc(
          get<_i43.UpdateSubCategory>(), get<_i43.DeleteSubCategory>()));
  gh.factory<_i45.EditTransactionScreenBloc>(() =>
      _i45.EditTransactionScreenBloc(
          get<_i46.UpdateTransaction>(),
          get<_i46.DeleteTransaction>(),
          get<_i46.AddTransaction>(),
          get<_i43.GetSubCategories>()));
  gh.lazySingleton<_i47.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i48.FirebaseFirestore>(
      () => firebaseInjectableModule.firebaseFirestore);
  gh.lazySingleton<_i49.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseStorage);
  gh.factory<_i50.GetAccounts>(() => _i50.GetAccounts(
      get<_i6.AccountRepository>(), get<_i12.GetProfileInfo>()));
  gh.factory<_i51.GetBudgets>(() => _i51.GetBudgets(
      get<_i18.BudgetRepository>(), get<_i12.GetProfileInfo>()));
  gh.factory<_i52.GetCategories>(() => _i52.GetCategories(
      get<_i29.CategoryRepository>(), get<_i12.GetProfileInfo>()));
  gh.lazySingleton<_i53.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.factory<_i54.HomeScreenBloc>(
      () => _i54.HomeScreenBloc(get<_i12.GetProfileInfo>()));
  gh.lazySingleton<_i55.ImagePicker>(
      () => imagePickerInjectableModule.imagePicker);
  gh.factory<_i56.MainScreenCubit>(() => _i56.MainScreenCubit());
  gh.factory<_i57.ManageIncomeScreenBloc>(() => _i57.ManageIncomeScreenBloc(
      get<_i41.UpdateBudget>(), get<_i46.UpdateTransaction>()));
  gh.factory<_i58.PickUserImage>(
      () => _i58.PickUserImage(get<_i55.ImagePicker>()));
  gh.factory<_i59.ProfileScreenBloc>(() => _i59.ProfileScreenBloc(
      get<_i12.GetProfileInfo>(),
      get<_i12.UpdateUserInfo>(),
      get<_i12.PickUserImage>()));
  gh.factory<_i60.ResetAccounts>(
      () => _i60.ResetAccounts(get<_i6.AccountRepository>()));
  gh.factory<_i61.ResetBudgets>(
      () => _i61.ResetBudgets(get<_i18.BudgetRepository>()));
  gh.factory<_i62.SetDefaultAccounts>(() => _i62.SetDefaultAccounts(
      get<_i12.GetProfileInfo>(), get<_i6.AccountRepository>()));
  gh.factory<_i63.SetDefaultBudgets>(() => _i63.SetDefaultBudgets(
      get<_i18.BudgetRepository>(), get<_i12.GetProfileInfo>()));
  gh.factory<_i64.SetDefaultCategories>(() => _i64.SetDefaultCategories(
      get<_i12.GetProfileInfo>(), get<_i29.CategoryRepository>()));
  gh.factory<_i65.SettingsBloc>(() => _i65.SettingsBloc(
      get<_i12.GetIsFirstTimeOpen>(),
      get<_i12.SetFirstTimeOpenToFalse>(),
      get<_i39.GetAccounts>(),
      get<_i43.GetCategories>(),
      get<_i41.GetBudgets>(),
      get<_i39.SetDefaultAccounts>(),
      get<_i43.SetDefaultCategories>(),
      get<_i43.SetDefaultSubCategories>(),
      get<_i41.SetDefaultBudgets>(),
      get<_i39.ResetAccounts>(),
      get<_i43.ResetCategories>(),
      get<_i41.ResetBudgets>(),
      get<_i46.ResetTransactions>(),
      get<_i43.BackUpCategories>(),
      get<_i39.BackUpAccounts>(),
      get<_i41.BackUpBudgets>()));
  await gh.factoryAsync<_i66.SharedPreferences>(
      () => preferencesInjectableModule.preferences,
      preResolve: true);
  gh.factory<_i67.StatsBloc>(() => _i67.StatsBloc(
      get<_i12.GetIsFirstTimeOpen>(),
      get<_i12.SetFirstTimeOpenToFalse>(),
      get<_i41.GetBudgets>(),
      get<_i43.GetCategories>(),
      get<_i39.GetAccounts>(),
      get<_i46.GetTransactions>()));
  gh.lazySingleton<_i26.SubCategoryDao>(
      () => _i26.SubCategoryDao(get<_i27.CategoriesDatabase>()));
  gh.lazySingleton<_i68.SubCategoryMapper>(() => _i68.SubCategoryMapper());
  gh.lazySingleton<_i29.SubCategoryRepository>(() =>
      _i69.SubCategoryRepositoryImpl(get<_i23.CategoriesLocalDataSource>(),
          get<_i23.CategoriesRemoteDataSource>()));
  gh.lazySingleton<_i70.TransactionDao>(
      () => _i70.TransactionDao(get<_i71.TransactionsDatabase>()));
  gh.lazySingleton<_i72.TransactionMapper>(() => _i72.TransactionMapper());
  gh.lazySingleton<_i73.TransactionRepository>(() =>
      _i74.TransactionRepositoryImpl(get<_i75.TransactionsLocalDataSource>(),
          get<_i75.TransactionsRemoteDataSource>()));
  gh.factory<_i76.TransactionsBloc>(() => _i76.TransactionsBloc(
      get<_i12.GetIsFirstTimeOpen>(),
      get<_i46.GetTransactions>(),
      get<_i46.DeleteTransaction>(),
      get<_i46.BackUpTransactions>()));
  gh.lazySingleton<_i75.TransactionsDatabase>(
      () => dbInjectableModule.transctionsDatabase);
  gh.lazySingleton<_i77.TransactionsFirebaseProvider>(
      () => _i77.TransactionsFirebaseProvider(get<_i48.FirebaseFirestore>()));
  gh.lazySingleton<_i78.TransactionsLocalDataSource>(() =>
      _i78.TransactionsLocalDataSourceImpl(
          get<_i75.TransactionDao>(), get<_i75.TransactionMapper>()));
  gh.lazySingleton<_i79.TransactionsRemoteDataSource>(() =>
      _i79.TransactionsRemoteDataSourceImpl(
          get<_i75.TransactionsFirebaseProvider>()));
  gh.factory<_i80.UpdateAccount>(() => _i80.UpdateAccount(
      get<_i6.AccountRepository>(), get<_i50.GetAccounts>()));
  gh.factory<_i81.UpdateBudget>(() =>
      _i81.UpdateBudget(get<_i18.BudgetRepository>(), get<_i41.GetBudgets>()));
  gh.factory<_i82.UpdateCategory>(() => _i82.UpdateCategory(
      get<_i29.CategoryRepository>(), get<_i43.GetCategories>()));
  gh.factory<_i83.UpdateSubCategory>(() => _i83.UpdateSubCategory(
      get<_i29.SubCategoryRepository>(), get<_i43.GetSubCategories>()));
  gh.factory<_i84.UpdateTransaction>(() => _i84.UpdateTransaction(
      get<_i73.TransactionRepository>(), get<_i46.GetTransactions>()));
  gh.lazySingleton<_i85.UserFirebaseProvider>(() => _i85.UserFirebaseProvider(
      get<_i49.FirebaseStorage>(), get<_i48.FirebaseFirestore>()));
  gh.lazySingleton<_i86.AccountsFirebaseProvider>(
      () => _i86.AccountsFirebaseProvider(get<_i48.FirebaseFirestore>()));
  gh.factory<_i87.AddTransaction>(() => _i87.AddTransaction(
      get<_i73.TransactionRepository>(), get<_i12.GetProfileInfo>()));
  gh.lazySingleton<_i88.AuthService>(() => _i89.AuthServiceImpl(
      get<_i47.FirebaseAuth>(),
      get<_i53.GoogleSignIn>(),
      get<_i85.UserFirebaseProvider>()));
  gh.factory<_i90.BackUpBudgets>(() => _i90.BackUpBudgets(
      get<_i12.GetProfileInfo>(), get<_i18.BudgetRepository>()));
  gh.factory<_i91.BackUpCategories>(() => _i91.BackUpCategories(
      get<_i12.GetProfileInfo>(), get<_i29.CategoryRepository>()));
  gh.factory<_i92.BackUpTransactions>(() => _i92.BackUpTransactions(
      get<_i12.GetProfileInfo>(), get<_i73.TransactionRepository>()));
  gh.lazySingleton<_i93.BudgetsFirebaseProvider>(
      () => _i93.BudgetsFirebaseProvider(get<_i48.FirebaseFirestore>()));
  gh.lazySingleton<_i94.CategoriesFirebaseProvider>(
      () => _i94.CategoriesFirebaseProvider(get<_i48.FirebaseFirestore>()));
  gh.factory<_i95.CheckAuthStatus>(
      () => _i95.CheckAuthStatus(get<_i88.AuthService>()));
  gh.factory<_i96.CreateSubCategory>(
      () => _i96.CreateSubCategory(get<_i29.SubCategoryRepository>()));
  gh.factory<_i97.CreateUser>(() => _i97.CreateUser(get<_i88.AuthService>()));
  gh.factory<_i98.DeleteSubCategory>(
      () => _i98.DeleteSubCategory(get<_i29.SubCategoryRepository>()));
  gh.factory<_i99.DeleteTransaction>(
      () => _i99.DeleteTransaction(get<_i73.TransactionRepository>()));
  gh.factory<_i100.GetProfileInfo>(
      () => _i100.GetProfileInfo(get<_i88.AuthService>()));
  gh.factory<_i101.GetSubCategories>(
      () => _i101.GetSubCategories(get<_i29.SubCategoryRepository>()));
  gh.factory<_i102.GetTransactions>(() => _i102.GetTransactions(
      get<_i73.TransactionRepository>(), get<_i12.GetProfileInfo>()));
  gh.factory<_i103.LogOut>(() => _i103.LogOut(get<_i88.AuthService>()));
  gh.lazySingleton<_i88.PreferencesService>(
      () => _i104.ImplPreferencesService(get<_i66.SharedPreferences>()));
  gh.factory<_i105.ResetCategories>(() => _i105.ResetCategories(
      get<_i29.CategoryRepository>(), get<_i29.SubCategoryRepository>()));
  gh.factory<_i106.ResetTransactions>(
      () => _i106.ResetTransactions(get<_i73.TransactionRepository>()));
  gh.factory<_i107.SetDefaultSubCategories>(
      () => _i107.SetDefaultSubCategories(get<_i29.SubCategoryRepository>()));
  gh.factory<_i108.SetFirstTimeOpenToFalse>(
      () => _i108.SetFirstTimeOpenToFalse(get<_i88.PreferencesService>()));
  gh.factory<_i109.SignIn>(() => _i109.SignIn(get<_i88.AuthService>()));
  gh.factory<_i110.UpdateUserInfo>(
      () => _i110.UpdateUserInfo(get<_i88.AuthService>()));
  gh.factory<_i111.GetIsFirstTimeOpen>(
      () => _i111.GetIsFirstTimeOpen(get<_i88.PreferencesService>()));
  return get;
}

class _$DbInjectableModule extends _i112.DbInjectableModule {}

class _$FirebaseInjectableModule extends _i113.FirebaseInjectableModule {}

class _$ImagePickerInjectableModule extends _i114.ImagePickerInjectableModule {}

class _$PreferencesInjectableModule extends _i115.PreferencesInjectableModule {}
