import 'package:get/get_rx/src/rx_types/rx_types.dart';

class EndPoints {
  static var accessToken = '';
  static var defaultPlaceHolderImage = '';
  static var defaultProfilePlaceHolderImage =
      'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg';
  static const BASE_URL = 'http://14.99.147.156:8888/ftf-backend/public/api/';
  static const LOG_IN = 'auth/login';
  static const VERIFY_OTP = 'auth/verify-otp';
  static const ROLE_LIST = 'general/role-list';
  static const ADD_ROLE = 'add-role';
  static const GET_TRAINEE_PROFILE = 'trainee/get-profile';
  static const UPDATE_TRAINEE_PROFILE = 'trainee/profile-update';
  static const UPDATE_MOBILE_NUMBER = 'phone-number-update';
  // static const UPLOAD_FILE = 'uploadFile';
  static const UPLOAD_FILE = 'commonUploadFile';
  static const COMMON_DELETE_FILE = 'common-delete-file';
  static const GET_TRAINER_MEDIA_ACHIVEMENT = 'get-trainer-media-achievement';
  static const LOG_OUT = 'auth/logout';
  static const GET_MY_TRAINER_PROFILE = 'trainer/get-profile';
  static const USER_TYPE_TRAINER = "Trainer";
  static const USER_TYPE_TRAINEE = "Trainee";
  static const WRITE_REVIEW = "trainee/review-create";
  static const GET_NEAR_BY_TRAINER = "dashboard";
  static const GET_TRAINING_TYPE = "training-type";
  static const GET_TRAINING_MODE = "training-mode";
  static const GET_TRAINER_VIEW_DETAIL = "trainee/trainer-view-profile";
  static const GET_TRAINER_VIEW_DETAIL_AS_GUEST = "guest-user/trainer-view-profile";

  static const BOOK_APPOINMENT = "trainee/create-booking-appoinment";
  static const ACHIEVEMENT_UPDATE = "trainer/achievement-update";
  static const MEDIA_UPDATE = "trainer/media-update";
  // static const QUALIFICATION_CER_UPDATE = "trainer/qualifications-update";
  // static const DELETE_QUALIFICATION_CERTI = "trainer/qualifications-delete";
  static const DELETE_ACHIEVEMENTS = "trainer/achievement-delete";
  static const UPDATE_TRAINER_PROFILE = "trainer/profile-update";
  static const DELETE_MEDIAS = "trainer/media-delete";
  static const GET_NOTIFICATION = "get-notification";
  static const GET_SCHDULE_DATA = "get-schedule-training";
  static const CREATE_SCHEDULE = "trainer/schedule-training";
  static const GET_SCHEDULE_DD = "trainer/get-training-details";
  static const GET_MY_SESSION = "trainee/get-my-sessions";
  static const GET_MY_BOOKING = "trainer/get-my-booking";

  static const ACC_REJ_SCHEDULE_REQ = "trainee/scheduled-training-action";
  static const GET_TRAINEE_LIST = "trainer/get-trainee-list";
  static const GET_SCHEDULE_DETAILS = "get-schedule-training";
  // static const GET_TRAINEE_BOOKINGS = "trainee/get-my-training";
  static const GET_TRAINER_DASHBOARD_DETAIL = "trainer/dashboard";
  static const CANCEL_APPOITMENT = "cancel-booking-appointment";
  static const CANCEL_SCHEDULE_APPOITMENT = "cancel-scheduled-training";
  static const GET_DIARY_DATA = "get-diary-data";
  static const GET_RESOURCE_LIBRARY = "resouce-library";
  static const GET_STATIC_DROP_DOWN = "static-dropdown";
  static const GUEST_USER_TRAINER_PROFILE = "guest-user/trainer-view-profile";
  static const CMS_DATA = "cms-data";
  static const CONTACT_US = 'contact-us';
  static const SEARCH = 'search';
  static const GUEST_SEARCH = 'guest-user/search';

  static const GETSUBSCRIPATION = 'get-subscriptions';
  static const GETTRAINEESUBSCRIPATION = 'trainee/get-subscriptions';

