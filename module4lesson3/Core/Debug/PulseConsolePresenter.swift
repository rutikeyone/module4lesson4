//
//  PulseConsolePresenter.swift
//  module4lesson3
//
//  Created by Andrew on 07.06.2026.
//

#if DEBUG
import UIKit
import PulseUI

final class PulseConsoleWindow: UIWindow {
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        guard motion == .motionShake else { return }
        presentConsole()
    }

    private func presentConsole() {
        guard let topController = topMostController() else { return }
        if topController is MainViewController { return }

        let console = MainViewController()
        console.modalPresentationStyle = .fullScreen
        
        if let sheet = console.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        topController.present(console, animated: true)
    }

    private func topMostController() -> UIViewController? {
        var controller = rootViewController
        while let presented = controller?.presentedViewController {
            controller = presented
        }
        return controller
    }
}
#endif
