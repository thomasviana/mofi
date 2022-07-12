// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i50;
import 'package:cron/cron.dart' as _i34;
import 'package:firebase_auth/firebase_auth.dart' as _i49;
import 'package:firebase_storage/firebase_storage.dart' as _i51;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i55;
import 'package:image_picker/image_picker.dart' as _i57;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i72;

import '../core/accounts/application.dart' as _i40;
import '../core/accounts/domain.dart' as _i6;
import '../core/accounts/infrastructure.dart' as _i8;
import '../core/accounts/src/application/back_up_accounts.dart' as _i14;
import '../core/accounts/src/application/create_account.dart' as _i31;
import '../core/accounts/src/application/delete_account.dart' as _i36;
import '../core/accounts/src/application/get_accounts.dart' as _i52;
import '../core/accounts/src/application/reset_accounts.dart' as _i62;
import '../core/accounts/src/application/set_default_accounts.dart' as _i68;
import '../core/accounts/src/application/update_account.dart' as _i84;
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
    as _i90;
import '../core/accounts/src/infrastructure/datasources/remote/accounts_remote_data_source.dart'
    as _i10;
import '../core/budgets/application.dart' as _i42;
import '../core/budgets/domain.dart' as _i18;
import '../core/budgets/infrastructure.dart' as _i20;
import '../core/budgets/src/application/back_up_budgets.dart' as _i94;
import '../core/budgets/src/application/create_budget.dart' as _i32;
import '../core/budgets/src/application/delete_budget.dart' as _i37;
import '../core/budgets/src/application/get_budgets.dart' as _i53;
import '../core/budgets/src/application/reset_budgets.dart' as _i63;
import '../core/budgets/src/application/set_default_budgets.dart' as _i69;
import '../core/budgets/src/application/update_budget.dart' as _i85;
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
    as _i97;
import '../core/budgets/src/infrastructure/datasources/remote/budgets_remote_data_source.dart'
    as _i22;
import '../core/categories/application.dart' as _i44;
import '../core/categories/domain.dart' as _i29;
import '../core/categories/infrastructure.dart' as _i23;
import '../core/categories/src/application/back_up_categories.dart' as _i95;
import '../core/categories/src/application/create_category.dart' as _i33;
import '../core/categories/src/application/create_sub_category.dart' as _i100;
import '../core/categories/src/application/delete_category.dart' as _i38;
import '../core/categories/src/application/delete_sub_category.dart' as _i103;
import '../core/categories/src/application/get_categories.dart' as _i54;
import '../core/categories/src/application/get_sub_categories.dart' as _i107;
import '../core/categories/src/application/reset_categories.dart' as _i111;
import '../core/categories/src/application/set_default_categories.dart' as _i70;
import '../core/categories/src/application/set_default_sub_categories.dart'
    as _i114;
import '../core/categories/src/application/update_category.dart' as _i86;
import '../core/categories/src/application/update_sub_category.dart' as _i87;
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
    as _i74;
import '../core/categories/src/infrastructure/datasources/remote/categories_firebase_provider.dart'
    as _i98;
import '../core/categories/src/infrastructure/datasources/remote/categories_remote_data_source.dart'
    as _i25;
import '../core/categories/src/infrastructure/sub_category_repository_impl.dart'
    as _i75;
import '../core/transactions/application.dart' as _i46;
import '../core/transactions/domain.dart' as _i77;
import '../core/transactions/infrastructure.dart' as _i79;
import '../core/transactions/src/application/add_transaction.dart' as _i91;
import '../core/transactions/src/application/back_up_transactions.dart' as _i96;
import '../core/transactions/src/application/delete_scheduled_transaction.dart'
    as _i102;
import '../core/transactions/src/application/delete_transaction.dart' as _i104;
import '../core/transactions/src/application/get_scheduled_transactions.dart'
    as _i106;
import '../core/transactions/src/application/get_transactions.dart' as _i108;
import '../core/transactions/src/application/reset_transactions.dart' as _i112;
import '../core/transactions/src/application/schedule_transaction.dart'
    as _i113;
import '../core/transactions/src/application/update_transaction.dart' as _i88;
import '../core/transactions/src/infrastructure/datasources/local/scheduled_transaction_mapper.dart'
    as _i66;
import '../core/transactions/src/infrastructure/datasources/local/transaction_mapper.dart'
    as _i76;
import '../core/transactions/src/infrastructure/datasources/local/transactions_db.dart'
    as _i65;
import '../core/transactions/src/infrastructure/datasources/local/transactions_local_data_source.dart'
    as _i82;
