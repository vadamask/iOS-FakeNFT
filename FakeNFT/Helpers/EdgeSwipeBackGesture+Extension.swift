//
//  EdgeSwipeBackGesture+Extension.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 16.11.2023.
//

import UIKit

extension UIViewController {
    func addEdgeSwipeBackGesture() {
        let edgeSwipeGesture = UIScreenEdgePanGestureRecognizer(
            target: self,
            action: #selector(handleSwipeFromEdge)
        )
        edgeSwipeGesture.edges = .left
        view.addGestureRecognizer(edgeSwipeGesture)
    }

    @objc private func handleSwipeFromEdge(_ gesture: UIScreenEdgePanGestureRecognizer) {
        if gesture.state == .recognized {
            navigationController?.popViewController(animated: true)
        }
    }
}
