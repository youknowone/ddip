//
//  ViewController.swift
//  ProjectDDIP
//
//  Created by su on 2021/08/23.
//

import UIKit
import MapKit
import FloatingPanel

class MainViewController: UIViewController {
	lazy var mainViewContainer = MainViewContainer(storyBoard: storyboard)
	
	override func viewDidLoad() {
		super.viewDidLoad()
    
		initMainView()
		
		// Search
		initSearchPanel()
		initSearchView()
		
		// Meeting
		initMeetingPanel()
		initMeetingView()
	}
}

private extension MainViewController {
	private func initMainView() {
		mainViewContainer.mapViewController.delegate = mainViewContainer.meetingViewController
		addChild(mainViewContainer.mapViewController)
		view.addSubview(mainViewContainer.mapViewController.view)
	}
}

private extension MainViewController {
	private func initSearchPanel() {
		let fpc = mainViewContainer.searchPanelController
		let fpcDelegate = SearchPanelDelegate(owner: self)
		
		mainViewContainer.searchPanelDelegate = fpcDelegate
		fpc.delegate = fpcDelegate
		fpc.contentMode = .fitToBounds
		fpc.set(contentViewController: mainViewContainer.searchViewController)
		fpc.track(scrollView: mainViewContainer.searchViewController.tableView)
		fpc.addPanel(toParent: self)
	}
	
	private func initSearchView() {
		let vc = mainViewContainer.searchViewController
		let searchFpc = mainViewContainer.searchPanelController
		
		vc.view.backgroundColor = .clear
		vc.movePanelToFull = {
			searchFpc.move(to: .full, animated: true)
		}
		vc.movePanelToTip = {
			searchFpc.move(to: .tip, animated: true)
		}
		vc.centerToSearchLocation = { (la, lo, dis) in
//			let location = CLLocation(latitude: la, longitude: lo)
			self.mainViewContainer.mapViewController.centerToLocation(self.mainViewContainer.mapViewController.convertToLocation(la, lo), dis)
		}
	}
}

private extension MainViewController {
	private func initMeetingPanel() {
		let fpc = mainViewContainer.meetingPanelController
		let fpcDelegate = MeetingPanelDelegate(owner: self)
		
		mainViewContainer.meetingPanelDelegate = fpcDelegate
		fpc.delegate = fpcDelegate
		fpc.contentMode = .fitToBounds
		fpc.set(contentViewController: mainViewContainer.meetingViewController)
		fpc.isRemovalInteractionEnabled = true
	}
	
	private func initMeetingView() {
		let vc = mainViewContainer.meetingViewController
		let meetingFpc = mainViewContainer.meetingPanelController
		let searchFpc = mainViewContainer.searchPanelController
		
		vc.view.backgroundColor = .clear
		vc.createPanel = {
			meetingFpc.addPanel(toParent: self, animated: true, completion: nil)
			searchFpc.dismiss(animated: true, completion: nil)
		}
		vc.removePanel = {
			meetingFpc.dismiss(animated: true, completion: nil)
		}
	}
}
