import 'package:get/get.dart';

import '../core/helper/common_widget/get_location_map/bindings/get_location_map_binding.dart';
import '../core/helper/common_widget/get_location_map/views/get_location_map_view.dart';
import '../modules/add_card/bindings/add_card_binding.dart';
import '../modules/add_card/views/add_card_view.dart';
import '../modules/auth/login/bindings/login_binding.dart';
import '../modules/auth/login/views/login_view.dart';
import '../modules/auth/otp/bindings/otp_binding.dart';
import '../modules/auth/otp/views/otp_view.dart';
import '../modules/auth/subscription/bindings/subscription_binding.dart';
import '../modules/auth/subscription/views/subscription_view.dart';
import '../modules/auth/training_type/bindings/training_type_binding.dart';
import '../modules/auth/training_type/views/training_type_view.dart';
import '../modules/auth/welcome/bindings/welcome_binding.dart';
import '../modules/auth/welcome/views/welcome_view.dart';
import '../modules/global_search/bindings/global_search_binding.dart';
import '../modules/global_search/views/global_search_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/settings/contact_us/bindings/contact_us_binding.dart';
import '../modules/settings/contact_us/views/contact_us_view.dart';
import '../modules/settings/privacy_policy/bindings/privacy_policy_binding.dart';
import '../modules/settings/privacy_policy/views/privacy_policy_view.dart';
import '../modules/tdee/bindings/tdee_binding.dart';
import '../modules/tdee/views/tdee_view.dart';
import '../modules/trainee/add_stats/bindings/add_stats_binding.dart';
import '../modules/trainee/add_stats/views/add_stats_view.dart';
import '../modules/trainee/all_exercise/bindings/all_exercise_binding.dart';
import '../modules/trainee/all_exercise/views/all_exercise_view.dart';
import '../modules/trainee/create_exercise_workout/bindings/create_workout_binding.dart';
import '../modules/trainee/create_exercise_workout/views/create_workout_view.dart';
import '../modules/trainee/create_nutrition_workout/bindings/create_nutrition_workout_binding.dart';
import '../modules/trainee/create_nutrition_workout/views/create_nutrition_workout_view.dart';
import '../modules/trainee/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/trainee/edit_profile/views/edit_profile_view.dart';
import '../modules/trainee/exercise_details/bindings/exercise_details_binding.dart';
import '../modules/trainee/exercise_details/views/exercise_details_view.dart';
import '../modules/trainee/exercise_library/bindings/exercise_library_binding.dart';
import '../modules/trainee/exercise_library/views/exercise_library_view.dart';
import '../modules/trainee/my_booking_trainee/bindings/my_booking_trainee_binding.dart';
import '../modules/trainee/my_booking_trainee/views/my_booking_trainee_view.dart';
import '../modules/trainee/my_diary/bindings/my_diary_binding.dart';
import '../modules/trainee/my_diary/views/my_diary_view.dart';
import '../modules/trainee/my_sessions/bindings/my_sessions_binding.dart';
import '../modules/trainee/my_sessions/views/my_sessions_view.dart';
import '../modules/trainee/nutrition_details_view/bindings/meals_details_view_binding.dart';
import '../modules/trainee/nutrition_details_view/views/nutrition_details_view.dart';
import '../modules/trainee/nutrition_library/bindings/nutrition_library_binding.dart';
import '../modules/trainee/nutrition_library/views/nutrition_library_view.dart';
import '../modules/trainee/profile/bindings/profile_binding.dart';
import '../modules/trainee/profile/views/profile_view.dart';
import '../modules/trainee/resources/bindings/resources_binding.dart';
import '../modules/trainee/resources/views/resources_view.dart';
import '../modules/trainee/review/review_list/bindings/review_list_binding.dart';
import '../modules/trainee/review/review_list/views/review_list_view.dart';
import '../modules/trainee/review/write_a_review/bindings/write_a_review_binding.dart';
import '../modules/trainee/review/write_a_review/views/write_a_review_view.dart';
import '../modules/trainee/start_tracking_calories/bindings/start_tracking_calories_binding.dart';
import '../modules/trainee/start_tracking_calories/views/start_tracking_calories_view.dart';
import '../modules/trainee/start_workout/bindings/start_workout_binding.dart';
import '../modules/trainee/start_workout/views/start_workout_view.dart';
import '../modules/trainee/trainee_dashboard/filter_view/bindings/filter_view_binding.dart';
import '../modules/trainee/trainee_dashboard/filter_view/views/filter_view_view.dart';
import '../modules/trainee/trainee_dashboard/trainee_dashboard/bindings/trainee_dashboard_binding.dart';
import '../modules/trainee/trainee_dashboard/trainee_dashboard/views/trainee_dashboard_view.dart';
import '../modules/trainee/workout_calendar/bindings/workout_calendar_binding.dart';
import '../modules/trainee/workout_calendar/views/workout_calendar_view.dart';
import '../modules/trainee/workout_details/bindings/workout_details_binding.dart';
import '../modules/trainee/workout_details/views/workout_details_view.dart';
import '../modules/trainee/workout_plane/bindings/workout_plane_binding.dart';
import '../modules/trainee/workout_plane/views/workout_plane_view.dart';
import '../modules/trainer/calendar/bindings/calendar_binding.dart';
import '../modules/trainer/calendar/views/calendar_view.dart';
import '../modules/trainer/create_profile/create_trainer_profile/bindings/create_trainer_profile_binding.dart';
import '../modules/trainer/create_profile/create_trainer_profile/views/create_trainer_profile_view.dart';
import '../modules/trainer/create_profile/media/bindings/media_binding.dart';
import '../modules/trainer/create_profile/media/views/media_view.dart';
import '../modules/trainer/exercise_diary/bindings/exercise_diary_binding.dart';
import '../modules/trainer/exercise_diary/views/exercise_diary_view.dart';
import '../modules/trainer/my_booking/bindings/my_booking_binding.dart';
import '../modules/trainer/my_booking/views/my_booking_view.dart';
import '../modules/trainer/schedule/bindings/schedule_binding.dart';
import '../modules/trainer/schedule/views/schedule_view.dart';
import '../modules/trainer/trainee_profile/bindings/trainee_profile_binding.dart';
import '../modules/trainer/trainee_profile/views/trainee_profile_view.dart';
import '../modules/trainer/trainer_dashboard/trainer_dashboard/bindings/trainer_dashboard_binding.dart';
import '../modules/trainer/trainer_dashboard/trainer_dashboard/views/trainer_dashboard_view.dart';
import '../modules/trainer/trainer_profile/bindings/trainer_profile_binding.dart';
import '../modules/trainer/trainer_profile/views/trainer_profile_view.dart';
import '../modules/trainer/trainer_resource/bindings/resource_binding.dart';
import '../modules/trainer/trainer_resource/views/trainer_resource_view.dart';
import '../modules/trainer/user_stats/bindings/user_stats_binding.dart';
import '../modules/trainer/user_stats/views/user_stats_view.dart';
import '../modules/video_player/bindings/video_player_binding.dart';
import '../modules/video_player/views/video_player_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.WELCOME;

  static final routes = [
    GetPage(
      name: _Paths.WELCOME,
      page: () => WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.TRAINEE_DASHBOARD,
      page: () => TraineeDashboardView(),
      binding: TraineeDashboardBinding(),
    ),
    GetPage(
      name: _Paths.TRAINER_DASHBOARD,
      page: () => TrainerDashboardView(),
      binding: TrainerDashboardBinding(),
    ),
    GetPage(
      name: _Paths.FILTER_VIEW,
      page: () => FilterViewView(),
      binding: FilterViewBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => const PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_US,
      page: () => ContactUsView(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.MY_SESSIONS,
      page: () => MySessionsView(),
      binding: MySessionsBinding(),
    ),
    GetPage(
      name: _Paths.MY_BOOKING,
      page: () => MyBookingView(),
      binding: MyBookingBinding(),
    ),
    GetPage(
      name: _Paths.TRAINER_PROFILE,
      page: () => TrainerProfileView(),
      binding: TrainerProfileBinding(),
    ),
    GetPage(
      name: _Paths.MY_BOOKING_TRAINEE,
      page: () => const MyBookingTraineeView(),
      binding: MyBookingTraineeBinding(),
    ),
    GetPage(
      name: _Paths.MY_DIARY,
      page: () => MyDiaryView(),
      binding: MyDiaryBinding(),
    ),
    GetPage(
      name: _Paths.GLOBAL_SEARCH,
      page: () => GlobalSearchView(),
      binding: GlobalSearchBinding(),
    ),
    GetPage(
      name: _Paths.CALENDAR,
      page: () => CalendarView(),
      binding: CalendarBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_TRAINER_PROFILE,
      page: () => CreateTrainerProfileView(),
      binding: CreateTrainerProfileBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTION,
      page: () => SubscriptionView(),
      binding: SubscriptionBinding(),
    ),
    GetPage(
      name: _Paths.MEDIA,
      page: () => MediaView(),
      binding: MediaBinding(),
    ),
    GetPage(
      name: _Paths.TRAINING_TYPE,
      page: () => TrainingTypeView(),
      binding: TrainingTypeBinding(),
    ),
    GetPage(
      name: _Paths.GET_LOCATION_MAP,
      page: () => GetLocationMapView(),
      binding: GetLocationMapBinding(),
    ),
    GetPage(
      name: _Paths.SCHEDULE,
      page: () => ScheduleView(),
      binding: ScheduleBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_PLAYER,
      page: () => const VideoPlayerView(),
      binding: VideoPlayerBinding(),
    ),
    GetPage(
      name: _Paths.REVIEW_LIST,
      page: () => const ReviewListView(),
      binding: ReviewListBinding(),
    ),
    GetPage(
      name: _Paths.WRITE_A_REVIEW,
      page: () => const WriteAReviewView(),
      binding: WriteAReviewBinding(),
    ),
    GetPage(
      name: _Paths.WORKOUT_PLANE,
      page: () => WorkoutPlaneView(),
      binding: WorkoutPlaneBinding(),
    ),
    GetPage(
      name: _Paths.WORKOUT_CALENDAR,
      page: () => WorkoutCalendarView(),
      binding: WorkoutCalendarBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_WORKOUT,
      page: () => CreateWorkoutView(),
      binding: CreateWorkoutBinding(),
    ),
    GetPage(
      name: _Paths.EXERCISE_LIBRARY,
      page: () => ExerciseLibraryView(),
      binding: ExerciseLibraryBinding(),
    ),
    GetPage(
      name: _Paths.EXERCISE_DETAILS,
      page: () => ExerciseDetailsView(),
      binding: ExerciseDetailsBinding(),
    ),
    GetPage(
      name: _Paths.TDEE,
      page: () => TdeeView(),
      binding: TdeeBinding(),
    ),
    GetPage(
      name: _Paths.ALL_EXERCISE,
      page: () => AllExerciseView(),
      binding: AllExerciseBinding(),
    ),
    GetPage(
      name: _Paths.START_WORKOUT,
      page: () => StartWorkoutView(),
      binding: StartWorkoutBinding(),
    ),
    GetPage(
      name: _Paths.EXERCISE_DIARY,
      page: () => ExerciseDiaryView(),
      binding: ExerciseDiaryBinding(),
    ),
    GetPage(
      name: _Paths.TRAINEE_PROFILE,
      page: () => TraineeProfileView(),
      binding: TraineeProfileBinding(),
    ),
    GetPage(
      name: _Paths.WORKOUT_DETAILS,
      page: () => WorkoutDetailsView(),
      binding: WorkoutDetailsBinding(),
    ),
    GetPage(
      name: _Paths.START_TRACKING_CALORIES,
      page: () => StartTrackingCaloriesView(),
      binding: StartTrackingCaloriesBinding(),
    ),
    GetPage(
      name: _Paths.MEALS_DETAILS_VIEW,
      page: () => NutritionDetailsViewView(),
      binding: MealsDetailsViewBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_NUTRITION_WORKOUT,
      page: () => CreateNutritionWorkoutView(),
      binding: CreateNutritionWorkoutBinding(),
    ),
    GetPage(
      name: _Paths.NUTRITION_LIBRARY,
      page: () => NutritionLibraryView(),
      binding: NutritionLibraryBinding(),
    ),
    GetPage(
      name: _Paths.RESOURCES,
      page: () => ResourcesView(),
      binding: ResourcesBinding(),
    ),
    GetPage(
      name: _Paths.ADD_STATS,
      page: () => AddStatsView(),
      binding: AddStatsBinding(),
    ),
    GetPage(
      name: _Paths.USER_STATS,
      page: () => UserStatsView(),
      binding: UserStatsBinding(),
    ),
    GetPage(
      name: _Paths.TRAINER_RESOURCES,
      page: () => TrainerResourceView(),
      binding: TrainerResourceBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CARD,
      page: () => AddCardView(),
      binding: AddCardBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => HistoryView(),
      binding: HistoryBinding(),
    ),
  ];
}
