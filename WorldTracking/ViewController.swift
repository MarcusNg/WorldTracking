//
//  ViewController.swift
//  WorldTracking
//
//  Created by Marcus Ng on 12/7/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addBtnPessed(_ sender: Any) {
        // Different shapes
//        node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
//        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
//        node.geometry = SCNCone(topRadius: 0.1, bottomRadius: 0.1, height: 0.3)
//        node.geometry = SCNCylinder(radius: 0.2, height: 0.2)
//        node.geometry = SCNSphere(radius: 0.1)
//        node.geometry = SCNTube(innerRadius: 0.2, outerRadius: 0.3, height: 0.5)
//        node.geometry = SCNTorus(ringRadius: 0.3, pipeRadius: 0.1)
//        node.geometry = SCNPlane(width: 0.2, height: 0.2)
        
        // Line
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0, y: 0))
//        path.addLine(to: CGPoint(x: 0, y: 0.2))
//        path.addLine(to: CGPoint(x: 0.2, y: 0.3))
//        path.addLine(to: CGPoint(x: 0.4, y: 0.2))
//        path.addLine(to: CGPoint(x: 0.4, y: 0.0))
//        let shape = SCNShape(path: path, extrusionDepth: 0.2)
//        node.geometry = shape

        // HOUSE
        // Roof
        let node = SCNNode()
        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        // Rotate x-axis 30 degrees
        node.eulerAngles = SCNVector3(Float(30.degreesToRadians),0,0)
        node.position = SCNVector3(0.2,0.3,-0.2)
        

        // Box
        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        boxNode.position = SCNVector3(0,-0.05,0)

        // Door
        let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        doorNode.position = SCNVector3(0,-0.02,0.053)

        // Roof relative to scene
        self.sceneView.scene.rootNode.addChildNode(node)
        // Box relative to roof
        node.addChildNode(boxNode)
        // Door relative to box
        boxNode.addChildNode(doorNode)
    }
    
    @IBAction func resetBtnPressed(_ sender: Any) {
        self.restartSession()
    }
    
    func restartSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
}

extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
    
}

