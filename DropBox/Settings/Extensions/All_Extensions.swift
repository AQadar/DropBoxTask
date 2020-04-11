//
//  All_Extensions.swift
//  Kansai User
//
//  Created by Abdul Qadar / Engr.aqadar@gmail.com on 30/1/2019.
//  Copyright © 2019 Abdul Qadar / Engr.aqadar@gmail.com. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Button Extensions

extension UIButton {
    
    func underline() {
        if let textString = self.titleLabel?.text {
            
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: textString.count))
            self.setAttributedTitle(attributedString, for: .normal)
        }
    }
    
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    
    func setBtnUI() {
        self.backgroundColor = #colorLiteral(red: 0.0007905265084, green: 0.7560821176, blue: 0.8698821068, alpha: 1)
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.tintColor = UIColor.white
        self.layer.borderColor = #colorLiteral(red: 0.0007905265084, green: 0.7560821176, blue: 0.8698821068, alpha: 1)
    }
}

extension UIView {
    
    
    func setView() {
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 25
    }
    
    func setRedView() {
        self.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        self.layer.borderWidth = 1.5
        self.layer.cornerRadius = 25
    }

    func setColorView() {
        
        self.layer.borderColor = #colorLiteral(red: 0.2602886001, green: 0.7406979138, blue: 0.8698821068, alpha: 1)
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 25
    }
}

//MARK: - UIImageView Extensions

extension UIImageView {
    
    
    /// EZSwiftExtensions
    public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, imageName: String) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        image = UIImage(named: imageName)
    }
    
    /// EZSwiftExtensions
    public convenience init(x: CGFloat, y: CGFloat, imageName: String, scaleToWidth: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: 0, height: 0))
        image = UIImage(named: imageName)
        if image != nil {
            scaleImageFrameToWidth(width: scaleToWidth)
        } else {
            assertionFailure("EZSwiftExtensions Error: The imageName: '\(imageName)' is invalid!!!")
        }
    }
    
    /// EZSwiftExtensions
    public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, image: UIImage) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        self.image = image
    }
    
    /// EZSwiftExtensions
    public convenience init(x: CGFloat, y: CGFloat, image: UIImage, scaleToWidth: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: 0, height: 0))
        self.image = image
        scaleImageFrameToWidth(width: scaleToWidth)
    }
    
    /// EZSwiftExtensions, scales this ImageView size to fit the given width
    public func scaleImageFrameToWidth(width: CGFloat) {
        guard let image = image else {
            print("EZSwiftExtensions Error: The image is not set yet!")
            return
        }
        let widthRatio = image.size.width / width
        let newWidth = image.size.width / widthRatio
        let newHeigth = image.size.height / widthRatio
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: newWidth, height: newHeigth)
    }
    
    /// EZSwiftExtensions, scales this ImageView size to fit the given height
    public func scaleImageFrameToHeight(height: CGFloat) {
        guard let image = image else {
            print("EZSwiftExtensions Error: The image is not set yet!")
            return
        }
        let heightRatio = image.size.height / height
        let newHeight = image.size.height / heightRatio
        let newWidth = image.size.width / heightRatio
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: newWidth, height: newHeight)
    }
    
    /// EZSwiftExtensions
    public func roundSquareImage() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
    }
}

//MARK: -  UITextField Extensions

extension UITextField {
    
    @IBInspectable var placeholderColor: UIColor {
        get {
            return self.attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? .lightText
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [.foregroundColor: newValue])
        }
    }
    

    
    func setField() {
        
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 25
        
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
        
    }
    
    
    func setRedField() {
        
        self.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)//UIColor(red: 0, green: 153, blue: 212, alpha: 1.0).cgColor
        self.layer.borderWidth = 1.5
        self.layer.cornerRadius = 25
        
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
        
    }
    
    func setColorField() {
        
        self.layer.borderColor = #colorLiteral(red: 0.2602886001, green: 0.7406979138, blue: 0.8698821068, alpha: 1) //UIColor(red: 0/255, green: 116/255, blue: 182/255, alpha: 1.0).cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 25
        
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
        
    }
}

//MARK: -  String Extensions

extension String {
    
    public  init ( deviceToken :  Data )  {
//        self  =  deviceToken . map  {  String ( format :  "% .2Hhx" ,  "$", 0 )  } . : joined ()
        self = deviceToken.map { String(format: "% .2hhx", $0) }.joined()
    }
    
