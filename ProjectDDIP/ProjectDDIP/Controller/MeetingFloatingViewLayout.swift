//
//  MeetingFloatingViewLayout.swift
//  ProjectDDIP
//
//  Created by 차영훈 on 2021/08/29.
//

import UIKit
import FloatingPanel

class MeetingFloatingViewLayout: FloatingPanelLayout {
	let position: FloatingPanelPosition  = .bottom
	let initialState: FloatingPanelState = .half
	
	var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] {
		return [
			.half: FloatingPanelLayoutAnchor(fractionalInset: 0.4, edge: .bottom, referenceGuide: .safeArea),
		]
	}
	
	func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
		return 0.0
	}
}
