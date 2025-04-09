import Foundation

@available(*, deprecated, renamed: "Examples.Spotify")
public typealias Spotify = Examples.Spotify

public extension Examples.Spotify {
    
    @available(*, deprecated, renamed: "Examples.Spotify.Album")
    typealias PreviewInfo = Examples.Spotify.Album
    
    @available(*, deprecated, renamed: "Examples.Spotify.AlbumScreen")
    typealias PreviewScreen = Examples.Spotify.AlbumScreen
    
    @available(*, deprecated, renamed: "Examples.Spotify.AlbumScreen.Content")
    typealias PreviewScreenContent = Examples.Spotify.AlbumScreen.Content
    
    @available(*, deprecated, renamed: "Examples.Spotify.AlbumScreen.Header")
    typealias PreviewScreenHeader = Examples.Spotify.AlbumScreen.Header
}

public extension Examples.Spotify.AlbumScreen {
    
    @available(*, deprecated, renamed: "init(album:)")
    init(info: Examples.Spotify.PreviewInfo) {
        self.init(album: info)
    }
}

public extension Examples.Spotify.AlbumScreen.Content {
    
    @available(*, deprecated, renamed: "init(album:)")
    init(info: Examples.Spotify.PreviewInfo) {
        self.init(album: info)
    }
}

public extension Examples.Spotify.AlbumScreen.Header {
    
    @available(*, deprecated, renamed: "init(album:)")
    init(info: Examples.Spotify.PreviewInfo) {
        self.init(album: info)
    }
}
