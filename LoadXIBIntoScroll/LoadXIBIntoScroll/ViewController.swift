//
//  ViewController.swift
//  LoadXIBIntoScroll
//
//  Created by Don Mag on 12/7/18.
//  Copyright © 2018 DonMag. All rights reserved.
//

import UIKit

extension UIView {
	class func fromNib<T: UIView>() -> T {
		return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
	}
}

class LabelsHolderView: UIView {
	
	@IBOutlet var topLabel: UILabel!
	@IBOutlet var middleLabel: UILabel!
	@IBOutlet var bottomLabel: UILabel!
	
}

class ViewController: UIViewController {
	
	@IBOutlet var theXIBContainerView: UIView!
	
	var theXIBView: LabelsHolderView!
	
	var numLines = [3, 3, 3]
	
	func updateLabels() -> Void {
		
		theXIBView.topLabel.text = numLines[0] > 0 ? (1...numLines[0]).map({ "Top label Line \($0)" }).joined(separator: "\n") : ""
		theXIBView.middleLabel.text = numLines[1] > 0 ? (1...numLines[1]).map({ "Middle label Line \($0)" }).joined(separator: "\n") : ""
		theXIBView.bottomLabel.text = numLines[2] > 0 ? (1...numLines[2]).map({ "Bottom label Line \($0)" }).joined(separator: "\n") : ""
		
	}
	
	@IBAction func addLines(_ sender: Any) {
		if let b = sender as? UIButton {
			var i = 0
			switch b.currentTitle {
			case "Middle":
				i = 1
			case "Bottom":
				i = 2
			default:
				i = 0
			}
			numLines[i] += 1
			updateLabels()
		}
	}
	
	@IBAction func removeLines(_ sender: Any) {
		if let b = sender as? UIButton {
			var i = 0
			switch b.currentTitle {
			case "Middle":
				i = 1
			case "Bottom":
				i = 2
			default:
				i = 0
			}
			numLines[i] -= 1
			
			// make sure each element is at least 1
			numLines = numLines.map({ max($0, 1) })
			
			updateLabels()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		theXIBView = UIView.fromNib() as LabelsHolderView
		
		theXIBContainerView.addSubview(theXIBView)
		
		theXIBView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			theXIBView.topAnchor.constraint(equalTo: theXIBContainerView.topAnchor, constant: 0.0),
			theXIBView.bottomAnchor.constraint(equalTo: theXIBContainerView.bottomAnchor, constant: 0.0),
			theXIBView.leadingAnchor.constraint(equalTo: theXIBContainerView.leadingAnchor, constant: 0.0),
			theXIBView.trailingAnchor.constraint(equalTo: theXIBContainerView.trailingAnchor, constant: 0.0),
			])
		
		updateLabels()
		
	}
	
}
