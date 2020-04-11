//
//  ViewController.swift
//  DropBoxTask
//
//  Created by Abdulqadar on 09/04/2020.
//  Copyright © 2020 Abdul Qadar. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices
import AVFoundation
import Photos
import PDFKit
import QuickLookThumbnailing
import WebKit

class DocumentVC: BaseVC {
    
    fileprivate var currentVC: UIViewController?
    
    @IBOutlet weak var barView1: UIView!
    @IBOutlet weak var barView2: UIView!
    @IBOutlet weak var barView3: UIView!
    @IBOutlet weak var barView4: UIView!
    
    @IBOutlet weak var fieldView1: UIView!
    @IBOutlet weak var fieldView2: UIView!
    @IBOutlet weak var fieldView3: UIView!
    @IBOutlet weak var fieldView4: UIView!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    
    @IBOutlet weak var btnDone: UIButton!
    
    var globalTag = 0
    var globalCount = 0
    
    var idCardImg       : UIImage? = nil
    var cvImg           : UIImage? = nil
    var licenseImg      : UIImage? = nil
    var certificateImg  : UIImage? = nil
    
    var idCardPDFUrl: URL? = nil
    var cvPDFUrl: URL? = nil
    var licensePDFUrl: URL? = nil
    var certificatePDFUrl: URL? = nil
    
    var isIDCardSelected        = false
    var isCVSelected            = false
    var isLicenseSelected       = false
    var isCertificateSelected   = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    //MARK: - IBActions
    
    @IBAction func actionBack(_ sender: UIButton) {
        
        self.popVC()
        
    }
    
    @IBAction func actionIDCard(_ sender: UIButton) {
        
        self.fieldView1.setColorView()
        self.fieldView2.setView()
        self.fieldView3.setView()
        self.fieldView4.setView()
        self.globalTag = sender.tag
        
        self.showAttachmentActionSheet(vc: self)
    }
    
    @IBAction func actionCV(_ sender: UIButton) {
        
        self.fieldView2.setColorView()
        self.fieldView1.setView()
        self.fieldView3.setView()
        self.fieldView4.setView()
        self.globalTag = sender.tag
        self.showAttachmentActionSheet(vc: self)
        
    }
    
    @IBAction func actionLicense(_ sender: UIButton) {
        
        self.fieldView3.setColorView()
        self.fieldView1.setView()
        self.fieldView2.setView()
        self.fieldView4.setView()
        self.globalTag = sender.tag
        
        self.showAttachmentActionSheet(vc: self)
        
    }
    
    @IBAction func actionCertificate(_ sender: UIButton) {
        
        self.fieldView4.setColorView()
        self.fieldView1.setView()
        self.fieldView2.setView()
        self.fieldView3.setView()
        self.globalTag = sender.tag
        
        self.showAttachmentActionSheet(vc: self)
        
    }
    
    @IBAction func showIDCard(_ sender: UIButton) {
        
        if self.idCardImg != nil{
            self.showImgLarger(img: self.idCardImg!)
        }else if idCardPDFUrl != nil{
            loadPDFFile(fileURL: idCardPDFUrl!)
        }
    }
    
    @IBAction func showCV(_ sender: UIButton) {
        
        if self.cvImg != nil{
            self.showImgLarger(img: self.cvImg!)
        }else if cvPDFUrl != nil {
            loadPDFFile(fileURL: cvPDFUrl!)
        }
        
    }
    
    @IBAction func showLicense(_ sender: UIButton) {
        
        if self.licenseImg != nil{
            self.showImgLarger(img: self.licenseImg!)
        }else if licensePDFUrl != nil {
            loadPDFFile(fileURL: licensePDFUrl!)
        }
    }
    
