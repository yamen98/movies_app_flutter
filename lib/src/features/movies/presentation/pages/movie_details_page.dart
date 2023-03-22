import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/src/core/common_feature/presentation/pages/background_page.dart';
import 'package:movies_app/src/core/common_feature/presentation/widgets/app_loader.dart';
import 'package:movies_app/src/core/common_feature/presentation/widgets/reload_widget.dart';
import 'package:movies_app/src/core/styles/app_colors.dart';
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
    return BackgroundPage(
      child: BlocConsumer<MoviesBloc, MoviesState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is LoadingGetMovieDetailsByIdState) {
            return AppLoader();
          }
          if (state is ErrorGetMovieDetailsByIdState) {
            return ReloadWidget.error(
              content: state.errorMsg,
              onPressed: () {},
            );
          }
          else if(state is SuccessGetMovieDetailsByIdState){
            return  Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: ScreenUtil().screenWidth,
                  color: AppColors.primaryColor,
                ),

                CachedNetworkImage(
                  imageUrl: state.movieDetailsModel!.poster,
                  height: ScreenUtil().screenHeight * 0.5,
                  width: ScreenUtil().screenWidth,
                  fit: BoxFit.cover,
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
                        stops: const [0.3, 0.5],
                      ),
                    ),
                  ),
                ),

                // Movie data
                Positioned(
                  top: ScreenUtil().screenHeight * 0.5,
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
                    child: Column(
                      children: [Text("aaa")],
                    ),
                  ),
                ),
              ],
            );
          }
          else{
            return SizedBox();
          }
        },
        listener: (context, state) {},
      ),
    );
  }
}
