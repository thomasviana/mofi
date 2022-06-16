import '../../../../presentation/resources/colors.dart';
import 'category_model.dart';

class SubCategory extends CategoryModel {
  CategoryId categoryId;
  SubCategory({
    required CategoryId id,
    required String name,
    required int icon,
    required int color,
    required this.categoryId,
  }) : super(
          id: id,
          name: name,
          icon: icon,
          color: color,
        );

  SubCategory copyWith({
    String? name,
    int? icon,
    int? color,
    CategoryId? categoryId,
  }) {
    return SubCategory(
      id: id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  // ??????  HOUSING

  factory SubCategory.housing() => SubCategory(
        id: CategoryId('01_housing'),
        name: 'Vivienda (general)',
        icon: 0xe318,
        color: CategoryColors.amber,
        categoryId: CategoryId('01_housing'),
      );

  factory SubCategory.rent() => SubCategory(
        id: CategoryId('01_rent'),
        name: 'Arriendo',
        icon: 0xe318,
        color: CategoryColors.amber,
        categoryId: CategoryId('01_housing'),
      );

  factory SubCategory.morgage() => SubCategory(
        id: CategoryId('02_morgage'),
        name: 'Hipoteca',
        icon: 0xe318,
        color: CategoryColors.amber,
        categoryId: CategoryId('01_housing'),
      );

  factory SubCategory.housingServices() => SubCategory(
        id: CategoryId('03_housingServices'),
        name: 'Servicios Públicos',
        icon: 0xe318,
        color: CategoryColors.amber,
        categoryId: CategoryId('01_housing'),
      );

  factory SubCategory.admin() => SubCategory(
        id: CategoryId('04_admin'),
        name: 'Administración',
        icon: 0xe318,
        color: CategoryColors.amber,
        categoryId: CategoryId('01_housing'),
      );

  factory SubCategory.houseMaintenance() => SubCategory(
        id: CategoryId('05_houseMaintenance'),
        name: 'Mantenimiento',
        icon: 0xe318,
        color: CategoryColors.amber,
        categoryId: CategoryId('01_housing'),
      );

  factory SubCategory.propertyTaxes() => SubCategory(
        id: CategoryId('06_propertyTaxes'),
        name: 'Impuesto predial',
        icon: 0xe318,
        color: CategoryColors.amber,
        categoryId: CategoryId('01_housing'),
      );

  // ??????  FOOD

  factory SubCategory.food() => SubCategory(
        id: CategoryId('02_food'),
        name: 'Alimentación (general)',
        icon: 0xe532,
        color: CategoryColors.red,
        categoryId: CategoryId('02_food'),
      );

  factory SubCategory.generalFood() => SubCategory(
        id: CategoryId('01_generalFood'),
        name: 'Mercado general',
        icon: 0xe532,
        color: CategoryColors.red,
        categoryId: CategoryId('02_food'),
      );

  factory SubCategory.meats() => SubCategory(
        id: CategoryId('02_meats'),
        name: 'Carnes',
        icon: 0xe532,
        color: CategoryColors.red,
        categoryId: CategoryId('02_food'),
      );

  factory SubCategory.fruitsAndVegetables() => SubCategory(
        id: CategoryId('03_fruitsAndVegetables'),
        name: 'Frutas y verduras',
        icon: 0xe532,
        color: CategoryColors.red,
        categoryId: CategoryId('02_food'),
      );

  factory SubCategory.miscellaneous() => SubCategory(
        id: CategoryId('04_miscellaneous'),
        name: 'Otros',
        icon: 0xe532,
        color: CategoryColors.red,
        categoryId: CategoryId('02_food'),
      );

  // ??????  TRANSPORTATION

  factory SubCategory.transportation() => SubCategory(
        id: CategoryId('03_transportation'),
        name: 'Transporte (general)',
        icon: 0xf6b0,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('03_transportation'),
      );

  factory SubCategory.publicTransport() => SubCategory(
        id: CategoryId('01_publicTransport'),
        name: 'Transporte público',
        icon: 0xf6b0,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('03_transportation'),
      );

  factory SubCategory.uber() => SubCategory(
        id: CategoryId('02_uber'),
        name: 'Uber / Taxi',
        icon: 0xf880,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('03_transportation'),
      );

  factory SubCategory.tolls() => SubCategory(
        id: CategoryId('03_tolls'),
        name: 'Peajes',
        icon: 0xf0242,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('03_transportation'),
      );

  factory SubCategory.gas() => SubCategory(
        id: CategoryId('04_gas'),
        name: 'Gasolina',
        icon: 0xf86d,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('03_transportation'),
      );

  factory SubCategory.parking() => SubCategory(
        id: CategoryId('05_parking'),
        name: 'Parqueadero',
        icon: 0xf876,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('03_transportation'),
      );

  factory SubCategory.carCredit() => SubCategory(
        id: CategoryId('06_carCredit'),
        name: 'Cuota vehicular',
        icon: 0xf618,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('03_transportation'),
      );

  factory SubCategory.carAssurance() => SubCategory(
        id: CategoryId('07_carAssurance'),
        name: 'Seguro vehicular',
        icon: 0xf013e,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('03_transportation'),
      );

  factory SubCategory.carTaxes() => SubCategory(
        id: CategoryId('08_carTaxes'),
        name: 'Impuesto vehicular',
        icon: 0xf021b,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('03_transportation'),
      );

  factory SubCategory.maintenance() => SubCategory(
        id: CategoryId('09_maintenance'),
        name: 'Mantenimiento',
        icon: 0xf619,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('03_transportation'),
      );

  factory SubCategory.carWash() => SubCategory(
        id: CategoryId('10_carWash'),
        name: 'Lavada',
        icon: 0xf867,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('03_transportation'),
      );

  // ??????  HEALTH CARE

  factory SubCategory.healthCare() => SubCategory(
        id: CategoryId('04_healthCare'),
        name: 'Salud (general)',
        icon: 0xf013e,
        color: CategoryColors.cyan,
        categoryId: CategoryId('04_healthCare'),
      );

  factory SubCategory.publicHealth() => SubCategory(
        id: CategoryId('01_publicHealth'),
        name: 'Eps / Seguridad Social',
        icon: 0xf013e,
        color: CategoryColors.cyan,
        categoryId: CategoryId('04_healthCare'),
      );

  factory SubCategory.healthCarePlan() => SubCategory(
        id: CategoryId('02_healthCarePlan'),
        name: 'Medicina prepagada',
        icon: 0xf7df,
        color: CategoryColors.cyan,
        categoryId: CategoryId('04_healthCare'),
      );

  factory SubCategory.medicalAppointments() => SubCategory(
        id: CategoryId('03_medicalAppointments'),
        name: 'Citas médicas',
        icon: 0xf7de,
        color: CategoryColors.cyan,
        categoryId: CategoryId('04_healthCare'),
      );

  factory SubCategory.medicines() => SubCategory(
        id: CategoryId('04_medicines'),
        name: 'Medicamentos',
        icon: 0xe3d9,
        color: CategoryColors.cyan,
        categoryId: CategoryId('04_healthCare'),
      );

  // ??????  SERVICES

  factory SubCategory.services() => SubCategory(
        id: CategoryId('05_services'),
        name: 'Servicios (general)',
        icon: 0xf0078,
        color: CategoryColors.indigo,
        categoryId: CategoryId('05_services'),
      );

  factory SubCategory.cellPhonePlan() => SubCategory(
        id: CategoryId('01_cellPhonePlan'),
        name: 'Plan celular',
        icon: 0xf0078,
        color: CategoryColors.indigo,
        categoryId: CategoryId('05_services'),
      );

  factory SubCategory.homePlan() => SubCategory(
        id: CategoryId('02_homePlan'),
        name: 'Plan hogar (Wifi, TV)',
        icon: 0xe6e7,
        color: CategoryColors.indigo,
        categoryId: CategoryId('05_services'),
      );

  factory SubCategory.subscriptions() => SubCategory(
        id: CategoryId('03_subscriptions'),
        name: 'Suscripciones',
        icon: 0xf860,
        color: CategoryColors.indigo,
        categoryId: CategoryId('05_services'),
      );

  factory SubCategory.otherServices() => SubCategory(
        id: CategoryId('04_otherServices'),
        name: 'Otros servicios',
        icon: 0xf7f4,
        color: CategoryColors.indigo,
        categoryId: CategoryId('05_services'),
      );

  // ??????  RECREATION

  factory SubCategory.recreation() => SubCategory(
        id: CategoryId('06_recreation'),
        name: 'Diversión (general)',
        icon: 0xf0112,
        color: CategoryColors.purple,
        categoryId: CategoryId('06_recreation'),
      );

  factory SubCategory.restaurants() => SubCategory(
        id: CategoryId('01_restaurants'),
        name: 'Restaurantes',
        icon: 0xf0112,
        color: CategoryColors.purple,
        categoryId: CategoryId('06_recreation'),
      );

  factory SubCategory.cinema() => SubCategory(
        id: CategoryId('02_cinema'),
        name: 'Cine',
        icon: 0xed7e,
        color: CategoryColors.purple,
        categoryId: CategoryId('06_recreation'),
      );

  factory SubCategory.events() => SubCategory(
        id: CategoryId('03_events'),
        name: 'Otros eventos',
        icon: 0xe23e,
        color: CategoryColors.purple,
        categoryId: CategoryId('06_recreation'),
      );

  factory SubCategory.travels() => SubCategory(
        id: CategoryId('04_travels'),
        name: 'Viajes',
        icon: 0xf54c,
        color: CategoryColors.purple,
        categoryId: CategoryId('06_recreation'),
      );

  // ??????  SHOPPING

  factory SubCategory.shopping() => SubCategory(
        id: CategoryId('07_shopping'),
        name: 'Compras (general)',
        icon: 0xf016f,
        color: CategoryColors.blue,
        categoryId: CategoryId('07_shopping'),
      );

  factory SubCategory.clothes() => SubCategory(
        id: CategoryId('01_clothes'),
        name: 'Ropa',
        icon: 0xf016f,
        color: CategoryColors.blue,
        categoryId: CategoryId('07_shopping'),
      );

  factory SubCategory.home() => SubCategory(
        id: CategoryId('02_home'),
        name: 'Hogar',
        icon: 0xf0036,
        color: CategoryColors.blue,
        categoryId: CategoryId('07_shopping'),
      );

  factory SubCategory.electronics() => SubCategory(
        id: CategoryId('03_electronics'),
        name: 'Electronicos',
        icon: 0xf664,
        color: CategoryColors.blue,
        categoryId: CategoryId('07_shopping'),
      );

  factory SubCategory.healthAndBeauty() => SubCategory(
        id: CategoryId('04_healthAndBeauty'),
        name: 'Cuidado y belleza',
        icon: 0xf016f,
        color: CategoryColors.blue,
        categoryId: CategoryId('07_shopping'),
      );

  factory SubCategory.accessories() => SubCategory(
        id: CategoryId('05_accessories'),
        name: 'Accesorios',
        icon: 0xf016f,
        color: CategoryColors.blue,
        categoryId: CategoryId('07_shopping'),
      );

  factory SubCategory.gifts() => SubCategory(
        id: CategoryId('06_gifts'),
        name: 'Regalos',
        icon: 0xf61a,
        color: CategoryColors.blue,
        categoryId: CategoryId('07_shopping'),
      );

  // ??????  FINANCIAL

  factory SubCategory.financial() => SubCategory(
        id: CategoryId('08_financial'),
        name: 'Gastos financieros (general)',
        icon: 0xf58f,
        color: CategoryColors.green,
        categoryId: CategoryId('08_financial'),
      );

  factory SubCategory.loans() => SubCategory(
        id: CategoryId('01_loans'),
        name: 'Creditos',
        icon: 0xf58f,
        color: CategoryColors.green,
        categoryId: CategoryId('08_financial'),
      );

  factory SubCategory.creditCards() => SubCategory(
        id: CategoryId('02_creditCards'),
        name: 'Tarjetas de crédito',
        icon: 0xe19f,
        color: CategoryColors.green,
        categoryId: CategoryId('08_financial'),
      );

  factory SubCategory.assurances() => SubCategory(
        id: CategoryId('03_assurances'),
        name: 'Seguros',
        icon: 0xf013e,
        color: CategoryColors.green,
        categoryId: CategoryId('08_financial'),
      );

  factory SubCategory.taxes() => SubCategory(
        id: CategoryId('04_taxes'),
        name: 'Impuestos',
        icon: 0xf6ce,
        color: CategoryColors.green,
        categoryId: CategoryId('08_financial'),
      );

  // ??????  EDUCATION

  factory SubCategory.education() => SubCategory(
        id: CategoryId('09_education'),
        name: 'Educación (general)',
        icon: 63568,
        color: CategoryColors.deep_purple,
        categoryId: CategoryId('09_education'),
      );

  factory SubCategory.books() => SubCategory(
        id: CategoryId('01_books'),
        name: 'Libros',
        icon: 63568,
        color: CategoryColors.deep_purple,
        categoryId: CategoryId('09_education'),
      );

  factory SubCategory.courses() => SubCategory(
        id: CategoryId('02_courses'),
        name: 'Cursos',
        icon: 63568,
        color: CategoryColors.deep_purple,
        categoryId: CategoryId('09_education'),
      );

  factory SubCategory.educationalEvents() => SubCategory(
        id: CategoryId('03_educationalEvents'),
        name: 'Eventos educativos',
        icon: 63568,
        color: CategoryColors.deep_purple,
        categoryId: CategoryId('09_education'),
      );

  factory SubCategory.university() => SubCategory(
        id: CategoryId('04_university'),
        name: 'Universidad',
        icon: 63568,
        color: CategoryColors.deep_purple,
        categoryId: CategoryId('09_education'),
      );

  factory SubCategory.educationLoan() => SubCategory(
        id: CategoryId('05_educationLoan'),
        name: 'Crédito educativo',
        icon: 63568,
        color: CategoryColors.deep_purple,
        categoryId: CategoryId('09_education'),
      );

  // ??????  CONTRIBUTION

  factory SubCategory.contribution() => SubCategory(
        id: CategoryId('10_contribution'),
        name: 'Contribución (general)',
        icon: 983707,
        color: CategoryColors.pink,
        categoryId: CategoryId('10_contribution'),
      );

  factory SubCategory.donations() => SubCategory(
        id: CategoryId('01_donations'),
        name: 'Donaciones',
        icon: 983707,
        color: CategoryColors.pink,
        categoryId: CategoryId('10_contribution'),
      );

  factory SubCategory.curchTithe() => SubCategory(
        id: CategoryId('02_curchTithe'),
        name: 'Diezmo',
        icon: 983707,
        color: CategoryColors.pink,
        categoryId: CategoryId('10_contribution'),
      );

  factory SubCategory.offering() => SubCategory(
        id: CategoryId('03_offering'),
        name: 'Ofrendas',
        icon: 983707,
        color: CategoryColors.pink,
        categoryId: CategoryId('10_contribution'),
      );

  factory SubCategory.tips() => SubCategory(
        id: CategoryId('04_tips'),
        name: 'Propinas',
        icon: 983707,
        color: CategoryColors.pink,
        categoryId: CategoryId('10_contribution'),
      );

  // ??????  DEPENDENTS

  factory SubCategory.dependents() => SubCategory(
        id: CategoryId('11_dependents'),
        name: 'Dependientes (general)',
        icon: 58502,
        color: CategoryColors.orange,
        categoryId: CategoryId('11_dependents'),
      );

  factory SubCategory.familyDepenent() => SubCategory(
        id: CategoryId('01_familyDepenent'),
        name: 'Familiares dependientes',
        icon: 58502,
        color: CategoryColors.orange,
        categoryId: CategoryId('11_dependents'),
      );

  factory SubCategory.allowance() => SubCategory(
        id: CategoryId('02_allowance'),
        name: 'Mesadas',
        icon: 63036,
        color: CategoryColors.orange,
        categoryId: CategoryId('11_dependents'),
      );

  factory SubCategory.school() => SubCategory(
        id: CategoryId('03_school'),
        name: 'Colegio',
        icon: 983342,
        color: CategoryColors.orange,
        categoryId: CategoryId('11_dependents'),
      );

  factory SubCategory.pets() => SubCategory(
        id: CategoryId('04_pets'),
        name: 'Mascotas',
        icon: 983159,
        color: CategoryColors.orange,
        categoryId: CategoryId('11_dependents'),
      );

  // ??????  INVESTMENTS

  factory SubCategory.investments() => SubCategory(
        id: CategoryId('12_investments'),
        name: 'Inversiones (general)',
        icon: 63513,
        color: CategoryColors.teal,
        categoryId: CategoryId('12_investments'),
      );

  factory SubCategory.realEstate() => SubCategory(
        id: CategoryId('01_realEstate'),
        name: 'Propiedad raiz',
        icon: 983697,
        color: CategoryColors.teal,
        categoryId: CategoryId('12_investments'),
      );

  factory SubCategory.stocks() => SubCategory(
        id: CategoryId('02_stocks'),
        name: 'Mercado de valores',
        icon: 63513,
        color: CategoryColors.teal,
        categoryId: CategoryId('12_investments'),
      );

  factory SubCategory.shares() => SubCategory(
        id: CategoryId('03_shares'),
        name: 'Acciones',
        icon: 63513,
        color: CategoryColors.teal,
        categoryId: CategoryId('12_investments'),
      );

  factory SubCategory.financialInvestments() => SubCategory(
        id: CategoryId('04_financialInvestments'),
        name: 'Inversiones financieras',
        icon: 63513,
        color: CategoryColors.teal,
        categoryId: CategoryId('12_investments'),
      );

  factory SubCategory.nfts() => SubCategory(
        id: CategoryId('05_nfts'),
        name: 'NFTs',
        icon: 62849,
        color: CategoryColors.teal,
        categoryId: CategoryId('12_investments'),
      );

  factory SubCategory.crypto() => SubCategory(
        id: CategoryId('06_crypto'),
        name: 'Criptomonedas',
        icon: 59060,
        color: CategoryColors.teal,
        categoryId: CategoryId('12_investments'),
      );

  // !!!!!!!  SALARY

  factory SubCategory.salary() => SubCategory(
        id: CategoryId('01_salary'),
        name: 'Salario (general)',
        icon: 0xf58f,
        color: CategoryColors.amber,
        categoryId: CategoryId('01_salary'),
      );

  // !!!!!!!  HONORARIUM

  factory SubCategory.honorarium() => SubCategory(
        id: CategoryId('02_honorarium'),
        name: 'Honorarios (general)',
        icon: 0xf58f,
        color: CategoryColors.red,
        categoryId: CategoryId('02_honorarium'),
      );

  // !!!!!!!  RENT

  factory SubCategory.rental() => SubCategory(
        id: CategoryId('03_rental'),
        name: 'Rentas de capital (general)',
        icon: 0xf58f,
        color: CategoryColors.blue_grey,
        categoryId: CategoryId('03_rental'),
      );

  // !!!!!!!  BUSINESS

  factory SubCategory.business() => SubCategory(
        id: CategoryId('04_business'),
        name: 'Negocios (general)',
        icon: 0xf58f,
        color: CategoryColors.cyan,
        categoryId: CategoryId('04_business'),
      );

  // !!!!!!!  DIVIDENDS

  factory SubCategory.dividends() => SubCategory(
        id: CategoryId('05_dividends'),
        name: 'Dividendos (general)',
        icon: 0xf58f,
        color: CategoryColors.indigo,
        categoryId: CategoryId('05_dividends'),
      );

  // !!!!!!!  PENSIONS

  factory SubCategory.pension() => SubCategory(
        id: CategoryId('06_pension'),
        name: 'Pensión (general)',
        icon: 0xf58f,
        color: CategoryColors.purple,
        categoryId: CategoryId('06_pension'),
      );

  // !!!!!!!  OCASSIONAL

  factory SubCategory.occasional() => SubCategory(
        id: CategoryId('07_occasional'),
        name: 'Ocasional (general)',
        icon: 0xf58f,
        color: CategoryColors.blue,
        categoryId: CategoryId('07_occasional'),
      );

  // !!!!!!!  GIFT

  factory SubCategory.gift() => SubCategory(
        id: CategoryId('08_gift'),
        name: 'Regalos (general)',
        icon: 0xf58f,
        color: CategoryColors.teal,
        categoryId: CategoryId('08_gift'),
      );

  static List<SubCategory> allSubCategories = [
    ...housingSubCategories,
    ...foodSubCategories,
    ...transportationSubCategories,
    ...healthCareSubCategories,
    ...servicesSubCategories,
    ...recreationSubCategories,
    ...shoppingSubCategories,
    ...financialSubCategories,
    ...educationSubCategories,
    ...contributionSubCategories,
    ...dependentsSubCategories,
    ...investmentsSubCategories,
    ...incomeSubCategories
  ];

  static List<SubCategory> housingSubCategories = [
    SubCategory.housing(),
    SubCategory.rent(),
    SubCategory.morgage(),
    SubCategory.housingServices(),
    SubCategory.admin(),
    SubCategory.houseMaintenance(),
    SubCategory.propertyTaxes(),
  ];

  static List<SubCategory> foodSubCategories = [
    SubCategory.food(),
    SubCategory.generalFood(),
    SubCategory.meats(),
    SubCategory.fruitsAndVegetables(),
    SubCategory.miscellaneous(),
  ];

  static List<SubCategory> transportationSubCategories = [
    SubCategory.transportation(),
    SubCategory.publicTransport(),
    SubCategory.uber(),
    SubCategory.tolls(),
    SubCategory.gas(),
    SubCategory.parking(),
    SubCategory.carCredit(),
    SubCategory.carAssurance(),
    SubCategory.carTaxes(),
    SubCategory.maintenance(),
    SubCategory.carWash(),
  ];

  static List<SubCategory> healthCareSubCategories = [
    SubCategory.healthCare(),
    SubCategory.publicHealth(),
    SubCategory.healthCarePlan(),
    SubCategory.medicalAppointments(),
    SubCategory.medicines(),
  ];

  static List<SubCategory> servicesSubCategories = [
    SubCategory.services(),
    SubCategory.cellPhonePlan(),
    SubCategory.homePlan(),
    SubCategory.subscriptions(),
    SubCategory.otherServices(),
  ];

  static List<SubCategory> recreationSubCategories = [
    SubCategory.recreation(),
    SubCategory.restaurants(),
    SubCategory.cinema(),
    SubCategory.events(),
    SubCategory.travels(),
  ];

  static List<SubCategory> shoppingSubCategories = [
    SubCategory.shopping(),
    SubCategory.clothes(),
    SubCategory.home(),
    SubCategory.electronics(),
    SubCategory.healthAndBeauty(),
    SubCategory.accessories(),
    SubCategory.gifts(),
  ];

  static List<SubCategory> financialSubCategories = [
    SubCategory.financial(),
    SubCategory.loans(),
    SubCategory.creditCards(),
    SubCategory.assurances(),
    SubCategory.taxes(),
  ];

  static List<SubCategory> educationSubCategories = [
    SubCategory.education(),
    SubCategory.books(),
    SubCategory.courses(),
    SubCategory.educationalEvents(),
    SubCategory.university(),
    SubCategory.educationLoan(),
  ];

  static List<SubCategory> contributionSubCategories = [
    SubCategory.contribution(),
    SubCategory.donations(),
    SubCategory.curchTithe(),
    SubCategory.offering(),
    SubCategory.tips(),
  ];

  static List<SubCategory> dependentsSubCategories = [
    SubCategory.dependents(),
    SubCategory.familyDepenent(),
    SubCategory.allowance(),
    SubCategory.school(),
    SubCategory.pets(),
  ];

  static List<SubCategory> investmentsSubCategories = [
    SubCategory.investments(),
    SubCategory.realEstate(),
    SubCategory.stocks(),
    SubCategory.shares(),
    SubCategory.financialInvestments(),
    SubCategory.nfts(),
    SubCategory.crypto(),
  ];

  static List<SubCategory> incomeSubCategories = [
    SubCategory.salary(),
    SubCategory.honorarium(),
    SubCategory.rental(),
    SubCategory.business(),
    SubCategory.dividends(),
    SubCategory.pension(),
    SubCategory.occasional(),
    SubCategory.gift(),
  ];
}
