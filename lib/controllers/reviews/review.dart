import 'dart:async';
import 'dart:convert';

import 'package:devcamper/config.dart';
import 'package:devcamper/controllers/login/login_shared_service.dart';
import 'package:devcamper/models/review/read_reviews_response_model.dart';
import 'package:devcamper/models/review/review_request_model.dart';
import 'package:devcamper/models/review/review_response_model.dart';
import 'package:devcamper/models/review/reviews_response_model.dart';
import 'package:devcamper/models/review/user_reviews_response_model.dart';
import 'package:http/http.dart' as http;

class ReviewService {
  static var client = http.Client();

  static Future<ReviewResponseModel> postBootcampReview(
      ReviewRequestModel model, bootcampId) async {
    var loginDetails = await LoginSharedService.loginDetails();
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials": true.toString(),
      "Authorization": "Bearer ${loginDetails[0]}"
    };

    var url = Uri.parse(
        '${"${Config.apiURL}${Config.bootcampsAPI}/" + bootcampId}/reviews');

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model));

    return reviewResponseJson(response.body);
  }

  static Future<UserReviewsResponseModel> getUserReviews() async {
    var loginDetails = await LoginSharedService.loginDetails();
    
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials": true.toString(),
      "Authorization": "Bearer ${loginDetails[0]}"
    };

    var url = Uri.parse(Config.apiURL + Config.userReviewsAPI);

    var response = await client.get(url, headers: requestHeaders);

    return userReviewsResponseJson(response.body);
  }

  static Future<ReadReviewsResponseModel> getBootcampReviews(bootcampId) async {
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials": true.toString(),
    };

    var url = Uri.parse(
        '${"${Config.apiURL}${Config.bootcampsAPI}/" + bootcampId}/reviews');

    var response = await client.get(url, headers: requestHeaders);

    return readReviewsResponseJson(response.body);
  }

  static Future<ReviewResponseModel> updateReviews(
      ReviewRequestModel model, reviewId) async {
    var loginDetails = await LoginSharedService.loginDetails();
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials": true.toString(),
      "Authorization": "Bearer ${loginDetails[0]}"
    };

    var url = Uri.parse("${Config.apiURL}${Config.reviewsAPI}/" + reviewId);

    var response =
        await client.put(url, headers: requestHeaders, body: jsonEncode(model));

    return reviewResponseJson(response.body);
  }

  static Future<bool> removeReview(reviewId) async {
    var loginDetails = await LoginSharedService.loginDetails();
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials": true.toString(),
      "Authorization": "Bearer ${loginDetails[0]}"
    };

    var url = Uri.parse("${Config.apiURL}${Config.reviewsAPI}/" + reviewId);

    var response = await client.delete(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