  // static const MAKEPAYMENT = 'trainer/make-payment';
  static const GET_TRAINING_DETAILS = 'trainer/get-training-details';
  static const CREATE_SCHEDULE_TRAINING = 'trainer/schedule-training';
  static const REBOOK_APPOINTMENT = 'trainer/rebook-appointment';
  static const GET_COMMON_REVIEW = 'get-common-review';
  static const GET_BADGES = 'get-badges';
  static const GET_RESOURCE_EXSERCISE = 'get-resource-exercise';
  static const GET_RESOURCE_EXSERCISE_DETAILS = 'get-resource-exercise-detail';
  static const GET_RESOURCE_EXSERCISE_VIEWALL = 'get-resource-library-view-all';
  static const CREATE_EXSERCISE_WORKOUT = 'create-exercise-workout';
  static const GET_EXERCISE_WORKOUT = 'get-exercise-workout';
  static const GET_WORKOUT_DETAILS = 'get-exercise-workout-detail';
  static const REMOVE_EXERCISE_WORKOUT = 'remove-exercise-workout';
  static const UPDATE_EXERCISE_WORKOUT = 'update-exercise-workout';
  static const GET_NUTRITIONAL_WORKOUT = 'get-nutritional-workout';
  static const GET_CUSTOM_MEAL = 'get-custom-meal-list';
  static const GET_PREMADE_MEAL = 'get-pre-made-meal-list';
  static const CREATE_NUTRAIONAL_WORKOUT = 'create-nutritional-workout';
  static const GET_PREMADE_MEAL_DETAILS = 'get-pre-made-meal-detail';
  static const GET_MYWORK_WORKOUT = 'trainee/get-start-exercise-workout-list';
  static const GET_RESOURCE_COUNT = 'get-resource-count';
  static const START_EXCERCISE_WORKOUT = 'trainee/start-exercise-workout';
  static const GET_CUSTOM_MEAL_VIEW_ALL = 'get-custom-meal-view-all';
  static const GET_PREMADE_MEAL_VIEW_ALL = 'get-pre-made-meal-list-view-all';
  static const UPDATE_NUTRAIONAL_WORKOUT = 'update-nutritional-workout';
  static const GET_NUTRITIONAK_CUSTOM_WORK_OUT_DETAILS = 'get-nutritional-custom-workout-detail';
  static const REMOVE_NUTRITIONAL_WORKOUT = 'remove-nutritional-workout';
  static const START_NUTRITIONAL_WORKOUT = 'trainee/get-start-nutritional-workout-list';
  static const GET_MEAL_CALCULATION = 'trainee/get-meal-calculation';
  static const SAVE_NUTRINATION_WORKOUT = 'trainee/save-nutritional-workout';
  static const GET_NUTRITIONAK_PREMADE_WORK_OUT_DETAILS = 'get-nutritional-premade-workout-detail';
  static const GET_WORK_OUT_LIST = 'trainee/get-workouts-list';
  static const ADD_EXERCISE_FROM_RESOURCES = 'trainee/add-exercise-from-resource';
  static const ADD_MEAL_FROM_RESOURCES = 'trainee/add-meals-from-resource';
  static const GET_STATS = 'trainee/get-stats';
  static const UPDATE_STATS = 'trainee/update-stats';

  static const SEND_TDEE_DATA = 'trainee/tdee/save';
  static const GET_TDEE_DATA = 'trainee/tdee/get';
  static const GET_STATS_DATA = "get-exercise-stats";
  static const GET_NUTRITIONAL_STATS_DATA = "get-nutritional-stats";
  static const Device_Info = 'device-info';
  static const BECOME_TRAINER = 'user-role-change';
  static const CREATE_NEW_CARD = 'create-new-card';
  static const GET_CARD_LIST = 'get-card-list';
  static const REMOVE_USER_CARD = 'user-card-remove';
  static const MAKE_PAYMENT = 'make-payment';
  static const SUBSCRIPATION_HISTROY = 'subscription-history';
}

class SessionKeys {
  static var keyLogin = "isLoggedIn";
  static var keyAccessToken = "keyAccessToken";
  static String keyUserId = "keyUserId";
  static String keyUserName = "keyUserName";
  static String keyMobileNo = "keyMobileNo";
  static String keyEmail = "keyEmail";
  static String keyUserProfilePic = "keyUserProfilePic";

  static String keyLoginProfile = "keyLoginProfile";
  static String keyUserType = "keyUserType";
  static String keyUserExercise = "keyUserExercise";
}

// ignore: camel_case_types
abstract class FTFGlobal {
  static var REQUEST_MAX_TIMEOUT = 120;
  static var defaultNetworkUser =
      'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg';
  static var defaultNetworkDog =
      'https://image.shutterstock.com/image-vector/white-dog-circle-black-vector-260nw-1468021094.jpg';

  static const enterEmail = 'Enter your email';

  static RxString firstName = ''.obs;
  static RxString lastName = ''.obs;
  static RxString userName = ''.obs;
  static RxString mobileNo = ''.obs;
  static RxString email = ''.obs;
  static RxString userProfilePic = ''.obs;
}
