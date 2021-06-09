//
//  ShareOnInstagram.swift
//  FonzMusicSwift
//
//  Created by didi on 5/31/21.
//

import Foundation
import UIKit
import SwiftUI

func ShareImageOnInstagram(imageUrl:String, songTitle:String, artistName:String) {
    
    let urlScheme = URL(string: "instagram-stories://share")
    
    
    // checks to see if user has ig
    if UIApplication.shared.canOpenURL(urlScheme!) {
        //inits daat
        var albumArt = Data()
        // creates image loader class to get the image from the url
        let tempImage = ImageLoader(url: URL(string: imageUrl)!, cache: Environment(\.imageCache).wrappedValue)
        // loads the image from the url (should be stored in cache)
        tempImage.load()
        // converts the image to data
        let combinedImage = textToImage(drawText: songTitle, drawText: artistName, inImage: tempImage.image!)
//        albumArt = (tempImage.image?.pngData())!
        albumArt = combinedImage.pngData()!

        // sets gradiant by doing two different background colors
        // sets the album art as the sticker image
        let items = [["com.instagram.sharedSticker.backgroundTopColor": "#FF9425", "com.instagram.sharedSticker.backgroundBottomColor": "#B188B9", "com.instagram.sharedSticker.stickerImage": albumArt]]
        // basic ig option
        let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60*5)]
        // sets items
        UIPasteboard.general.setItems(items, options: pasteboardOptions)
        // launches IG
        UIApplication.shared.open(urlScheme!, options: [:], completionHandler: nil)
    }
    else {
        print("does not have ig")
    }
    
    
    
}
func textToImage(drawText songTitle: String, drawText artistName: String, inImage image: UIImage) -> UIImage {
    let textColor = UIColor.systemGray4
//    let textFont = UIFont(name: "MuseoSans-300", size: 30)!
    let titleFont = UIFont(name: "MuseoSans-300", size: 68)!
    let artistFont = UIFont(name: "MuseoSans-100", size: 48)!

    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

    let songTextFontAttributes = [
        NSAttributedString.Key.font: titleFont,
        NSAttributedString.Key.foregroundColor: textColor,
        ] as [NSAttributedString.Key : Any]
    
    let artistTextFontAttributes = [
        NSAttributedString.Key.font: artistFont,
        NSAttributedString.Key.foregroundColor: textColor,
        ] as [NSAttributedString.Key : Any]
    
    image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

    let songPoint = CGPoint(x: 20, y: 0)
    
    let songRect = CGRect(origin: songPoint, size: image.size)
    songTitle.draw(in: songRect, withAttributes: songTextFontAttributes)
    
//    let imageYValue : int = image.size.y
    
    let artistPoint = CGPoint(x: 20, y: 500)
    
    let artistRect = CGRect(origin: artistPoint, size: image.size)
    artistName.draw(in: artistRect, withAttributes: artistTextFontAttributes)

    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage!
}
