//
//  ViewController.swift
//  MenuBarPopoverExample
//
//  Created by David Caddy on 15/6/20.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    static func newInsatnce() -> ViewController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier("ViewController")
      
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? ViewController else {
            fatalError("Unable to instantiate ViewController in Main.storyboard!")
        }
        return viewcontroller
    }
}