    @IBAction func showCertificate(_ sender: UIButton) {
        
        if self.certificateImg != nil {
            self.showImgLarger(img: self.certificateImg!)
        }else if certificatePDFUrl != nil {
            loadPDFFile(fileURL: certificatePDFUrl!)
        }
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    
    @IBAction func actionDone(_ sender: UIButton) {
        
        self.showSwiftMessage(title: "info", message: "permission denied!", type: "warning")
        
    }
    
    //MARK: - Custom
    
    func setupUI(){
        
        self.globalTag = 0
        self.fieldView1.setView()
        self.fieldView2.setView()
        self.fieldView3.setView()
        self.fieldView4.setView()
        
        self.btnDone.setBtnUI()
        self.btnDone.isEnabled = false
        
    }
    
    func showImgLarger(img: UIImage) {
        
        let newImageView = UIImageView(image: img)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
    }
    
    func getDoneEnabled(){
        
        self.globalCount += 1
        
        if self.globalCount == 4{
            self.btnDone.isEnabled = true
        }else {
            self.btnDone.isEnabled = false
        }
    }
    
    func loadPDFFile(fileURL: URL) {
        
        let pdfView = PDFView(frame: self.view.bounds)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        pdfView.addGestureRecognizer(tap)
        self.view.addSubview(pdfView)

        // Fit content in PDFView.
        pdfView.autoScales = true

        pdfView.document = PDFDocument(url: fileURL)
    
    }
    
    
    //MARK: - showAttachmentActionSheet
    func showAttachmentActionSheet(vc: UIViewController) {
        currentVC = vc
        let actionSheet = UIAlertController(title: Constants.actionFileTypeHeading, message: Constants.actionFileTypeDescription, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: Constants.camera, style: .default, handler: { (action) -> Void in
            self.authorisationStatus(attachmentTypeEnum: .camera, vc: self.currentVC!)
        }))
        
        actionSheet.addAction(UIAlertAction(title: Constants.phoneLibrary, style: .default, handler: { (action) -> Void in
            self.authorisationStatus(attachmentTypeEnum: .photoLibrary, vc: self.currentVC!)
        }))
        
        actionSheet.addAction(UIAlertAction(title: Constants.file, style: .default, handler: { (action) -> Void in
            self.documentPicker()
        }))
        
        actionSheet.addAction(UIAlertAction(title: Constants.cancelBtnTitle, style: .cancel, handler: nil))
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
    
    //MARK: - Authorisation Status
    
    func authorisationStatus(attachmentTypeEnum: AttachmentType, vc: UIViewController){
        currentVC = vc
        
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            if attachmentTypeEnum == AttachmentType.camera{
                openCamera()
            }
            if attachmentTypeEnum == AttachmentType.photoLibrary{
                photoLibrary()
            }
            
        case .denied:
            self.showSwiftMessage(title: "info", message: "permission denied!", type: "warning")
            
            self.addAlertForSettings(attachmentTypeEnum)
        case .notDetermined:
            self.showSwiftMessage(title: "info", message: "Permission Not Determined!", type: "warning")
            
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == PHAuthorizationStatus.authorized{
                    // photo library access given
                    print("access given")
                    if attachmentTypeEnum == AttachmentType.camera{
                        
                        DispatchQueue.main.async {
                            self.openCamera()
                        }
                    }
                    if attachmentTypeEnum == AttachmentType.photoLibrary{
                        
                        DispatchQueue.main.async {
                            self.photoLibrary()
                        }
                    }
                    
                }else{
                    print("restriced manually")
                    
                    DispatchQueue.main.async {
                        self.addAlertForSettings(attachmentTypeEnum)
                    }
                }
            })
        case .restricted:
            self.showSwiftMessage(title: "info", message: "permission restricted!", type: "warning")
            self.addAlertForSettings(attachmentTypeEnum)
        default:
            break
        }
    }
    
    
    //MARK: - CAMERA PICKER
    //This function is used to open camera from the iphone and
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .camera
            currentVC?.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    
    //MARK: - PHOTO PICKER
    func photoLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            currentVC?.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    
    //MARK: - FILE PICKER
    func documentPicker(){
        
        let types = [kUTTypePDF, kUTTypeText, kUTTypeRTF, kUTTypeSpreadsheet]
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: types as [String], in: .import)

        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        currentVC?.present(documentPicker, animated: true, completion: nil)
    }
    
    //MARK: - SETTINGS ALERT
    func addAlertForSettings(_ attachmentTypeEnum: AttachmentType){
        var alertTitle: String = ""
        if attachmentTypeEnum == AttachmentType.camera{
            alertTitle = Constants.alertForCameraAccessMessage
        }
        if attachmentTypeEnum == AttachmentType.photoLibrary{
            alertTitle = Constants.alertForPhotoLibraryMessage
        }
        if attachmentTypeEnum == AttachmentType.video{
            alertTitle = Constants.alertForVideoLibraryMessage
        }
        
        let cameraUnavailableAlertController = UIAlertController (title: alertTitle , message: nil, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: Constants.settingsBtnTitle, style: .destructive) { (_) -> Void in
            let settingsUrl = NSURL(string:UIApplication.openSettingsURLString)
            if let url = settingsUrl {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: Constants.cancelBtnTitle, style: .default, handler: nil)
        cameraUnavailableAlertController .addAction(cancelAction)
        cameraUnavailableAlertController .addAction(settingsAction)
        currentVC?.present(cameraUnavailableAlertController , animated: true, completion: nil)
    }
}



