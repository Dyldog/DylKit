//
//  File.swift
//  
//
//  Created by Dylan Elliott on 16/12/2023.
//

#if canImport(UIKit)
import UIKit
#else
import AppKit
#endif

import SwiftUI

#if canImport(UIKit)
public struct LongPressButton<Label>: View where Label: View {
    let label: (() -> Label)
    let action: () -> Void
    let longPressAction: () -> Void

    public init(action: @escaping () -> Void, longPressAction: @escaping () -> Void, label: @escaping () -> Label) {
        self.label = label
        self.action = action
        self.longPressAction = longPressAction
    }

    public var body: some View {
        label()
            .onTapGesture {
                action()
            }
            .onLongPressGesture {
                longPressAction()
            }
//        Button(action: {
//        }, label: {
//            ZStack {
//                label()
//                // Using .simultaneousGesture(LongPressGesture().onEnded { _ in works on iOS but fails on Catalyst
//                TappableView(action: action, longPressAction: longPressAction)
//            }
//        })
    }
}

private struct TappableView: UIViewRepresentable {
    let action: () -> Void
    let longPressAction: () -> Void

    typealias UIViewType = UIView

    func makeCoordinator() -> TappableView.Coordinator {
        Coordinator(action: action, longPressAction: longPressAction)
    }

    func makeUIView(context: Self.Context) -> UIView {
        UIView().then {
            let tapGestureRecognizer = UITapGestureRecognizer(target: context.coordinator,
                                                              action: #selector(Coordinator.handleTap(sender:)))
            $0.addGestureRecognizer(tapGestureRecognizer)
            let doubleTapGestureRecognizer = UILongPressGestureRecognizer(target: context.coordinator,
                                                                          action: #selector(Coordinator.handleLongPress(sender:)))
            doubleTapGestureRecognizer.minimumPressDuration = 1
            doubleTapGestureRecognizer.require(toFail: tapGestureRecognizer)
            $0.addGestureRecognizer(doubleTapGestureRecognizer)
        }
    }

    func updateUIView(_ uiView: UIView, context: Self.Context) { }

    class Coordinator {
        let action: () -> Void
        let longPressAction: () -> Void

        init(action: @escaping () -> Void, longPressAction: @escaping () -> Void) {
            self.action = action
            self.longPressAction = longPressAction
        }

        @objc func handleTap(sender: UITapGestureRecognizer) {
            guard sender.state == .ended else { return }
            action()
        }

        @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
            guard sender.state == .began else { return }
            longPressAction()
        }
    }
}
#endif
