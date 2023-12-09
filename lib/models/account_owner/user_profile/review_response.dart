

class ReviewResponse{

  ReviewResponse({
    required this.userName,
    required this.userPhoto,
    required this.reviewText,
    required this.rating,
  });

  late final String userName;
  late final String userPhoto;
  late final String reviewText;
  late final double rating;
  
  ReviewResponse.fromJson(Map<String, dynamic> json,){
    userName = json['userName'];
    userPhoto = json['userPhoto'];
    reviewText = json['reviewText'];
    rating = json['rating'];
  }

}