import '../core/transactions/src/infrastructure/datasources/local/transactions_table.dart'
    as _i64;
import '../core/transactions/src/infrastructure/datasources/remote/transactions_firebase_provider.dart'
    as _i81;
import '../core/transactions/src/infrastructure/datasources/remote/transactions_remote_data_source.dart'
    as _i83;
import '../core/transactions/src/infrastructure/transaction_repository_impl.dart'
    as _i78;
import '../core/user/application.dart' as _i12;
import '../core/user/domain.dart' as _i92;
import '../core/user/src/application/check_auth_status.dart' as _i99;
import '../core/user/src/application/create_user.dart' as _i101;
import '../core/user/src/application/get_is_first_time_open.dart' as _i118;
import '../core/user/src/application/get_profile_info.dart' as _i105;
import '../core/user/src/application/log_out.dart' as _i109;
import '../core/user/src/application/pick_user_image.dart' as _i60;
import '../core/user/src/application/set_is_first_time_open_false.dart'
    as _i115;
import '../core/user/src/application/sign_in.dart' as _i116;
import '../core/user/src/application/update_user_info.dart' as _i117;
import '../core/user/src/infrastructure/auth/auth_service_impl.dart' as _i93;
import '../core/user/src/infrastructure/auth/user_firebase_provider.dart'
    as _i89;
import '../core/user/src/infrastructure/preferences/preferences_service_impl.dart'
    as _i110;
import '../presentation/core/auth/auth_bloc.dart' as _i11;
import '../presentation/core/date/date_bloc.dart' as _i35;
import '../presentation/core/settings/settings_bloc.dart' as _i71;
import '../presentation/core/stats/stats_bloc.dart' as _i73;
import '../presentation/core/transactions/transactions_bloc.dart' as _i80;
import '../presentation/core/transactions_scheduled/scheduled_transactions_bloc.dart'
    as _i67;
import '../presentation/screens/accounts/edit_account_bloc/edit_account_screen_bloc.dart'
    as _i39;
import '../presentation/screens/auth/cubit/auth_screen_cubit.dart' as _i13;
import '../presentation/screens/budgets/edit_budget_bloc/edit_budget_screen_bloc.dart'
    as _i41;
import '../presentation/screens/categories/edit_category_bloc/edit_category_screen_bloc.dart'
    as _i43;
import '../presentation/screens/categories/edit_sub_category_bloc/edit_sub_category_screen_bloc.dart'
    as _i47;
import '../presentation/screens/home/home_bloc/home_screen_bloc.dart' as _i56;
import '../presentation/screens/main/main_app_cubit/main_screen_cubit.dart'
    as _i58;
import '../presentation/screens/profile/profile_screen_bloc/profile_sceen_bloc.dart'
    as _i61;
import '../presentation/screens/transactions/edit_transaction_bloc/edit_transaction_screen_bloc.dart'
    as _i48;
import '../presentation/screens/transactions/manage_income_bloc/manage_income_screen_bloc.dart'
    as _i59;
import '../presentation/screens/transactions_scheduled/edit_scheduled_transaction_bloc/edit_scheduled_transaction_screen_bloc.dart'
    as _i45;
