import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/src/core/common_feature/domain/entities/movie_filter_model.dart';
import 'package:movies_app/src/core/common_feature/presentation/widgets/app_loader.dart';
import 'package:movies_app/src/core/common_feature/presentation/widgets/app_snack_bar.dart';
import 'package:movies_app/src/core/common_feature/presentation/widgets/button_widget.dart';
import 'package:movies_app/src/core/common_feature/presentation/widgets/custom_clipper_path.dart';
import 'package:movies_app/src/core/common_feature/presentation/widgets/drawer_widget.dart';
import 'package:movies_app/src/core/common_feature/presentation/widgets/reload_widget.dart';
import 'package:movies_app/src/core/common_feature/presentation/widgets/text_field_widget.dart';
import 'package:movies_app/src/core/styles/app_colors.dart';
import 'package:movies_app/src/core/translations/l10n.dart';
import 'package:movies_app/src/core/util/constant/app_constants.dart';
import 'package:movies_app/src/core/util/helper.dart';
import 'package:movies_app/src/features/movies/domain/entities/movies_model.dart';
import 'package:movies_app/src/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:movies_app/src/features/movies/presentation/widget/movie_card_shimmer_widget.dart';
import 'package:movies_app/src/features/movies/presentation/widget/movie_card_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  // Text Editors
  TextEditingController _searchTextField = TextEditingController();

  // Movie Bloc Instance
  MoviesBloc _bloc = MoviesBloc();

  // Smart Refresh Controller
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<MoviesModel> movies = [];
  int page = 1;
  String totalResult = "0";

  String? selectedMovieType;

  List<String> movieTypes = ["movie", "series", "episode"];

  // Initial filter with null value to movie type and year
  MovieFilterModel filter = MovieFilterModel();
  TextEditingController _yearTextField = TextEditingController();

  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      key: _key,
      appBar: AppBar(
        toolbarHeight: 100.sp,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        flexibleSpace: ClipPath(
          clipper: CustomClipperPath(),
          child: Container(
            height: 150.sp,
            width: ScreenUtil().screenWidth,
            color: Helper.isDarkTheme()
                ? AppColors.orange.withOpacity(0.5)
                : AppColors.primaryColor,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Menu
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        _key.currentState!.openDrawer();
                      },
                      child: Icon(
                        Icons.menu,
                        color: AppColors.white,
                        size: 30,
                      ),
                    ),

                    Text(
                      S.of(context).explorer,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),

                    // Filters
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        late Function(void Function()) showUpperSheetState;

                        Helper.showUpperSheetModal(
                          context,
                          [
                            StatefulBuilder(builder: (context, setState) {
                              showUpperSheetState = setState;
                              return _buildFilterWidgets(showUpperSheetState);
                            }),
                          ],
                          reset: () {
                            showUpperSheetState(() {
                              selectedMovieType = null;
                              _yearTextField.clear();
                              filter = MovieFilterModel();
                            });
                          },
                          confirm: () {
                            filter.movieType = selectedMovieType;
                            filter.year = _yearTextField.text.trim().isEmpty
                                ? null
                                : _yearTextField.text.trim();
                            if (_searchTextField.text.trim().length >= 3) {
                              _bloc.add(
                                OnGettingMoviesEvent(
                                  _searchTextField.text.trim(),
                                  page,
                                  filter,
                                ),
                              );
                            } else {
                              Helper.showSnackBar(context,
                                  S.of(context).type_in_search_to_filter,
                                  type: ToastTypeEnum.info);
                            }
                          },
                        );
                      },
                      child: Icon(
                        Icons.filter_alt,
                        color: AppColors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: DrawerWidget(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Text Field
            BlocConsumer<MoviesBloc, MoviesState>(
              bloc: _bloc,
              listener: (context, state) {
                if (state is MoviesInitial) {
                  _searchTextField.clear();
                  page = 1;
                  setState(() {
                    movies.clear();
                  });
                }
              },
              builder: (context, state) {
                return TextFieldWidget(
                  controller: _searchTextField,
                  hintText: S.of(context).type_to_search,
                  prefixIcon: Icon(
                    Icons.search,
                    size: Theme.of(context).iconTheme.size,
                    color: AppColors.lightGray,
                  ),
                  suffixIcon: _searchTextField.text.isEmpty
                      ? null
                      : GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            _bloc.add(OnClearingSearchTextFieldEvent());
                          },
                          child: Icon(
                            Icons.close,
                            size: Theme.of(context).iconTheme.size,
                            color: AppColors.lightGray,
                          ),
                        ),
                  onChanged: (value) {
                    if (value != null) {
                      if (value.length >= 3) {
                        _bloc.add(
                          OnGettingMoviesEvent(
                            value.trim(),
                            page,
                            filter,
                          ),
                        );
                      } else {
                        if (value.trim().isEmpty) {
                          _bloc.add(OnClearingSearchTextFieldEvent());
                        }
                      }
                    }
                    setState(() {});
                  },
                );
              },
            ),

            // Space
            SizedBox(
              height: 10.h,
            ),

            // Featured movies title
            if (!movies.isEmpty)
              Text(
                S.of(context).all_movies,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

            SizedBox(
              height: 10.h,
            ),

            // List Of Movies
            Expanded(
              child: BlocConsumer(
                bloc: _bloc,
                listener: (context, state) {
                  if (state is SuccessGetMoviesState) {
                    totalResult = state.moviesResult.totalResults;
                    // Refresh page and get data from initial page (=1)
                    if (!state.isLoadingMore) {
                      movies = state.moviesResult.search;
                      _refreshController.refreshCompleted(
                        resetFooterState: true,
                      );
                    } else {
                      // Loading more data
                      movies.addAll(state.moviesResult.search);
                      if (state.moviesResult.search.isEmpty) {
                        _refreshController.loadNoData();
                      } else {
                        _refreshController.loadComplete();
                      }
                    }
                  } else if (state is ErrorGetMoviesState) {
                    _refreshController.refreshCompleted(
                      resetFooterState: true,
                    );
                    _refreshController.loadComplete();
                  }
                },
                builder: (context, state) {
                  if(state is MoviesInitial){
                    return ReloadWidget.empty(
                      content: S.of(context).start_search,
                    );
                  }
                  if (state is LoadingGetMoviesState) {
                    return ListView.separated(
                      itemCount: perPage,
                      itemBuilder: (context, index) {
                        return MovieCardShimmerWidget();
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 15.h,
                        );
                      },
                    );
                  }
                  if (state is ErrorGetMoviesState) {
                    return ReloadWidget.error(
                      content: state.errorMsg,
                      onPressed: () {
                        _bloc.add(
                          OnGettingMoviesEvent(
                            _searchTextField.text.trim(),
                            page,
                            filter,
                          ),
                        );
                      },
                    );
                  }

                  // If there is no movie data
                  if (movies.isEmpty) {
                    return ReloadWidget.empty(
                      content: S.of(context).no_data,
                    );
                  }

                  return SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: WaterDropHeader(
                      waterDropColor: Theme.of(context).cardColor,
                    ),
                    footer: CustomFooter(
                      builder: (BuildContext context, LoadStatus? mode) {
                        Widget body;
                        if (mode == LoadStatus.idle) {
                          body = Text(
                            S.of(context).pull_up_load,
                          );
                        } else if (mode == LoadStatus.loading) {
                          body = AppLoader(
                            iconColor: Theme.of(context).iconTheme.color,
                          );
                        } else if (mode == LoadStatus.failed) {
                          body = Text(
                            S.of(context).load_failed,
                          );
                        } else if (mode == LoadStatus.canLoading) {
                          body = Text(
                            S.of(context).release_to_load,
                          );
                        } else {
                          body = Text(
                            S.of(context).no_more_data,
                          );
                        }
                        return Container(
                          height: 55.0,
                          child: Center(child: body),
                        );
                      },
                    ),
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: () {
                      _onLoading.call(int.parse(totalResult));
                    },
                    child: ListView.separated(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return MovieCardWidget(
                          model: movies[index],
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              "/movie_details_page",
                              arguments: movies[index].imdbID,
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 15.h,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Refresh method called when pull down list
  void _onRefresh() async {
    page = 1;
    _refreshController.requestRefresh();
    _bloc.add(
      OnGettingMoviesEvent(
        _searchTextField.text.trim(),
        page,
        filter,
      ),
    );
  }

  /// Loading method called when pull up list
  void _onLoading(int totalResults) async {
    if (movies.length < totalResults) {
      page++;
      _refreshController.requestLoading();

      _bloc.add(
        OnGettingMoviesEvent(
          _searchTextField.text.trim(),
          page,
          filter,
          isLoadingMore: true,
        ),
      );
    } else {
      _refreshController.loadNoData();
    }
  }

  Widget _buildFilterWidgets(showUpperSheetState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Movie type title
        Text(
          S.of(context).movie_type,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),

        SizedBox(
          height: 10.h,
        ),

        // List of options
        SizedBox(
            width: double.infinity,
            child: Wrap(
              children: [
                for (int i = 0; i < movieTypes.length; i++) ...{
                  Container(
                    margin: EdgeInsets.all(6.w),
                    child: ButtonWidget(
                      text: Helper.getMovieTypeTitle(movieTypes[i]),
                      onPressed: () {
                        showUpperSheetState(() {
                          selectedMovieType = movieTypes[i];
                        });
                      },
                      textStyle:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: selectedMovieType == movieTypes[i]
                                    ? AppColors.white
                                    : null,
                              ),
                      borderColor: selectedMovieType == movieTypes[i]
                          ? Theme.of(context).cardColor
                          : Theme.of(context).iconTheme.color!,
                      backgroundColor: selectedMovieType == movieTypes[i]
                          ? Theme.of(context).cardColor
                          : AppColors.transparent,
                    ),
                  ),
                }
              ],
            )),

        SizedBox(
          height: 10.h,
        ),

        // Year text field
        TextFieldWidget(
          controller: _yearTextField,
          hintText: S.of(context).enter_year,
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          keyboardType: TextInputType.number,
        ),

        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
