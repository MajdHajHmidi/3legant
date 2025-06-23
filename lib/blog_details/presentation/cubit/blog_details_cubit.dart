import '../../data/blog_details_repo.dart';
import '../../models/blog_details_data_model.dart';
import '../../../core/util/app_failure.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_details_state.dart';

class BlogDetailsCubit extends Cubit<BlogDetailsState> {
  final BlogDetailsRepo _blogDetailsRepo;
  final String blogId;
  BlogDetailsCubit({
    required BlogDetailsRepo blogDetailsRepo,
    required this.blogId,
  }) : _blogDetailsRepo = blogDetailsRepo,
       super(BlogDetailsInitial()) {
    getBlogDetailsModel(blogId);
  }

  AsyncValue<BlogDetailsDataModel, AppFailure> blogDetailsModel =
      AsyncValue.initial();
  Future<void> getBlogDetailsModel(String blogId) async {
    blogDetailsModel = AsyncValue.loading();
    emit(BlogDetailsDataChangedState());

    final result = await _blogDetailsRepo.getBlogDetails(blogId: blogId);

    if (result.isData) {
      blogDetailsModel = AsyncValue.data(data: result.data!);
      emit(BlogDetailsDataChangedState());
    } else {
      blogDetailsModel = AsyncValue.error(error: result.error!);
      emit(BlogDetailsDataChangedState());
    }
  }
}
