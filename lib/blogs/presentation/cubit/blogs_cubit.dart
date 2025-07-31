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
    getBlogs();
  }

  PaginatedAsyncValue<BlogsDataModel, AppFailure> blogsDataModel =
      PaginatedAsyncValue.initial();
  String categoryId = '';

  void changeCategoryId(String categoryId) {
    if (this.categoryId == categoryId) return;
    this.categoryId = categoryId;
    emit(BlogsCategoryChangedState());

    getBlogs(
      changedCategory: true,
      page: AppConstants.appStartingPaginationIndex,
    );
  }

  Future<void> getBlogs({
    int page = AppConstants.appStartingPaginationIndex,
    bool changedCategory = false,
  }) async {
    if (blogsDataModel.isLoading) {
      return;
    }

    if (changedCategory) {
      _getNewCategoryData();
      return;
    }

    if (page == AppConstants.appStartingPaginationIndex) {
      // Reset model
      blogsDataModel = PaginatedAsyncValue.initial();
    }

    blogsDataModel = PaginatedAsyncValue.loading(previous: blogsDataModel);
    emit(BlogsDataChangedState());

    final result = await _blogsRepo.getBlogs(
      page: page,
      blogCategoryId: categoryId,
    );

    if (result.isData) {
      blogsDataModel = PaginatedAsyncValue.data(
        data: result.data!,
        previous: blogsDataModel,
        combine: _mergeBlogPages,
      );
      emit(BlogsDataChangedState());
    } else {
      blogsDataModel = PaginatedAsyncValue.error(
        error: result.error!,
        previous: blogsDataModel,
      );
      emit(BlogsDataChangedState());
    }
  }

  bool newCategoryLoading = false;
  Future<void> _getNewCategoryData() async {
    if (newCategoryLoading) {
      return;
    }

    newCategoryLoading = true;
    emit(BlogsChangedCategoryLoadingState());

    final result = await _blogsRepo.getBlogs(
      page: AppConstants.appStartingPaginationIndex,
      blogCategoryId: categoryId,
    );

    newCategoryLoading = false;

    if (result.isData) {
      // Reset Model so previous pages are cleared
      blogsDataModel = PaginatedAsyncValue.initial();
      blogsDataModel = PaginatedAsyncValue.data(
        data: result.data!,
        previous: blogsDataModel,
        combine: _mergeBlogPages,
      );
      emit(BlogsDataChangedState());
    } else {
      emit(BlogsChangedCategoryErrorState(failure: result.error!));
    }
  }

  BlogsDataModel _mergeBlogPages(BlogsDataModel first, BlogsDataModel second) {
    return BlogsDataModel(
      blogsMetadata: second.blogsMetadata,
      blogs: [...first.blogs, ...second.blogs],
      blogCategories: second.blogCategories,
      paginationInfo: second.paginationInfo,
    );
  }
}
