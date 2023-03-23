import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/src/core/common_feature/domain/entities/language_enum.dart';
import 'package:movies_app/src/core/common_feature/presentation/pages/background_page.dart';
import 'package:movies_app/src/core/common_feature/presentation/widgets/app_loader.dart';
import 'package:movies_app/src/core/common_feature/presentation/widgets/arrow_back_button_widget.dart';
import 'package:movies_app/src/core/common_feature/presentation/widgets/cached_image_widget.dart';
import 'package:movies_app/src/core/common_feature/presentation/widgets/reload_widget.dart';
import 'package:movies_app/src/core/styles/app_colors.dart';
import 'package:movies_app/src/core/translations/l10n.dart';
import 'package:movies_app/src/core/util/constant/app_constants.dart';
import 'package:movies_app/src/core/util/helper.dart';
import 'package:movies_app/src/features/movies/domain/entities/movie_details_model.dart';
import 'package:movies_app/src/features/movies/presentation/bloc/movies_bloc.dart';

class MovieDetailsPage extends StatefulWidget {
  final String movieId;

  const MovieDetailsPage({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  MoviesBloc _bloc = MoviesBloc();

  @override
  void initState() {
    _bloc.add(OnGettingMovieDetailsByIdEvent(widget.movieId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
        ),
        child: BackgroundPage(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: BlocConsumer<MoviesBloc, MoviesState>(
            bloc: _bloc,
            listener: (context, state) {},
            builder: (context, state) {
              if (state is LoadingGetMovieDetailsByIdState) {
                return _buildLoadingWidget();
              }
              if (state is ErrorGetMovieDetailsByIdState) {
                return _buildErrorWidget(state.errorMsg);
              } else if (state is SuccessGetMovieDetailsByIdState) {
                return _buildMovieDetailsWidget(state.movieDetailsModel!);
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  // Loading widget
  Widget _buildLoadingWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(
            height: kToolbarHeight,
          ),

          // Arrow Back
          Align(
            alignment: Alignment.centerLeft,
            child: ArrowBackButtonWidget(
              iconColor: AppColors.white,
            ),
          ),

          Expanded(
              child: AppLoader(
            iconColor: AppColors.white,
          )),
        ],
      ),
    );
  }

  // Error widget
  Widget _buildErrorWidget(String errorMsg) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(
            height: kToolbarHeight,
          ),

          // Arrow Back
          Align(
            alignment: Alignment.centerLeft,
            child: ArrowBackButtonWidget(
              iconColor: AppColors.white,
            ),
          ),

          Expanded(
            child: ReloadWidget.error(
              content: errorMsg,
              onPressed: () {
                _bloc.add(OnGettingMovieDetailsByIdEvent(
                  widget.movieId,
                ));
              },
              iconColor: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Movie details widget
  Widget _buildMovieDetailsWidget(MovieDetailsModel movieDetailsModel) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              children: [
                // Movie image header
                Stack(
                  children: [
                    CachedImageWidget(
                      imageUrl: movieDetailsModel.poster ?? defaultStr,
                      height: ScreenUtil().screenHeight / 2,
                      width: ScreenUtil().screenWidth,
                    ),

                    // Shadow
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              AppColors.primaryColor.withOpacity(0.7),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.7, 0.9],
                          ),
                        ),
                      ),
                    ),

                    // Rating
                    if (movieDetailsModel.imdbRating != notANumber) ...{
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 15),
                          child: _buildHeaderRatingAndAwardWidget(movieDetailsModel),
                        ),
                      ),
                    },

                    // Arrow Back
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: kToolbarHeight,
                          ),

                          // Arrow Back
                          Align(
                            alignment: Helper.getLang() == LanguageEnum.en
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Directionality(
                              textDirection: Helper.getLang() == LanguageEnum.en
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                              child: CircleAvatar(
                                backgroundColor: Helper.isDarkTheme()?
                                AppColors.primaryColor:AppColors.orange,
                                child: ArrowBackButtonWidget(
                                  iconColor: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Movie Data
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Title and date
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title
                                _buildMovieTitle(movieDetailsModel.title),

                                SizedBox(
                                  height: 5.h,
                                ),

                                // Year and genre
                                _buildDateAndGenre(movieDetailsModel),
                              ],
                            ),
                          ),

                          SizedBox(
                            width: 10.w,
                          ),

                          Expanded(
                            child: _buildDirectorAndWriter(movieDetailsModel),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 20.h,
                      ),

                      // Country and Language
                      _buildCountryAndLanguageMove(movieDetailsModel),

                      SizedBox(
                        height: 20.h,
                      ),

                      // Plot
                      if (movieDetailsModel.plot != notANumber) ...{
                        _buildPlot(movieDetailsModel.plot),
                      },

                      SizedBox(
                        height: 20.h,
                      ),

                      // Actors
                      if (movieDetailsModel.actors != null &&
                          movieDetailsModel.actors != notANumber) ...{
                        _buildActors(movieDetailsModel)
                      },

                      SizedBox(
                        height: 20.h,
                      ),

                      // Ratings
                      if (movieDetailsModel.ratings.isNotEmpty) ...{
                        _buildRatingsList(movieDetailsModel),
                      }
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // Movie title
  Widget _buildMovieTitle(String? title) {
    return Text(
      title ?? defaultStr,
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
      textAlign: TextAlign.start,
    );
  }

  // Date and type of movie
  Widget _buildDateAndGenre(MovieDetailsModel movieDetailsModel) {
    List<String> genre = [];
    if (movieDetailsModel.genre != notANumber) {
      genre = (movieDetailsModel.genre ?? "").split(",");
    }
    String title = movieDetailsModel.year ?? defaultStr;
    if (genre.isNotEmpty) {
      genre.forEach((element) {
        title += " | " + element;
      });
    }

    return Text(
      title,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w400,
          ),
      textAlign: TextAlign.start,
    );
  }

