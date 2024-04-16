

class UserSubscriptionResponse{

  final String subscription_plan;
  
  UserSubscriptionResponse({
    required this.subscription_plan, 
  });

  factory UserSubscriptionResponse.fromJson(Map<String, dynamic> json) {
    return UserSubscriptionResponse( 
      subscription_plan: json['subscription_plan'] ?? "subscription_plan",
    );
  }
}