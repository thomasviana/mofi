import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class DeleteSubCategory {
  final SubCategoryRepository _subCategoryRepository;

  const DeleteSubCategory(this._subCategoryRepository);

  Future<void> call(SubCategory subCategory) {
    return _subCategoryRepository.delete(subCategory);
  }
}