extension DocumentVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            if let imageData = pickedImage.pngData(){
                let options = [
                    kCGImageSourceCreateThumbnailWithTransform: true,
                    kCGImageSourceCreateThumbnailFromImageAlways: true,
                    kCGImageSourceThumbnailMaxPixelSize: 100] as CFDictionary
                
                imageData.withUnsafeBytes { ptr in
                    guard let bytes = ptr.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                        return
                    }
                    if let cfData = CFDataCreate(kCFAllocatorDefault, bytes, imageData.count){
                        let source = CGImageSourceCreateWithData(cfData, nil)!
                        let imageReference = CGImageSourceCreateThumbnailAtIndex(source, 0, options)!
                        let thumbnail = UIImage(cgImage: imageReference)
                        
                        if self.globalTag == 1 {
                            
                            self.idCardImg = pickedImage
                            self.img1.image = thumbnail
                            self.barView1.backgroundColor = #colorLiteral(red: 0.2602886001, green: 0.7406979138, blue: 0.8698821068, alpha: 1)
                            self.getDoneEnabled()
                            
                        }else if self.globalTag == 2 {
                            
                            self.cvImg = pickedImage
                            self.img2.image = thumbnail
                            self.barView2.backgroundColor = #colorLiteral(red: 0.2602886001, green: 0.7406979138, blue: 0.8698821068, alpha: 1)
                            self.getDoneEnabled()
                            
                        }else if self.globalTag == 3 {
                            
                            self.licenseImg = pickedImage
                            self.img3.image = thumbnail
                            self.barView3.backgroundColor = #colorLiteral(red: 0.2602886001, green: 0.7406979138, blue: 0.8698821068, alpha: 1)
                            self.getDoneEnabled()
                            
                        }else if self.globalTag == 4 {
                            
                            self.certificateImg = pickedImage
                            self.img4.image = thumbnail
                            self.barView4.backgroundColor = #colorLiteral(red: 0.2602886001, green: 0.7406979138, blue: 0.8698821068, alpha: 1)
                            self.getDoneEnabled()
                            
                        }
                    }
                }
            }
        }else {
            print("Something went wrong in  image")
            self.showSwiftMessage(title: "info", message: "Something went wrong in  image!", type: "warning")
        }
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
}

extension DocumentVC: UIDocumentPickerDelegate{
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        print("url", url)
        
        let size: CGSize = CGSize(width: 60, height: 90)
        let scale = UIScreen.main.scale
        
        // Create the thumbnail request.
        let request = QLThumbnailGenerator.Request(fileAt: url,
                                                   size: size,
                                                   scale: scale,
                                                   representationTypes: .all)
        
        let generator = QLThumbnailGenerator.shared
        generator.generateRepresentations(for: request) { (thumbnail, type, error) in
            DispatchQueue.main.async {
                if thumbnail == nil || error != nil {} else {
                    
                    if self.globalTag == 1 {
                        
                        self.img1.image = thumbnail?.uiImage
                        self.idCardPDFUrl = url
                        self.barView1.backgroundColor = #colorLiteral(red: 0.2602886001, green: 0.7406979138, blue: 0.8698821068, alpha: 1)
                        self.getDoneEnabled()
                        
                    }else if self.globalTag == 2 {
                        
                        self.img2.image = thumbnail?.uiImage
                        self.cvPDFUrl = url
                        self.barView2.backgroundColor = #colorLiteral(red: 0.2602886001, green: 0.7406979138, blue: 0.8698821068, alpha: 1)
                        self.getDoneEnabled()
                        
                    }else if self.globalTag == 3 {
                        
                        self.img3.image = thumbnail?.uiImage
                        self.licensePDFUrl = url
                        self.barView3.backgroundColor = #colorLiteral(red: 0.2602886001, green: 0.7406979138, blue: 0.8698821068, alpha: 1)
                        self.getDoneEnabled()
                        
                        
                    }else if self.globalTag == 4 {
                        
                        self.img4.image = thumbnail?.uiImage
                        self.certificatePDFUrl = url
                        self.barView4.backgroundColor = #colorLiteral(red: 0.2602886001, green: 0.7406979138, blue: 0.8698821068, alpha: 1)
                        self.getDoneEnabled()
                    }
                }
            }
        }
    }
    
    //    Method to handle cancel action.
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
}

enum AttachmentType: String{
    case camera, video, photoLibrary
}


