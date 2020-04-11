//
//  BaseVC.swift
//  RewCap
//
//  Created by Abdul Qadar / Engr.aqadar@gmail.com on 01/1/2019.
//  Copyright © 2019 Abdul Qadar. All rights reserved.

import UIKit
import NVActivityIndicatorView
import Alamofire
import SwiftMessages


class BaseVC: UIViewController, NVActivityIndicatorViewable {
    
    let AppDelegate            = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoader(){
        self.startAnimating(ActivitySize.size, message: "Loading..", messageFont: UIFont.systemFont(ofSize: 14), type: .ballSpinFadeLoader, color: #colorLiteral(red: 0.2602886001, green: 0.7406979138, blue: 0.8698821068, alpha: 1))
    }
        
    func moveBack() {
        navigationController?.popViewController(animated: true)
        dismissVC(completion: nil)
    }

    // set progressView
//    func updateLinearProgressView(value: Float, progressView: LinearProgressView) {
//
//        progressView.setProgress(value, animated: true)
//    }
    
    // ============== Display Alert Message Code Below
        
    func showAlert () {
        
        var config = SwiftMessages.defaultConfig
        let view = MessageView()
        view.configureContent(title: title, body: "", iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "Hide", buttonTapHandler: { _ in SwiftMessages.hide() })
        SwiftMessages.show(config: config, view: view)
        
    }
    
    
    func showSwiftMessage(title:String, message:String, type: String){
        
        let view: MessageView

        view = try! SwiftMessages.viewFromNib()
        
        view.configureContent(title: title, body: message, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "", buttonTapHandler: { _ in SwiftMessages.hide() })
        
        view.button?.isHidden = true
        view.iconImageView?.isHidden = false
        
        let iconStyle: IconStyle
        iconStyle = .default

        if type == "info"{
            view.configureTheme(.info, iconStyle: iconStyle)
            view.accessibilityPrefix = "info"

        }else if type == "success"{
            view.configureTheme(.success, iconStyle: iconStyle)
            view.accessibilityPrefix = "success"

        }else if type == "warning"{
            view.configureTheme(.warning, iconStyle: iconStyle)
            view.accessibilityPrefix = "warning"

            
        }else if type == "error"{
            view.configureTheme(.error, iconStyle: iconStyle)
            view.accessibilityPrefix = "error"
        }
        
        var config = SwiftMessages.Config()
        config.presentationStyle = .top
        config.presentationContext = .window(windowLevel: .normal)
        config.duration = .automatic
        config.interactiveHide = true
        SwiftMessages.show(config: config, view: view)

    }
}

struct ActivitySize {
    static let size = CGSize(width: 40, height: 40)
}
