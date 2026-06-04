import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moviehub/const.dart';
import 'package:moviehub/models/movie.dart';
import 'package:moviehub/widget/buidinfo.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({
    required this.movie,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,

      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),

        slivers: [
          _buildAppBar(),
          _buildBody(),
        ],
      ),
    );
  }

  /// ---------------- APP BAR ----------------

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 360,
      pinned: true,

      backgroundColor: primaryColor,
      elevation: 0,

      leading: _backButton(),

      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,

          children: [
            _backdropImage(),
            _gradientOverlay(),
            _titleSection(),
          ],
        ),
      ),
    );
  }

  /// BACK BUTTON

  Widget _backButton() {
    return Container(
      margin: const EdgeInsets.all(8),

      decoration: BoxDecoration(
        color: secondaryColor.withValues(alpha: 0.08),
        shape: BoxShape.circle,
      ),

      child: BackButton(
        color: secondaryColor,
      ),
    );
  }

  /// BACKDROP IMAGE

  Widget _backdropImage() {
    return Image.network(
      movie.fullBackDropUrl,
      fit: BoxFit.cover,

      errorBuilder: (_,_,_) {
        return Container(
          color: primaryColor,

          child: const Center(
            child: Icon(
              Icons.broken_image_outlined,
              color: Colors.black26,
              size: 40,
            ),
          ),
        );
      },
    );
  }

  /// GRADIENT OVERLAY

  Widget _gradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,

          colors: [
            primaryColor.withValues(alpha: 0.1),
            primaryColor.withValues(alpha: 0.4),
            primaryColor,
          ],
        ),
      ),
    );
  }

  /// TITLE SECTION

  Widget _titleSection() {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 26,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            movie.title,

            maxLines: 2,
            overflow: TextOverflow.ellipsis,

            style: headingStyle.copyWith(
              fontSize: 28,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              RatingBarIndicator(
                rating: movie.voteAverage / 2,

                itemBuilder: (_, _) {
                  return const Icon(
                    Icons.star_rounded,
                    color: Colors.black,
                  );
                },

                itemCount: 5,
                itemSize: 20,
              ),

              const SizedBox(width: 10),

              Text(
                "${movie.voteAverage.toStringAsFixed(1)}/10",

                style: bodyStyle.copyWith(
                  color: secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Spacer(),

              _dateChip(),
            ],
          ),
        ],
      ),
    );
  }

  /// DATE CHIP

  Widget _dateChip() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color: secondaryColor.withValues(alpha: 0.08),

        borderRadius: BorderRadius.circular(30),

        border: Border.all(
          color: secondaryColor.withValues(alpha: 0.15),
        ),
      ),

      child: Text(
        movie.releseDate,

        style: bodyStyle.copyWith(
          color: secondaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// ---------------- BODY ----------------

  SliverToBoxAdapter _buildBody() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            _posterAndOverview(),

            const SizedBox(height: 28),

            _infoCard(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// POSTER + OVERVIEW

  Widget _posterAndOverview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Hero(
          tag: movie.id,

          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),

              boxShadow: [
                BoxShadow(
                  color: secondaryColor.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),

              child: Image.network(
                movie.fullPosterUrl,

                width: 120,
                height: 180,
                fit: BoxFit.cover,

                errorBuilder: (_, _, _) {
                  return Container(
                    width: 120,
                    height: 180,
                    color: primaryColor,

                    child: const Icon(
                      Icons.broken_image_outlined,
                      color: Colors.black26,
                    ),
                  );
                },
              ),
            ),
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "Overview",

                style: headingStyle.copyWith(
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                movie.overView,

                style: overViewEssayTextStyle.copyWith(
                  color:
                      secondaryColor.withValues(alpha: 0.7),
                  height: 1.6,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// INFO CARD

  Widget _infoCard() {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: primaryColor,

        borderRadius: BorderRadius.circular(22),

        border: Border.all(
          color: secondaryColor.withValues(alpha: 0.12),
        ),

        boxShadow: [
          BoxShadow(
            color: secondaryColor.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Column(
        children: [
          Buildinfo(
            label: "Original Title",
            value: movie.title,
          ),

          Divider(
            color: secondaryColor.withValues(alpha: 0.08),
          ),

          Buildinfo(
            label: "Release Date",
            value: movie.releseDate,
          ),

          Divider(
            color: secondaryColor.withValues(alpha: 0.08),
          ),

          Buildinfo(
            label: "Vote Average",
            value: movie.voteAverage.toStringAsFixed(1),
          ),
        ],
      ),
    );
  }
}