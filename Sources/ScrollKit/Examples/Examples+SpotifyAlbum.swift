//
//  Examples+SpotifyAlbum.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-03-10.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Examples.Spotify {
    
    /// This struct represents a Spotify album.
    struct Album {

        public init(
            bandName: String,
            releaseTitle: String,
            releaseType: String,
            releaseDate: Date,
            releaseCoverUrl: String,
            tintColor: Color,
            tracks: [String]
        ) {
            self.bandName = bandName
            self.releaseTitle = releaseTitle
            self.releaseType = releaseType
            self.releaseDate = releaseDate
            self.releaseCoverUrl = releaseCoverUrl
            self.tintColor = tintColor
            self.tracks = tracks
        }

        public let bandName: String
        public let releaseTitle: String
        public let releaseType: String
        public let releaseDate: Date
        public let releaseCoverUrl: String
        public let tintColor: Color
        public let tracks: [String]
    }
}

public extension Examples.Spotify.Album {

    static var anthrax: Self {
        .init(
            bandName: "Anthrax",
            releaseTitle: "We've Come for You All",
            releaseType: "Album",
            releaseDate: Calendar.current.date(from: DateComponents(year: 2003)) ?? .now,
            releaseCoverUrl: "https://upload.wikimedia.org/wikipedia/en/8/8f/AnthraxWCFYA.jpg",
            tintColor: .init(red: 0.5, green: 0.4, blue: 0.5),
            tracks: [
                "Contact",
                "What Doesn't Die",
                "Superhero",
                "Refuse to Be Denied",
                "Safe Home",
                "Any Place But Here",
                "Nobody Knows Anything",
                "Strap It On",
                "Black Dahlia",
                "Cadillac Rock Box",
                "Taking the Music Back",
                "Crash",
                "Think About an End",
                "We've Come for You All",
                "Safe Home - Acoustic Version",
                "We're Happy Family"
            ]
        )
    }

    static var misfortune: Self {
        .init(
            bandName: "Misfortune",
            releaseTitle: "Forsaken",
            releaseType: "Album",
            releaseDate: Calendar.current.date(from: DateComponents(year: 1999)) ?? .now,
            releaseCoverUrl: "https://danielsaidi.com/assets/bands/misfortune/forsaken.jpg",
            tintColor: .init(red: 0.5, green: 0.3, blue: 0),
            tracks: [
                "Forsaken",
                "A Scenery of Dispair",
                "Rape of Bewildered Dreams",
                "In Mating",
                "Burn!",
                "Through Chaos Fulfilled",
                "A Realm of the Unblessed",
                "Apostates of Hate"
            ]
        )
    }

    static var regina: Self {
        .init(
            bandName: "Regina Spector",
            releaseTitle: "Far",
            releaseType: "Album",
            releaseDate: Calendar.current.date(from: DateComponents(year: 2009)) ?? .now,
            releaseCoverUrl: "https://i.scdn.co/image/ab67616d0000b2738c8d5428b693308705e7caca",
            tintColor: .init(red: 0.5, green: 0.7, blue: 1),
            tracks: [
                "The Calculation",
                "Eet",
                "Blue Lips",
                "Folding Chair",
                "Machine",
                "Laughing With",
                "Human of the Year",
                "Two Birds",
                "Dance Anthem of the 80's",
                "Genius Next Door",
                "Wallet",
                "One More Time With Feeling",
                "Man of a Thousand Faces"
            ]
        )
    }
}
