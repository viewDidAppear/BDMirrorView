//
//  ViewController.swift
//  BDMirrorLayer
//
//  Created by Benjamin Deckys on 06/29/2022.
//  Copyright (c) 2022 Benjamin Deckys. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let destination = segue.destination as? PreviewViewController else { return }

		switch segue.identifier {
			case "topRef":
				destination.direction = 0
			case "leftRef":
				destination.direction = 1
			case "bottomRef":
				destination.direction = 2
			case "rightRef":
				destination.direction = 3
			default:
				break
		}
	}

}

