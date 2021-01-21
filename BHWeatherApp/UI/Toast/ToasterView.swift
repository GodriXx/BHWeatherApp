//
//  ToasterView.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import UIKit

private let animationDuration = 0.7
private let defaultDisplayTime = 5.0

enum ToastType {
    case APIError
    case Advice
    case AddError
}

class ToasterView: UIView {

    var toastView: ToastView?
    var savedHeight: CGFloat = 80.0
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.savedHeight = frame.size.height
        self.backgroundColor = .clear
        self.toastView = UIView.viewFromNib(nibName: ToastView.self)
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.shadowOpacity = 2
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 1
        self.xibSetup(view: self.toastView!)
    }
    
    func setup(with type: ToastType, and message: String) {
        guard let toastView = self.toastView else { return }
        toastView.setupContent(with: type, and: message)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom
    func showWithDuration(time: Double?) {
        guard let toastView = self.toastView else { return }
        toastView.alpha = 0.0
        UIView.animate(withDuration: animationDuration, animations: { [weak self] in
            guard let self = self else { return }
            toastView.alpha = 1.0
            self.layer.shadowColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        }) { [weak self] (finished) in
            guard let self = self else { return }
            if finished {
                toastView.alpha = 1.0
                self.layer.shadowColor = UIColor.gray.withAlphaComponent(0.5).cgColor
                Timer.scheduledTimer(withTimeInterval: time ?? defaultDisplayTime, repeats: false) { (_) in
                    UIView.animate(withDuration: animationDuration, animations: {
                        toastView.alpha = 0.0
                    }, completion: { (finished) in
                        if finished {
                            self.layer.shadowColor = UIColor.clear.cgColor
                            self.hide()
                        }
                    })
                }
            }
        }
    }
    
    // MARK: - Private
    private func hide() {
        guard let toastView = self.toastView else { return }
        toastView.removeFromSuperview()
        self.toastView = nil
        self.removeFromSuperview()
    }
}
