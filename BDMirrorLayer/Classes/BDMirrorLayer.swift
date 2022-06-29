//
//  BDMirrorView.swift
//
//  Copyright (c) 2022 Benjamin J. Deckys
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
//  IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit

@IBDesignable
public final class BDMirrorLayer: UIView {

	/// List of valid directions for the reflected layer.
	/// Will fallback to the default `.bottom` if an invalid value is supplied to the initializer.
	public enum BDMirrorViewReflectionDirection: Int, Equatable {
		case top = 0
		case left
		case bottom
		case right

		public init(rawValue: Int) {
			switch rawValue {
				case 0: self = .top
				case 1: self = .left
				case 2: self = .bottom
				case 3: self = .right
				default: self = .bottom
			}
		}
	}

	// MARK: - Private Properties

	private lazy var gradientLayer: CAGradientLayer = {
		let l = CAGradientLayer()
		l.colors = [UIColor.black, UIColor.black, UIColor.black, UIColor.clear].map { $0.cgColor }
		return l
	}()

	// MARK: - Inspectables

	/// Opacity of the reflection layer. Value is the "difference" between the parent layer, and reflected layer. Defaults to `0.6` (Reflection opacity 40%)
	@IBInspectable public var reflectionOpacity: Float = 0.6 {
		didSet {
			configureAlpha()
		}
	}

	/// How much of the reflection to show.
	/// Will have no effect if `fadeReflection` is set to `false`.
	@IBInspectable public var reflectionLength: Double = 0.75 {
		didSet {
			configureGradientLayer()
		}
	}

	/// Whether or not to mask the reflection with a gradient, and fade it out.
	/// Setting to false will show the entire layer reflected, with no gradiented fade.
	@IBInspectable public var shouldFadeReflection: Bool = false {
		didSet {
			configureGradientLayer()
		}
	}

	/// The direction of the reflection. Defaults to `.bottom` (under the parent).
	/// Use this to set the style via Storyboard.
	@IBInspectable public var direction: Int = 2 {
		didSet {
			self.reflectionDirection = BDMirrorViewReflectionDirection(rawValue: direction)
		}
	}

	/// The "thickness of the glass" between the parent view and the reflected layer. Defaults to 2.
	@IBInspectable public var reflectionDistanceFromParent: CGFloat = 2 {
		didSet {
			configureTransform(forDirection: reflectionDirection)
		}
	}

	// MARK: - Non-Inspectable Public Properties

	/// The direction of the reflection. Defaults to `.bottom` (under the parent).
	public var reflectionDirection: BDMirrorViewReflectionDirection = .bottom {
		didSet {
			configureTransform(forDirection: reflectionDirection)
			configureGradientLayer()
		}
	}

	// MARK: - Init

	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}

	public override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}

	public override func awakeFromNib() {
		super.awakeFromNib()
		commonInit()
	}

	private func commonInit() {
		guard let replicatorLayer = self.layer as? CAReplicatorLayer else { fatalError("Something really weird has happened, or the \"layerClass\" is no longer set to CAReplicatorLayer.") }

		// We are rendering a single reflection
		replicatorLayer.instanceCount = 2

		configureTransform(forDirection: reflectionDirection)
		configureAlpha()
		configureGradientLayer()
	}

	// MARK: - Config

	private func configureAlpha() {
		guard let replicatorLayer = self.layer as? CAReplicatorLayer else { fatalError("Something really weird has happened, or the \"layerClass\" is no longer set to CAReplicatorLayer.") }
		replicatorLayer.instanceAlphaOffset = -reflectionOpacity
	}

	private func configureTransform(forDirection direction: BDMirrorViewReflectionDirection) {
		guard let replicatorLayer = self.layer as? CAReplicatorLayer else { fatalError("Something really weird has happened, or the \"layerClass\" is no longer set to CAReplicatorLayer.") }

		var transform = CATransform3DIdentity

		switch direction {
			case .bottom:
				let verticalOffset = bounds.height + reflectionDistanceFromParent
				transform = CATransform3DTranslate(transform, 0, verticalOffset, 0)
				transform = CATransform3DScale(transform, 1, -1, 0)
			case .left:
				let horizontalOffset: CGFloat = bounds.width + reflectionDistanceFromParent
				transform = CATransform3DTranslate(transform, -horizontalOffset, 0, 0)
				transform = CATransform3DScale(transform, -1, 1, 0)
			case .right:
				let horizontalOffset = bounds.width + reflectionDistanceFromParent
				transform = CATransform3DTranslate(transform, horizontalOffset, 0, 0)
				transform = CATransform3DScale(transform, -1, 1, 0)
			case .top:
				let verticalOffset: CGFloat = bounds.height + reflectionDistanceFromParent
				transform = CATransform3DTranslate(transform, 0, -verticalOffset, 0)
				transform = CATransform3DScale(transform, 1, -1, 0)
		}

		replicatorLayer.instanceTransform = transform
	}

	private func configureGradientLayer() {
		guard let replicatorLayer = self.layer as? CAReplicatorLayer else { fatalError("Something really weird has happened, or the \"layerClass\" is no longer set to CAReplicatorLayer.") }
		guard shouldFadeReflection else {
			replicatorLayer.mask = nil
			return
		}

		replicatorLayer.mask = gradientLayer

		gradientLayer.locations = [0.0, 0.5, 0.5, NSNumber(floatLiteral: reflectionLength)]

		switch reflectionDirection {
			case .top:
				gradientLayer.anchorPoint = CGPoint(x: 0, y: 1.0)
				gradientLayer.startPoint = CGPoint(x: 0, y: 1.0)
				gradientLayer.endPoint = CGPoint(x: 0, y: 0.0)
				gradientLayer.frame = CGRect(x: 0, y: -bounds.height, width: bounds.width * 2, height: bounds.height * 2)
			case .left:
				gradientLayer.anchorPoint = CGPoint(x: 1.0, y: 0)
				gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
				gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
				gradientLayer.frame = CGRect(x: -bounds.width, y: 0, width: bounds.width * 2, height: bounds.height * 2)
			case .bottom:
				gradientLayer.anchorPoint = .zero
				gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
				gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
				gradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.width * 2, height: bounds.height * 2)
			case .right:
				gradientLayer.anchorPoint = .zero
				gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
				gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
				gradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.width * 2, height: bounds.height * 2)
		}
	}

	// MARK: - Override Layer Class

	public override class var layerClass: AnyClass {
		CAReplicatorLayer.self
	}


}
