//
//  ProfileResult.swift
//  ImageFeed
//
//  Created by kalmahik on 25.02.2024.
//

import Foundation

struct ProfileResponse: Decodable {
    let id: String
    let username: String
    let firstName: String
    let lastName: String
    let bio: String?
}

//        "id": "f0GP_hF2IzM",
//        "updated_at": "2024-02-25T11:09:46Z",
//        "username": "kalmahik",
//        "name": "Murad Azimov",
//        "first_name": "Murad",
//        "last_name": "Azimov",
//        "twitter_username": null,
//        "portfolio_url": null,
//        "bio": null,
//        "location": null,
//        "links": {
//            "self": "https://api.unsplash.com/users/kalmahik",
//            "html": "https://unsplash.com/@kalmahik",
//            "photos": "https://api.unsplash.com/users/kalmahik/photos",
//            "likes": "https://api.unsplash.com/users/kalmahik/likes",
//            "portfolio": "https://api.unsplash.com/users/kalmahik/portfolio",
//            "following": "https://api.unsplash.com/users/kalmahik/following",
//            "followers": "https://api.unsplash.com/users/kalmahik/followers"
//        },
//        "profile_image": {
//            "small": "https://images.unsplash.com/placeholder-avatars/extra-large.jpg?ixlib=rb-4.0.3&crop=faces&fit=crop&w=32&h=32",
//            "medium": "https://images.unsplash.com/placeholder-avatars/extra-large.jpg?ixlib=rb-4.0.3&crop=faces&fit=crop&w=64&h=64",
//            "large": "https://images.unsplash.com/placeholder-avatars/extra-large.jpg?ixlib=rb-4.0.3&crop=faces&fit=crop&w=128&h=128"
//        },
//        "instagram_username": null,
//        "total_collections": 0,
//        "total_likes": 0,
//        "total_photos": 0,
//        "total_promoted_photos": 0,
//        "accepted_tos": false,
//        "for_hire": false,
//        "social": {
//            "instagram_username": null,
//            "portfolio_url": null,
//            "twitter_username": null,
//            "paypal_email": null
//        },
//        "followed_by_user": false,
//        "photos": [],
//        "badge": null,
//        "tags": {
//            "custom": [],
//            "aggregated": []
//        },
//        "followers_count": 0,
//        "following_count": 0,
//        "allow_messages": true,
//        "numeric_id": 15572960,
//        "downloads": 0,
//        "meta": {
//            "index": false
//        },
//        "uid": "f0GP_hF2IzM",
//        "confirmed": true,
//        "uploads_remaining": 10,
//        "unlimited_uploads": false,
//        "email": "kalmahik@yahoo.com",
//        "dmca_verification": "unverified",
//        "unread_in_app_notifications": false,
//        "unread_highlight_notifications": false