import 'db_injectable_module.dart' as _i119;
import 'firebase_injectable_module.dart' as _i121;
import 'packages_injectable_module.dart' as _i120;
import 'preferences_injectable_module.dart'
    as _i122; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final dbInjectableModule = _$DbInjectableModule();
  final packagesInjectableModule = _$PackagesInjectableModule();
  final firebaseInjectableModule = _$FirebaseInjectableModule();
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
  gh.lazySingleton<_i34.Cron>(() => packagesInjectableModule.cron);
  gh.factory<_i35.DateBloc>(() => _i35.DateBloc());
  gh.factory<_i36.DeleteAccount>(
      () => _i36.DeleteAccount(get<_i6.AccountRepository>()));
  gh.factory<_i37.DeleteBudget>(
      () => _i37.DeleteBudget(get<_i18.BudgetRepository>()));
  gh.factory<_i38.DeleteCategory>(
      () => _i38.DeleteCategory(get<_i29.CategoryRepository>()));
  gh.factory<_i39.EditAccountScreenBloc>(() => _i39.EditAccountScreenBloc(
      get<_i40.UpdateAccount>(),
      get<_i40.DeleteAccount>(),
      get<_i12.GetProfileInfo>(),
      get<_i40.CreateAccount>()));
  gh.factory<_i41.EditBudgetScreenBloc>(() => _i41.EditBudgetScreenBloc(
      get<_i42.UpdateBudget>(),
      get<_i42.DeleteBudget>(),
      get<_i42.CreateBudget>()));
  gh.factory<_i43.EditCategoryScreenBloc>(() => _i43.EditCategoryScreenBloc(
      get<_i44.UpdateCategory>(),
      get<_i44.UpdateSubCategory>(),
      get<_i44.DeleteCategory>(),
      get<_i44.GetSubCategories>(),
      get<_i44.CreateSubCategory>(),
      get<_i44.CreateCategory>()));
  gh.factory<_i45.EditScheduledTransactionScreenBloc>(() =>
      _i45.EditScheduledTransactionScreenBloc(get<_i46.ScheduleTransaction>(),
          get<_i46.GetScheduledTransactions>(), get<_i44.GetSubCategories>()));
  gh.factory<_i47.EditSubCategoryScreenBloc>(() =>
      _i47.EditSubCategoryScreenBloc(
          get<_i44.UpdateSubCategory>(), get<_i44.DeleteSubCategory>()));
  gh.factory<_i48.EditTransactionScreenBloc>(() =>
      _i48.EditTransactionScreenBloc(
          get<_i46.UpdateTransaction>(),
          get<_i46.DeleteTransaction>(),
          get<_i46.AddTransaction>(),
          get<_i44.GetSubCategories>()));
  gh.lazySingleton<_i49.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i50.FirebaseFirestore>(
      () => firebaseInjectableModule.firebaseFirestore);
  gh.lazySingleton<_i51.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseStorage);
  gh.factory<_i52.GetAccounts>(() => _i52.GetAccounts(
      get<_i6.AccountRepository>(), get<_i12.GetProfileInfo>()));
  gh.factory<_i53.GetBudgets>(() => _i53.GetBudgets(
      get<_i18.BudgetRepository>(), get<_i12.GetProfileInfo>()));
  gh.factory<_i54.GetCategories>(() => _i54.GetCategories(
      get<_i29.CategoryRepository>(), get<_i12.GetProfileInfo>()));
  gh.lazySingleton<_i55.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.factory<_i56.HomeScreenBloc>(
      () => _i56.HomeScreenBloc(get<_i12.GetProfileInfo>()));
  gh.lazySingleton<_i57.ImagePicker>(
      () => packagesInjectableModule.imagePicker);
  gh.factory<_i58.MainScreenCubit>(() => _i58.MainScreenCubit());
  gh.factory<_i59.ManageIncomeScreenBloc>(() => _i59.ManageIncomeScreenBloc(
      get<_i42.UpdateBudget>(), get<_i46.UpdateTransaction>()));
  gh.factory<_i60.PickUserImage>(
      () => _i60.PickUserImage(get<_i57.ImagePicker>()));
  gh.factory<_i61.ProfileScreenBloc>(() => _i61.ProfileScreenBloc(
      get<_i12.GetProfileInfo>(),
      get<_i12.UpdateUserInfo>(),
      get<_i12.PickUserImage>()));
  gh.factory<_i62.ResetAccounts>(
      () => _i62.ResetAccounts(get<_i6.AccountRepository>()));
  gh.factory<_i63.ResetBudgets>(
      () => _i63.ResetBudgets(get<_i18.BudgetRepository>()));
  gh.lazySingleton<_i64.ScheduledTransactionDao>(
      () => _i64.ScheduledTransactionDao(get<_i65.TransactionsDatabase>()));
  gh.lazySingleton<_i66.ScheduledTransactionMapper>(
      () => _i66.ScheduledTransactionMapper());
  gh.factory<_i67.ScheduledTransactionsBloc>(() =>
      _i67.ScheduledTransactionsBloc(
          get<_i12.GetIsFirstTimeOpen>(),
          get<_i46.GetScheduledTransactions>(),
          get<_i46.DeleteScheduledTransaction>()));
  gh.factory<_i68.SetDefaultAccounts>(() => _i68.SetDefaultAccounts(
      get<_i12.GetProfileInfo>(), get<_i6.AccountRepository>()));
  gh.factory<_i69.SetDefaultBudgets>(() => _i69.SetDefaultBudgets(
      get<_i18.BudgetRepository>(), get<_i12.GetProfileInfo>()));
  gh.factory<_i70.SetDefaultCategories>(() => _i70.SetDefaultCategories(
      get<_i12.GetProfileInfo>(), get<_i29.CategoryRepository>()));
  gh.factory<_i71.SettingsBloc>(() => _i71.SettingsBloc(
      get<_i12.GetIsFirstTimeOpen>(),
      get<_i12.SetFirstTimeOpenToFalse>(),
      get<_i40.GetAccounts>(),
      get<_i44.GetCategories>(),
      get<_i44.GetSubCategories>(),
      get<_i42.GetBudgets>(),
      get<_i40.SetDefaultAccounts>(),
      get<_i44.SetDefaultCategories>(),
      get<_i44.SetDefaultSubCategories>(),
      get<_i42.SetDefaultBudgets>(),
      get<_i40.ResetAccounts>(),
      get<_i44.ResetCategories>(),
      get<_i42.ResetBudgets>(),
      get<_i46.ResetTransactions>(),
      get<_i44.BackUpCategories>(),
      get<_i40.BackUpAccounts>(),
      get<_i42.BackUpBudgets>()));
  await gh.factoryAsync<_i72.SharedPreferences>(
      () => preferencesInjectableModule.preferences,
      preResolve: true);
  gh.factory<_i73.StatsBloc>(() => _i73.StatsBloc(
      get<_i12.GetIsFirstTimeOpen>(),
      get<_i12.SetFirstTimeOpenToFalse>(),
      get<_i42.GetBudgets>(),
      get<_i44.GetCategories>(),
      get<_i40.GetAccounts>(),
      get<_i46.GetTransactions>()));
  gh.lazySingleton<_i26.SubCategoryDao>(
      () => _i26.SubCategoryDao(get<_i27.CategoriesDatabase>()));
  gh.lazySingleton<_i74.SubCategoryMapper>(() => _i74.SubCategoryMapper());
  gh.lazySingleton<_i29.SubCategoryRepository>(() =>
      _i75.SubCategoryRepositoryImpl(get<_i23.CategoriesLocalDataSource>(),
          get<_i23.CategoriesRemoteDataSource>()));
  gh.lazySingleton<_i64.TransactionDao>(
      () => _i64.TransactionDao(get<_i65.TransactionsDatabase>()));
  gh.lazySingleton<_i76.TransactionMapper>(() => _i76.TransactionMapper());
  gh.lazySingleton<_i77.TransactionRepository>(() =>
      _i78.TransactionRepositoryImpl(get<_i79.TransactionsLocalDataSource>(),
          get<_i79.TransactionsRemoteDataSource>()));
  gh.factory<_i80.TransactionsBloc>(() => _i80.TransactionsBloc(
      get<_i12.GetIsFirstTimeOpen>(),
      get<_i46.GetTransactions>(),
      get<_i46.DeleteTransaction>(),
      get<_i46.BackUpTransactions>()));
  gh.lazySingleton<_i79.TransactionsDatabase>(
      () => dbInjectableModule.transctionsDatabase);
  gh.lazySingleton<_i81.TransactionsFirebaseProvider>(
      () => _i81.TransactionsFirebaseProvider(get<_i50.FirebaseFirestore>()));
  gh.lazySingleton<_i82.TransactionsLocalDataSource>(() =>
      _i82.TransactionsLocalDataSourceImpl(
          get<_i79.TransactionDao>(),
          get<_i79.ScheduledTransactionDao>(),
          get<_i79.TransactionMapper>(),
          get<_i79.ScheduledTransactionMapper>()));
  gh.lazySingleton<_i83.TransactionsRemoteDataSource>(() =>
      _i83.TransactionsRemoteDataSourceImpl(
          get<_i79.TransactionsFirebaseProvider>()));
  gh.factory<_i84.UpdateAccount>(() => _i84.UpdateAccount(
      get<_i6.AccountRepository>(), get<_i52.GetAccounts>()));
  gh.factory<_i85.UpdateBudget>(() =>
      _i85.UpdateBudget(get<_i18.BudgetRepository>(), get<_i42.GetBudgets>()));
  gh.factory<_i86.UpdateCategory>(() => _i86.UpdateCategory(
      get<_i29.CategoryRepository>(), get<_i44.GetCategories>()));
  gh.factory<_i87.UpdateSubCategory>(() => _i87.UpdateSubCategory(
      get<_i29.SubCategoryRepository>(), get<_i44.GetSubCategories>()));
  gh.factory<_i88.UpdateTransaction>(() => _i88.UpdateTransaction(
      get<_i77.TransactionRepository>(), get<_i46.GetTransactions>()));
  gh.lazySingleton<_i89.UserFirebaseProvider>(() => _i89.UserFirebaseProvider(
      get<_i51.FirebaseStorage>(), get<_i50.FirebaseFirestore>()));
  gh.lazySingleton<_i90.AccountsFirebaseProvider>(
      () => _i90.AccountsFirebaseProvider(get<_i50.FirebaseFirestore>()));
  gh.factory<_i91.AddTransaction>(() => _i91.AddTransaction(
      get<_i77.TransactionRepository>(), get<_i12.GetProfileInfo>()));
  gh.lazySingleton<_i92.AuthService>(() => _i93.AuthServiceImpl(
      get<_i49.FirebaseAuth>(),
      get<_i55.GoogleSignIn>(),
      get<_i89.UserFirebaseProvider>()));
  gh.factory<_i94.BackUpBudgets>(() => _i94.BackUpBudgets(
      get<_i12.GetProfileInfo>(), get<_i18.BudgetRepository>()));
  gh.factory<_i95.BackUpCategories>(() => _i95.BackUpCategories(
      get<_i12.GetProfileInfo>(), get<_i29.CategoryRepository>()));
  gh.factory<_i96.BackUpTransactions>(() => _i96.BackUpTransactions(
      get<_i12.GetProfileInfo>(), get<_i77.TransactionRepository>()));
  gh.lazySingleton<_i97.BudgetsFirebaseProvider>(
      () => _i97.BudgetsFirebaseProvider(get<_i50.FirebaseFirestore>()));
  gh.lazySingleton<_i98.CategoriesFirebaseProvider>(
      () => _i98.CategoriesFirebaseProvider(get<_i50.FirebaseFirestore>()));
  gh.factory<_i99.CheckAuthStatus>(
      () => _i99.CheckAuthStatus(get<_i92.AuthService>()));
  gh.factory<_i100.CreateSubCategory>(
      () => _i100.CreateSubCategory(get<_i29.SubCategoryRepository>()));
  gh.factory<_i101.CreateUser>(() => _i101.CreateUser(get<_i92.AuthService>()));
  gh.factory<_i102.DeleteScheduledTransaction>(() =>
      _i102.DeleteScheduledTransaction(get<_i77.TransactionRepository>()));
  gh.factory<_i103.DeleteSubCategory>(
      () => _i103.DeleteSubCategory(get<_i29.SubCategoryRepository>()));
  gh.factory<_i104.DeleteTransaction>(
      () => _i104.DeleteTransaction(get<_i77.TransactionRepository>()));
  gh.factory<_i105.GetProfileInfo>(
      () => _i105.GetProfileInfo(get<_i92.AuthService>()));
  gh.factory<_i106.GetScheduledTransactions>(() =>
      _i106.GetScheduledTransactions(
          get<_i77.TransactionRepository>(), get<_i12.GetProfileInfo>()));
  gh.factory<_i107.GetSubCategories>(
      () => _i107.GetSubCategories(get<_i29.SubCategoryRepository>()));
  gh.factory<_i108.GetTransactions>(() => _i108.GetTransactions(
      get<_i77.TransactionRepository>(), get<_i12.GetProfileInfo>()));
  gh.factory<_i109.LogOut>(() => _i109.LogOut(get<_i92.AuthService>()));
  gh.lazySingleton<_i92.PreferencesService>(
      () => _i110.ImplPreferencesService(get<_i72.SharedPreferences>()));
  gh.factory<_i111.ResetCategories>(() => _i111.ResetCategories(
      get<_i29.CategoryRepository>(), get<_i29.SubCategoryRepository>()));
  gh.factory<_i112.ResetTransactions>(
      () => _i112.ResetTransactions(get<_i77.TransactionRepository>()));
  gh.factory<_i113.ScheduleTransaction>(() => _i113.ScheduleTransaction(
      get<_i77.TransactionRepository>(),
      get<_i12.GetProfileInfo>(),
      get<_i34.Cron>()));
  gh.factory<_i114.SetDefaultSubCategories>(
      () => _i114.SetDefaultSubCategories(get<_i29.SubCategoryRepository>()));
  gh.factory<_i115.SetFirstTimeOpenToFalse>(
      () => _i115.SetFirstTimeOpenToFalse(get<_i92.PreferencesService>()));
  gh.factory<_i116.SignIn>(() => _i116.SignIn(get<_i92.AuthService>()));
  gh.factory<_i117.UpdateUserInfo>(
      () => _i117.UpdateUserInfo(get<_i92.AuthService>()));
  gh.factory<_i118.GetIsFirstTimeOpen>(
      () => _i118.GetIsFirstTimeOpen(get<_i92.PreferencesService>()));
  return get;
}

class _$DbInjectableModule extends _i119.DbInjectableModule {}

class _$PackagesInjectableModule extends _i120.PackagesInjectableModule {}

class _$FirebaseInjectableModule extends _i121.FirebaseInjectableModule {}

class _$PreferencesInjectableModule extends _i122.PreferencesInjectableModule {}
