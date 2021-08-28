//
//  SelectLanguageController.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 25/08/2021.
//

import UIKit
import SpriteKit
import Magnetic

class SelectLanguageController: BaseViewController {
    
    var window: UIWindow?
    
    @IBOutlet weak var magneticView: MagneticView! {
        didSet {
            magnetic.magneticDelegate = self
            magnetic.removeNodeOnLongPress = true
        }
    }
    
    var magnetic: Magnetic {
        return magneticView.magnetic
    }
    
    var didSelectedLanguages: ((_ languages: [Language]) -> Void)?
    
    var selectedLanguages: [Language] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for name in Language.allCases {
            let color = UIColor.colors.randomItem()
            let node = Node(text: name.title,
                            image: UIImage(named: name.rawValue),
                            color: color,
                            radius: 40)
            node.scaleToFitContent = true
            node.selectedColor = UIColor.colors.randomItem()
            magnetic.addChild(node)
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        if let window = window {
            let homeVC = HomeViewController.instantiateFromNib()
            let nav = UINavigationController(rootViewController: homeVC)
            nav.setNavigationBarHidden(true, animated: false)
            window.rootViewController = nav
            window.makeKeyAndVisible()
        } else {
            if !selectedLanguages.isEmpty {
                UserDefaults.standard.setValue(selectedLanguages.map { $0.rawValue }, forKey: "selectedLanguages")
                didSelectedLanguages?(selectedLanguages)
            }
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
}

extension SelectLanguageController: MagneticDelegate {
    
    func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
        selectedLanguages.append(Language.getLanguage(from: node.name ?? ""))
    }
    
    func magnetic(_ magnetic: Magnetic, didDeselect node: Node) {
        let deSelectedItem = Language.getLanguage(from: node.name ?? "")
        if let indx = selectedLanguages.firstIndex(where: { $0 == deSelectedItem }) {
            selectedLanguages.remove(at: indx)
        }
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
