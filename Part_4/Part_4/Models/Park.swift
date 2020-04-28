//
//  Park.swift
//  NPF-3
//
//  Created by Student on 1/24/20.
//  Copyright © 2020 cmp5987. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Park : NSObject, MKAnnotation{
    
    var name  = ""     // location name
    var state = ""   // state
    private var parkName : String = ""
    private var parkLocation : String = ""
    private var dateFormed : String = ""
    private var area : String = ""
    private var link : String = ""
    private var location : CLLocation?
    private var imageLink : String = ""
    private var parkDescription : String = ""
    private var imageName : String = ""
    private var imageSize : String = ""
    private var imageType : String = ""
    private var latitude : String = ""
    private var longitude : String = ""
    private var distanceH : Float = 0.0

    
    //needed for the MKAnnotation protocol // computed property
    @objc var coordinate: CLLocationCoordinate2D {
        get {
            return location!.coordinate
        }
    }
    
    //optional - required with set callout true
    @objc var title : String? {
        get {
            return name
        }
    }
    
    @objc var subtitle : String? {
        get {
            return state
        }
    }

    convenience override init () {
        self.init(parkName: "Unknown", parkLocation: "Unknown", dateFormed: "Unknown", area: "Unknown", link: "Unknown", location: nil, imageLink: "Unknown", parkDescription: "Unknown", imageName: "Unknown", imageSize: "Unknown", imageType: "Unknown", distanceH : 0.0)
    }
    
    init(parkName: String, parkLocation: String, dateFormed: String, area: String, link: String, location: CLLocation!, imageLink: String, parkDescription: String, imageName: String, imageSize: String, imageType: String, distanceH : Float) {
        super.init()
        self.name = parkName
        self.state = parkLocation
        self.location = location
        set(name: parkName)
        set(location: parkLocation)
        set(date: dateFormed)
        set(parkArea: area)
        set(parkLink: link)
        set(loc: location)
        set(imgLink: imageLink)
        set(descr: parkDescription)
        set(imageN: imageName)
        set(imageS: imageSize)
        set(imageT: imageType)
        set(dist: distanceH)
    }

    
    override var description: String {
        """
        {
            parkName: \(parkName)
            parkLocation: \(parkLocation)
            dateFormed: \(dateFormed)
            area: \(area)
            link: \(link)
            location: \(String(describing: location))
            imageLink: \(imageLink)
            parkDescription: \(parkDescription)
            imageName: \(imageName)
            imageSize: \(imageSize)
            imageType: \(imageType)
            dist: \(distanceH)
        }
        """
    }
    
    func getLocation() -> CLLocation {
        return location!
    }
    func set(loc: CLLocation!) {
        location = loc
    }
    func getImageLink() -> String {
        return imageLink
    }
    func set(imgLink: String) {
        imageLink = imgLink
    }
    func getParkDescription() -> String {
        return parkDescription
    }
    func set(descr: String) {
        parkDescription = descr
    }
    
    func getParkName() -> String {
        return parkName
    }
    func set(name: String){
        if(checkLengthOfString(checkStringIn: name)){
           parkName = name
        }
        else{
            parkName = "TBD"
            print("Bad value of ab in \(parkName): setting to TBD")
        }
    }
    
    func getParkLocation() -> String {
        return parkLocation
    }
    func set(location: String){
        if(checkLengthOfString(checkStringIn: location)){
           parkLocation = location
        }
        else{
            parkLocation = "TBD"
            print("Bad value of na in set \(parkLocation) :setting to TBD")
        }
    }
    
    func getDateFormed() -> String {
        return dateFormed
    }
    func set(date: String) {
        dateFormed = date
    }
    
    func getArea() -> String {
        return area
    }
    func set(parkArea: String) {
        area = parkArea
    }
    
    func getDistance() -> Float {
        return distanceH
    }
    
    func set(dist : Float){
        distanceH = dist
    }
    
    func getLink() -> String {
        return link
    }
    func set(parkLink: String) {
        link = parkLink
    }
    
    func set(imageT: String) {
        imageType = imageT
    }
    
    func set(imageS: String) {
        imageSize = imageS
    }
    
    func set(imageN: String) {
        imageName = imageN
    }
    
    func getImageSize() -> String {
        return imageSize
    }
    func getImageType() -> String {
        return imageType
    }
    func getImageName() -> String {
        return imageName
    }
    
    func checkLengthOfString(checkStringIn: String) -> Bool{
        var chaFound = 0
        for cha in checkStringIn{
            
            if(cha != " "){
                chaFound += 1
            }
            if(chaFound > 3){
                return true
            }
        }
        return false
    }
    
}