    func fromUTCToLocalDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var formattedString = self.replacingOccurrences(of: "Z", with: "")
        if let lowerBound = formattedString.range(of: ".")?.lowerBound {
            formattedString = "\(formattedString[..<lowerBound])"
        }
        
        guard let date = dateFormatter.date(from: formattedString) else {
            return self
        }
        
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }

    func trim() -> String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
   
    var isValidEmail: Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)

        return emailTest.evaluate(with: self)
    }
    
    var localized: String {
        if let _ = UserDefaults.standard.string(forKey: "i_Language") {} else {
            UserDefaults.standard.synchronize()
        }
        
        let Language = UserDefaults.standard.string(forKey: "i_Language")
        let path = Bundle.main.path(forResource: Language, ofType: "lproj")
        let bundle = Bundle(path: path!)
        let localize = NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        print(localize)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
   
    var isValidPassword: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z_0-9\\-_,;.:#+*?=!§$%&/()@]+$", options: .caseInsensitive)
            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil){
                
                if(self.count>=6 && self.count<=20){
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        } catch {
            return false
        }
    }
    func isPasswordLength(password: String , confirmPassword : String) -> Bool {
        if password.count <= 7 && confirmPassword.count <= 7{
            return true
        }else{
            return false
        }
    }
    
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
}

//MARK: -  ViewController Extensions

extension UIViewController {
    
    
    open func pushVC(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func PushViewWithIdentifier(name : String) {
        print(name)
        let viewPush = self.storyboard?.instantiateViewController(withIdentifier: name)
        self.navigationController?.pushViewController(viewPush!, animated: true)
    }
    
    open func popVC() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    open func popToRootVC() {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    open func presentVC(_ vc: UIViewController) {
        present(vc, animated: true, completion: nil)
    }
    open func dismissVC(completion: (() -> Void)? ) {
        dismiss(animated: true, completion: completion)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    
    func myDateFormater(date: String) -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-ddTHH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM yyyy"
        
        print(date)
        let mydate = dateFormatterGet.date(from: date)
        print(dateFormatterPrint.string(from: mydate!))
        return dateFormatterPrint.string(from: mydate!)
        
    }

    
    func timeFormate(unixTime: Int) -> String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
        let dateFormatter = DateFormatter()
        // Returns date formatted as 12 hour time.
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date as Date)
    }
    
    func setUpView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionFlipFromBottom, animations: {
            view.isHidden = hidden
        })
    }
    
    func setDownView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCurlDown, animations: {
            view.isHidden = hidden
        })
    }
    
    func setPopUpView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCurlUp, animations: {
            view.isHidden = hidden
        })
    }
}


//MARK: -  Label Extensions

extension UILabel {
    
    
    
    func setBorderWidth(borderWidth: CGFloat) {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: textString.count))
            self.attributedText = attributedString
        }
    }
    

}


//MARK: - File Manager
extension FileManager {
    func saveFileToDocumentsDirectory(fileUrl: URL, name: String, extention: String) -> URL? {
        let videoData = NSData(contentsOf: fileUrl as URL)
        let path = try! FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
        
        let filePath = path.appendingPathComponent(name + extention)
        do {
            try videoData?.write(to: filePath)
            
            return filePath
        } catch {
            print(error)
            
            return nil
        }
    }
    
    func saveFileToDocumentsDirectory(image: UIImage, name: String, extention: String) -> URL? {
        let path = try! FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
        let imagePath = path.appendingPathComponent(name + extention)
        let jpgImageData = image.jpegData(compressionQuality: 1.0)

//        let jpgImageData = UIImageJPEGRepresentation(image, 1.0)
        do {
            try jpgImageData!.write(to: imagePath)
            
            return imagePath
        } catch {
            print(error)
            
            return nil
        }
    }
    
    func removeFileFromDocumentsDirectory(fileUrl: URL) -> Bool {
        do {
            try self.removeItem(at: fileUrl)
            
            return true
        } catch {
            return false
        }
    }
}


// MARK: - UIStoryBoard

extension UIStoryboard {
    
    public static var mainStoryboard: UIStoryboard {
        let bundle = Bundle.main
        guard let name = bundle.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String else {
            return UIStoryboard()
        }
        return UIStoryboard(name: name, bundle: bundle)
    }
}

// MARK: - Data

extension Data {
    func hexEncodedString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}