  // Movie plot
  Widget _buildPlot(String? plot) {
    return Text(
      plot ?? defaultStr,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.normal,
          ),
      textAlign: TextAlign.start,
    );
  }

  // Rating widget
  Widget _buildHeaderRatingAndAwardWidget(MovieDetailsModel movieDetailsModel) {
    double rating = double.tryParse(movieDetailsModel.imdbRating ?? "0") ?? 0;
    double percentage = rating / 10.0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Ratings
        RatingBarIndicator(
          rating: 5 * percentage,
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: 30.0,
          unratedColor: Colors.amber.withAlpha(50),
          direction: Axis.horizontal,
        ),

        // Awards
        if (movieDetailsModel.awards != notANumber) ...{
          SizedBox(
            width: 5.w,
          ),
          Expanded(
            child: Text(
              movieDetailsModel.awards.toString(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        },
      ],
    );
  }

  // Ratings list
  _buildRatingsList(MovieDetailsModel movieDetailsModel) {
    /**
     * Parsing three type of rating
     * 7.3 / 10
     * 43 / 100
     * 39%
     * I Converted all shape of rating to formal percentage and
     * displayed it in rating widget stars
     */

    List<double> ratingPercentages = [];

    for (int i = 0; i < movieDetailsModel.ratings.length; i++) {
      String value = movieDetailsModel.ratings[i].value;
      List<String> valueFromDelimiter = value.split("/");
      double percentage = 0.0;
      if (valueFromDelimiter.isNotEmpty &&
          valueFromDelimiter.length > 1 &&
          !valueFromDelimiter.contains("%")) {
        // 7.3/10 or 43/100
        // 7.3 is the first side
        // 10 is the second side
        double firstSide = double.tryParse(valueFromDelimiter[0]) ?? 0;
        double secondSide = double.tryParse(valueFromDelimiter[1]) ?? 1;
        percentage = firstSide / secondSide;
        ratingPercentages.add(percentage);
      } else {
        percentage =
            double.tryParse(valueFromDelimiter[0].replaceAll("%", "")) ?? 0;
        percentage /= 100;
        ratingPercentages.add(percentage);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 5.h,
        ),

        Text(
          S.of(context).ratings,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textDirection: Helper.getLang() == LanguageEnum.ar?
          TextDirection.rtl:TextDirection.ltr,
        ),

        SizedBox(
          height: 5.h,
        ),

        // All ratings
        Column(
          children: [
            for (int i = 0; i < movieDetailsModel.ratings.length; i++) ...{
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        movieDetailsModel.ratings[i].source,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.normal,
                                ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: RatingBarIndicator(
                        rating: 5 * ratingPercentages[i],
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 20.0,
                        unratedColor: Colors.amber.withAlpha(50),
                        direction: Axis.horizontal,
                      ),
                    ),
                  ),
                ],
              )
            }
          ],
        )
      ],
    );
  }

  // Movie actors
  _buildActors(MovieDetailsModel movieDetailsModel) {
    List<String> actors = movieDetailsModel.actors?.split(",") ?? [];
    // Check if there is an actor data
    if (actors.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            S.of(context).actors,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textDirection: Helper.getLang() == LanguageEnum.ar?
            TextDirection.rtl:
            TextDirection.ltr,
          ),
          SizedBox(
            height: 5.h,
          ),
          Directionality(
            textDirection: TextDirection.ltr,

            child: Wrap(
              spacing: 5.sp,
              runSpacing: 5.sp,
              children: [
                for (int i = 0; i < actors.length; i++) ...{
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.orange.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      actors[i],
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.normal,
                        color: AppColors.white,
                          ),
                    ),
                  ),
                }
              ],
            ),
          ),
        ],
      );
    } else {
      return SizedBox();
    }
  }

  // Movie country
  Widget _buildCountryAndLanguageMove(MovieDetailsModel movieDetailsModel) {
    return Row(
      children: [
        // Country
        Expanded(
          child: Column(
            children: [
              Text(
                S.of(context).country,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                movieDetailsModel.country ?? defaultStr,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ],
          ),
        ),

        // Language
        Expanded(
          child: Column(
            children: [
              Text(
                S.of(context).language,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                movieDetailsModel.language ?? defaultStr,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Director ands Creator
  Widget _buildDirectorAndWriter(MovieDetailsModel movieDetailsModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (movieDetailsModel.director != null &&
            movieDetailsModel.director != notANumber) ...{
          Text(
            movieDetailsModel.director ?? defaultStr,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.normal,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 5.h,
          ),
        },
        if (movieDetailsModel.writer != null &&
            movieDetailsModel.writer != notANumber) ...{
          Text(
            movieDetailsModel.writer ?? defaultStr,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.normal,
                ),
            textAlign: TextAlign.center,

          ),
        },
      ],
    );
  }
}
