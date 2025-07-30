class Profile {
    String id;
    String name;
    String email;
    String phone;
    String country;
    String city;
    String? bio;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic profileImage;
    String username;

    Profile({
        required this.id,
        required this.name,
        required this.email,
        required this.phone,
        required this.country,
        required this.city,
        required this.bio,
        required this.createdAt,
        required this.updatedAt,
        required this.profileImage,
        required this.username,
    });

}

