//
//  PreviewViewController.swift
//  BDMirrorLayer_Example
//
//  Created by Benjamin Deckys on 2022/06/29.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import BDMirrorLayer

final class PreviewViewController: UIViewController {

	@IBOutlet private weak var previewView: BDMirrorLayer!
	@IBOutlet private weak var segControl: UISegmentedControl!
	@IBOutlet private weak var slider: UISlider!
	@IBOutlet private weak var `switch`: UISwitch!

	var direction: Int?

	private var isAnimating: Bool = false

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		guard let direction = direction else { return }

		previewView.reflectionDirection = .init(rawValue: direction)
		segControl.selectedSegmentIndex = direction
		`switch`.isOn = previewView.shouldFadeReflection
	}

	@IBAction private func changeDirection(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
			case 0:
				previewView.reflectionDirection = .top
			case 1:
				previewView.reflectionDirection = .left
			case 2:
				previewView.reflectionDirection = .bottom
			case 3:
				previewView.reflectionDirection = .right
			default: break
		}
	}

	@IBAction private func changeDistance(_ sender: UISlider) {
		previewView.reflectionDistanceFromParent = CGFloat(sender.value)
	}

	@IBAction private func changeGradient(_ sender: UISwitch) {
		previewView.shouldFadeReflection = sender.isOn
	}

}
