//
//  PostAdViewCtrl.swift
//  FoureSale
//
//  Created by Dilip Bakotiya on 11/08/17.
//  Copyright © 2017 Author:  Archirayan infotech (dilip.bakotiya@gmail.com || info@archirayan.com ) Author URI: https://www.archirayan.com/. All rights reserved.
//

import UIKit
import MapKit
import MobileCoreServices
import BSImagePicker
import Photos
class PostAdViewCtrl: UIViewController, MKMapViewDelegate,UIPopoverControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var mapview: MKMapView!
    
    @IBOutlet var addPhotoAndVideoButton: UIButton!
    @IBOutlet var allowMassageButton: UIButton!
    let locationManager = CLLocationManager()
    
    @IBOutlet var voiceAndVideoButton: UIButton!
    @IBOutlet var postAsAnonymousButton: UIButton!
    //let places = Place.getPlaces()
    @IBOutlet var disableLocationButton: UIButton!
    @IBOutlet var procceedButton: UIButton!
    @IBOutlet var saveDraftButton: UIButton!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var orLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
  
        
        // Do any additional setup after loading the view.
        addPhotoAndVideoButton.titleLabel?.numberOfLines = 2
        allowMassageButton.titleLabel?.numberOfLines = 2
        voiceAndVideoButton.titleLabel?.numberOfLines = 2
        postAsAnonymousButton.titleLabel?.numberOfLines = 2
        addPhotoAndVideoButton.layer.borderWidth = 2
        addPhotoAndVideoButton.layer.borderColor = UIColor(red:0/255.0, green:181/255.0, blue:255/255.0, alpha: 1.0).cgColor
        
        mapview?.showsUserLocation = true
        requestLocationAccess()
        mapview.isHidden=false
        locationLabel.isHidden=false
       // voiceAndVideoButton.setImage(#imageLiteral(resourceName: "phone-call"), for: .normal)
       // voiceAndVideoButton.titleEdgeInsets = UIEdgeInsetsMake(0, 42, 0, 0);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
            
        case .denied, .restricted:
            print("location access denied")
            
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func addAnnotations() {
        mapview?.delegate = self
    }



    
    @IBAction func disableLocationButtonClicked(_ sender: Any) {
        if (mapview.isHidden==false){
            mapview.isHidden=true
            locationLabel.isHidden=true
            procceedButton.frame = (frame: CGRect(x: procceedButton.layer.frame.origin.x, y: procceedButton.layer.frame.origin.y-65, width: procceedButton.layer.frame.size.width, height: procceedButton.layer.frame.size.height))
            saveDraftButton.frame = (frame: CGRect(x: saveDraftButton.layer.frame.origin.x, y: saveDraftButton.layer.frame.origin.y-65, width: saveDraftButton.layer.frame.size.width, height: saveDraftButton.layer.frame.size.height))
            orLabel.frame = (frame: CGRect(x: orLabel.layer.frame.origin.x, y: orLabel.layer.frame.origin.y-65, width: orLabel.layer.frame.size.width, height: orLabel.layer.frame.size.height))
        }else{
            mapview.isHidden=false
            locationLabel.isHidden=false
            procceedButton.frame = (frame: CGRect(x: procceedButton.layer.frame.origin.x, y: procceedButton.layer.frame.origin.y+65, width: procceedButton.layer.frame.size.width, height: procceedButton.layer.frame.size.height))
            saveDraftButton.frame = (frame: CGRect(x: saveDraftButton.layer.frame.origin.x, y: saveDraftButton.layer.frame.origin.y+65, width: saveDraftButton.layer.frame.size.width, height: saveDraftButton.layer.frame.size.height))
            orLabel.frame = (frame: CGRect(x: orLabel.layer.frame.origin.x, y: orLabel.layer.frame.origin.y+65, width: orLabel.layer.frame.size.width, height: orLabel.layer.frame.size.height))
        }
    }
    @IBAction func allowMassageButtonClicked(_ sender: Any) {
       
    }
    @IBAction func voiceAndVideoButtonClicked(_ sender: Any) {
    }
    @IBAction func postAsAnonymousButtonClicked(_ sender: Any) {
    }
    @IBAction func procceedButtonClicked(_ sender: Any) {
    }
    @IBAction func saveDraftButtonClicked(_ sender: Any) {
    }
    @IBAction func addPhotoAndVideoButtonClicked(_ sender: Any) {
        
        
        let vc = BSImagePickerViewController()
        
        bs_presentImagePickerController(vc, animated: true,
                                        select: { (asset: PHAsset) -> Void in
                                            // User selected an asset.
                                            // Do something with it, start upload perhaps?
        }, deselect: { (asset: PHAsset) -> Void in
            // User deselected an assets.
            // Do something, cancel upload?
        }, cancel: { (assets: [PHAsset]) -> Void in
            // User cancelled. And this where the assets currently selected.
        }, finish: { (assets: [PHAsset]) -> Void in
            // User finished with these assets
        }, completion: nil)
        
        return
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Caputure Image", style: .default , handler:{ (UIAlertAction)in

      
            
            //            if UIImagePickerController.isSourceTypeAvailable(.camera) {
//                let imagePicker = UIImagePickerController()
//                imagePicker.delegate = self
//                imagePicker.sourceType = .camera;
//                imagePicker.allowsEditing = false
//                self.present(imagePicker, animated: true, completion: nil)
//            }
        }))
        
        alert.addAction(UIAlertAction(title: "Choose Images", style: .default , handler:{ (UIAlertAction)in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary;
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Capture Video", style: .default , handler:{ (UIAlertAction)in
            //alert.view.tintColor = UIColor.red
            if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
                if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
                    let imagePicker = UIImagePickerController()
                    imagePicker.sourceType = .camera
                    imagePicker.mediaTypes = [kUTTypeMovie as String]
                    imagePicker.allowsEditing = false
                    imagePicker.delegate = self
                    
                    self.present(imagePicker, animated: true, completion: {})
                } else {
                }
            } else {

            }
        }))
        
        alert.addAction(UIAlertAction(title: "Choose Video", style: .default , handler:{ (UIAlertAction)in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary;
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default , handler:{ (UIAlertAction)in

            alert .removeFromParentViewController()
        }))
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        
        alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 1)
        self.present(alert, animated: true, completion: {
            
        })

    }


}


