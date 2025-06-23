import '../../data/blogs_repo.dart';
import '../../models/blogs_data_model.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/util/app_failure.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blogs_state.dart';

class BlogsCubit extends Cubit<BlogsState> {
  final BlogsRepo _blogsRepo;
  BlogsCubit({required BlogsRepo blogsRepo})
    : _blogsRepo = blogsRepo,
      super(BlogsInitial()) {
    getData();
  }

  AsyncValue<BlogsDataModel, AppFailure> blogsDataModel = AsyncValue.initial();
  int _paginationIndex = AppConstants.appStartingPaginationIndex;
  String categoryId = '';

  void changeCategoryId(String categoryId) {
    if (this.categoryId == categoryId) return;
    this.categoryId = categoryId;
    emit(BlogsCategoryChangedState());

    _paginationIndex = AppConstants.appStartingPaginationIndex;
    getData(changedCategory: true);
  }

  Future<void> getData({
    bool isPagination = false,
    bool changedCategory = false,
  }) async {
    if (changedCategory) {
      _getNewCategoryData();
      return;
    }
    if (isPagination) {
      _getPaginatedData();
      return;
    }

    _getNewData();
  }

  Future<void> _getNewData() async {
    blogsDataModel = AsyncValue.loading();
    emit(BlogsDataChangedState());

    final result = await _blogsRepo.getBlogs(
      page: AppConstants.appStartingPaginationIndex,
      blogCategoryId: categoryId,
    );

    if (result.isData) {
      blogsDataModel = AsyncValue.data(data: result.data!);
      ++_paginationIndex;
      emit(BlogsDataChangedState());
    } else {
      blogsDataModel = AsyncValue.error(error: result.error!);
      emit(BlogsDataChangedState());
    }
  }

  bool _paginationLoading = false;
  Future<void> _getPaginatedData() async {
    if (_paginationLoading) {
      return;
    }

    _paginationLoading = true;
    emit(BlogsPaginationLoadingState());

    final result = await _blogsRepo.getBlogs(
      page: _paginationIndex,
      blogCategoryId: categoryId,
    );

    _paginationLoading = false;

    // Cancel operation if new filters applied before new page recieved
    if (blogsDataModel.data == null) {
      return;
    }

    if (result.isData) {
      final newModel = _mergeBlogPages(blogsDataModel.data!, result.data!);
      blogsDataModel = AsyncValue.data(data: newModel);
      ++_paginationIndex;
      emit(BlogsDataChangedState());
    } else {
      emit(BlogsPaginationErrorState(failure: result.error!));
    }
  }

  bool _newCategoryLoading = false;
  Future<void> _getNewCategoryData() async {
    if (_newCategoryLoading) {
      return;
    }

    _newCategoryLoading = true;
    emit(BlogsChangedCategoryLoadingState());

    final result = await _blogsRepo.getBlogs(
      page: _paginationIndex,
      blogCategoryId: categoryId,
    );

    _newCategoryLoading = false;

    if (result.isData) {
      blogsDataModel = AsyncValue.data(data: result.data!);
      ++_paginationIndex;
      emit(BlogsDataChangedState());
    } else {
      emit(BlogsChangedCategoryErrorState(failure: result.error!));
    }
  }

  BlogsDataModel _mergeBlogPages(BlogsDataModel first, BlogsDataModel second) {
    // Check if category IDs match
    if (first.blogs.first.categoryId != second.blogs.first.categoryId) {
      // Categories don't match, skip merge
      return first;
    }

    // Check if pages are consecutive
    if (first.paginationInfo.currentPage !=
        second.paginationInfo.currentPage - 1) {
      // Pages are not consecutive, skip merge
      return first;
    }

    // Proceed with merge
    return BlogsDataModel(
      blogsMetadata: second.blogsMetadata,
      blogs: [...first.blogs, ...second.blogs],
      blogCategories: second.blogCategories,
      paginationInfo: second.paginationInfo,
    );
  }
}
