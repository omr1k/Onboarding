//
//  OnboardingDemoApp.swift
//  OnboardingDemo
//
//  Created by James Sedlacek on 1/28/23.
//

import SwiftUI

@main
struct OnboardingDemoApp: App {
    var body: some Scene {
        WindowGroup {
            OnboardingView(onDismiss: {})
        }
    }
}
