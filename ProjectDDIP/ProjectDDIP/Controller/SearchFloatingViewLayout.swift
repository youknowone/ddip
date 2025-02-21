//
//  SearchFloatingViewLayout.swift
//  ProjectDDIP
//
//  Created by 차영훈 on 2021/08/29.
//

import UIKit
import FloatingPanel

class SearchFloatingViewLayout: FloatingPanelLayout {
	let position: FloatingPanelPosition  = .bottom
	let initialState: FloatingPanelState = .tip
	
	var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] {
		return [
			.full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
			.half: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea),
			.tip: FloatingPanelLayoutAnchor(absoluteInset: 44.0, edge: .bottom, referenceGuide: .safeArea),
		]
	}
	
	func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
//		return state == .full ? 0.3 : 0.0
		return 0.0
	}
}
