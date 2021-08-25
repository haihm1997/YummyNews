//
//  SelectLanguageController.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 25/08/2021.
//

import UIKit
import SpriteKit
import Magnetic

class SelectLanguageController: UIViewController {
    
    @IBOutlet weak var magneticView: MagneticView! {
        didSet {
            magnetic.magneticDelegate = self
            magnetic.removeNodeOnLongPress = true
        }
    }
    
    var magnetic: Magnetic {
        return magneticView.magnetic
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for name in UIImage.names {
            let color = UIColor.colors.randomItem()
            let node = Node(text: name.capitalized, image: UIImage(named: name), color: color, radius: 40)
            node.scaleToFitContent = true
            node.selectedColor = UIColor.colors.randomItem()
            magnetic.addChild(node)
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        
    }
    
}

extension SelectLanguageController: MagneticDelegate {
    
    func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
        print("didSelect -> \(node)")
    }
    
    func magnetic(_ magnetic: Magnetic, didDeselect node: Node) {
        print("didDeselect -> \(node)")
    }
    
    func magnetic(_ magnetic: Magnetic, didRemove node: Node) {
        print("didRemove -> \(node)")
    }
    
}

// MARK: - ImageNode
class ImageNode: Node {
    override var image: UIImage? {
        didSet {
            texture = image.map { SKTexture(image: $0) }
        }
    }
    override func selectedAnimation() {}
    override func deselectedAnimation() {}
}

extension UIImage {
    
    static let names: [String] = ["argentina", "bolivia", "brazil", "chile", "costa rica", "cuba", "dominican republic", "ecuador"]
    
}

extension Array {
    
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
    
}

extension CGPoint {
    
    func distance(from point: CGPoint) -> CGFloat {
        return hypot(point.x - x, point.y - y)
    }
    
}
