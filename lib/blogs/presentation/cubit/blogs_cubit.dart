import 'package:e_commerce/blogs/data/blogs_repo.dart';
import 'package:e_commerce/blogs/models/blogs_data_model.dart';
import 'package:e_commerce/core/util/app_failure.dart';
import 'package:flutter_async_value/async_value.dart';
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
  int _paginationIndex = 1;
  String categoryId = '';

  void changeCategoryId(String categoryId) {
    if (this.categoryId == categoryId) return;
    this.categoryId = categoryId;
    emit(BlogsCategoryChangedState());

    _paginationIndex = 1;
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
      page: 1,
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

    if (result.isData && blogsDataModel.data != null
    // Why? Prevents NullPointerException if user changed category (thus
    // requested new products), before the pagination data was recieved
    ) {
      blogsDataModel = AsyncValue.data(data: result.data!);
      emit(BlogsDataChangedState());
    } else {
      // The error may be null in case the result has data but blogsDataModel.data is null
      emit(
        BlogsChangedCategoryErrorState(
          failure:
              result.error ?? NetworkFailure(code: RpcFailureCodes.other.name),
        ),
      );
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

    if (result.isData && blogsDataModel.data != null
    // Why? Prevents NullPointerException if user changed category (thus
    // requested new products), before the pagination data was recieved
    ) {
      final newModel = _mergeBlogPages(blogsDataModel.data!, result.data!);
      blogsDataModel = AsyncValue.data(data: newModel);
      ++_paginationIndex;
      emit(BlogsDataChangedState());
    } else {
      // The error may be null in case the result has data but blogsDataModel.data is null
      emit(
        BlogsPaginationErrorState(
          failure:
              result.error ?? NetworkFailure(code: RpcFailureCodes.other.name),
        ),
      );
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
