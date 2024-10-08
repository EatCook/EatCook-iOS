//
//  ScrollOffset.swift
//  EatCook
//
//  Created by 이명진 on 2/17/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func offsetX(completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader { proxy in
                    let rect = proxy.frame(in: .global)
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: rect)
                        .onPreferenceChange(OffsetKey.self, perform: completion)
                }
            }
    }
    
    @ViewBuilder
    func offset(_ coordinateSpace: AnyHashable, completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {
                    let rect = $0.frame(in: .named(coordinateSpace))
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: rect)
                        .onPreferenceChange(OffsetKey.self, perform: completion)
                }
            }
    }
    
    func offset(_ coordinateSpace: String, perform action: @escaping (CGRect) -> Void) -> some View {
        background(
            GeometryReader { proxy in
                Color.clear.preference(key: RectPreferenceKey.self,
                                       value: proxy.frame(in: .named(coordinateSpace)))
            }
        )
        .onPreferenceChange(RectPreferenceKey.self, perform: action)
    }
    
    @ViewBuilder
    func checkAnimationEnd<Value: VectorArithmetic>(for value: Value, completion: @escaping () -> ()) -> some View {
        self
            .modifier(AnimationEndCallback(for: value, onEnd: completion))
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

struct RectPreferenceKey: PreferenceKey {
    typealias Value = CGRect
    static var defaultValue = CGRect()
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

//fileprivate struct AnimationEndCallback<Value: VectorArithmetic>: Animatable, ViewModifier {
//    
//    var animatableData: Value {
//        didSet {
//            checkIfFinished()
//        }
//    }
//    
//    var endValue: Value
//    var onEnd: () -> ()
//    
//    init(for value: Value, onEnd: @escaping () -> Void) {
//        self.animatableData = value
//        self.endValue = value
//        self.onEnd = onEnd
//    }
//    
//    func body(content: Content) -> some View {
//        content
//    }
//    
//    private func checkIfFinished() {
//        if endValue == animatableData {
//            DispatchQueue.main.async {
//                onEnd()
//            }
//        }
//    }
//    
//}

fileprivate struct AnimationEndCallback<Value: VectorArithmetic>: Animatable, ViewModifier {
    
    var animatableData: Value {
        didSet {
            checkIfFinished()
        }
    }
    
    var endValue: Value
    var onEnd: () -> ()
    
    init(for value: Value, onEnd: @escaping () -> Void) {
        self.animatableData = value
        self.endValue = value
        self.onEnd = onEnd
    }
    
    func body(content: Content) -> some View {
        content
    }
    
    private func checkIfFinished() {
        if endValue == animatableData {
            DispatchQueue.main.async {
                onEnd()
            }
        }
    }
    
}
