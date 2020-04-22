//
//  SceneDelegate.swift
//  Part_3
//
//  Created by catie on 4/15/20.
//  Copyright © 2020 cmp5987. All rights reserved.
//

import UIKit
import CoreLocation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var parks : [Park] = []

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        loadData()
        
        let p = Parks()
        p.parkList = parks
        let mapVC = window?.rootViewController as! MapViewController
        mapVC.allParks = p
        
        
    }
    func loadData(){
         if let path = Bundle.main.path(forResource: "data", ofType: "plist") {
             let tempDict = NSDictionary(contentsOfFile: path)
             let tempArray = (tempDict!.value(forKey: "parks") as! NSArray) as Array
             
             for dict in tempArray {
                 let parkName = dict["parkName"]! as! String
                 let parkLocation = dict["parkLocation"]! as! String
                 let latitude = (dict["latitude"]! as! NSString).doubleValue
                 let longitude = (dict["longitude"]! as! NSString).doubleValue
                 let location = CLLocation(latitude: latitude, longitude: longitude)
                 let area = dict["area"]! as! String
                 let dateFormed = dict["dateFormed"]! as! String
                 let description = dict["description"]! as! String
                 let imageLink = dict["imageLink"]! as! String
                 let imageName = dict["imageName"]! as! String
                 let imageSize = dict["imageSize"]! as! String
                 let imageType = dict["imageType"]! as! String
                 let link = dict["link"]! as! String
                 let distanceT = 0.0
                 
                 
                 let p = Park(parkName: parkName, parkLocation: parkLocation, dateFormed: dateFormed, area: area, link: link, location: location, imageLink: imageLink, parkDescription: description, imageName: imageName, imageSize: imageSize, imageType: imageType, distanceH: Float(distanceT))
                 
                 
                 parks.append(p)
    
             }
         }
     }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

