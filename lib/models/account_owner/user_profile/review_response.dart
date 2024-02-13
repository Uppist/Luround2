

class ReviewResponse{

  ReviewResponse({
    required this.userName,
    required this.userPhoto,
    required this.reviewText,
    required this.rating,
    required this.createdAt,
  });

  late final String userName;
  late final String userPhoto;
  late final String reviewText;
  late final num rating;
  late final int createdAt;
  
  ReviewResponse.fromJson(Map<String, dynamic> json,){
    userName = json['userName'] ?? "Anonymous";
    userPhoto = json['userPhoto'] ?? "non";
    reviewText = json['reviewText'] ?? "non";
    rating = json['rating'] ?? 0.0;
    createdAt = json['created_at'] ?? 0;
  }

}