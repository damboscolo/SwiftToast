//
//  ViewController.swift
//  SwiftToast
//
//  Created by Daniele Boscolo on 04/04/17.
//  Copyright © 2017 Daniele Boscolo. All rights reserved.
//

import UIKit
import SwiftToast

class MainViewController: UIViewController {
    static let simpleCellIdentifier = "simpleCellIdentifier"
    
    @IBOutlet private var tableView: UITableView!
    
    struct Section {
        let rows: [Row]
        let headerTitle: String
    }
    
    struct Row {
        let title: String
        let toast: SwiftToastProtocol
    }
    
    var sections: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = [
            Section(rows: firstSectionRows(), headerTitle: "Default"),
            Section(rows: secondSectionRows(), headerTitle: "Customized View"),
            Section(rows: thirdSectionRows(), headerTitle: "Customized navigation bar")
        ]
    }
    
    func firstSectionRows() -> [Row] {
        return [
            Row(title: "Navigation bar",
                toast: SwiftToast(text: "This is a navigation bar toast")),
            
            Row(title: "Status bar",
                toast: SwiftToast(
                    text: "This is a status bar toast",
                    style: .statusBar)),
            
            Row(title: "Bottom to top",
                toast: SwiftToast(
                    text: "This is bottom to top toast",
                    target: self,
                    style: .bottomToTop)),
            
            Row(title: "Below navigation bar",
                toast: SwiftToast(
                    text: "This is Below navigation bar toast",
                    minimumHeight: CGFloat(100.0),
                    style: .belowNavigationBar))
        ]
    }
    
    func secondSectionRows() -> [Row] {
        return [
            Row(title: "Custom View",
                toast: CustomSwiftToast(
                    duration: 3.0,
                    minimumHeight: nil,
                    aboveStatusBar: true,
                    statusBarStyle: .lightContent,
                    isUserInteractionEnabled: true,
                    target: nil,
                    style: .navigationBar,
                    title: "CUSTOM VIEW",
                    subtitle: "This is a totally customized view with my subtitle",
                    backgroundColor: .blue
            )),
            Row(title: "Customized Custom View",
                toast: CustomSwiftToast(
                    duration: nil,
                    minimumHeight: nil,
                    aboveStatusBar: true,
                    statusBarStyle: .lightContent,
                    isUserInteractionEnabled: true,
                    target: self,
                    style: .bottomToTop,
                    title: "CHANGED CUSTOM VIEW!",
                    subtitle: "Easily change. This is a subtitle with three a lot of lines! Yes, a lot of lines. It's dynamic height. Yes, totally dynamic height, This is a subtitle with three lines! Yes, a lot of lines. It's dynamic height. Yes, totally dynamic heigh ☺️☺️",
                    backgroundColor: .orange
            ))
        ]
    }
    

    func thirdSectionRows() -> [Row] {
        // Navigation bar
        return [
            Row(title: "Message and image",
                toast: SwiftToast(
                    text: "This is a customized SwiftToast with image",
                    textAlignment: .left,
                    image: #imageLiteral(resourceName: "icAlert"),
                    backgroundColor: .purple,
                    textColor: .white,
                    font: .boldSystemFont(ofSize: 15.0),
                    duration: 2.0,
                    statusBarStyle: .lightContent,
                    aboveStatusBar: true,
                    target: nil,
                    style: .navigationBar)),
            
            Row(title: "Dark status bar",
                toast: SwiftToast(
                    text: "See the dark status bar. Cute right?",
                    textAlignment: .left,
                    image: #imageLiteral(resourceName: "icAlert"),
                    backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),
                    textColor: UIColor.black,
                    font: UIFont.boldSystemFont(ofSize: 13.0),
                    duration: 4.0,
                    statusBarStyle: .default,
                    aboveStatusBar: false,
                    target: nil,
                    style: .navigationBar)),
            
            Row(title: "Above status bar",
                toast: SwiftToast(
                    text: "You don't see status bar and the text is on center",
                    textAlignment: .center,
                    image: nil,
                    backgroundColor: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1),
                    textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                    font: UIFont.boldSystemFont(ofSize: 13.0),
                    duration: 2.0,
                    statusBarStyle: .lightContent,
                    aboveStatusBar: true,
                    target: nil,
                    style: .navigationBar)),
            
            Row(title: "Very long text",
                toast: SwiftToast(
                    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                    textAlignment: .left,
                    image: nil,
                    backgroundColor: #colorLiteral(red: 0.723318932, green: 0.7605775616, blue: 0.8339516754, alpha: 1),
                    textColor: .black,
                    font: UIFont.boldSystemFont(ofSize: 13.0),
                    duration: 9.0,
                    statusBarStyle: .default,
                    aboveStatusBar: false,
                    target: nil,
                    style: .navigationBar)),
            
            Row(title: "Very long text with image",
                toast: SwiftToast(
                    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                    textAlignment: .left,
                    image: #imageLiteral(resourceName: "icAlert"),
                    backgroundColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1),
                    textColor: .white,
                    font: UIFont.systemFont(ofSize: 14.0),
                    duration: 9.0,
                    statusBarStyle: .lightContent,
                    aboveStatusBar: false,
                    target: nil,
                    style: .navigationBar)),
            
            Row(title: "Force user interaction",
                toast: SwiftToast(
                    text: "Click here to dismiss",
                    textAlignment: .left,
                    image: #imageLiteral(resourceName: "icAlert"),
                    backgroundColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1),
                    textColor: UIColor.white,
                    font: UIFont.boldSystemFont(ofSize: 13.0),
                    duration: nil,
                    statusBarStyle: .lightContent,
                    aboveStatusBar: false,
                    target: nil,
                    style: .navigationBar))
        ]
    }
}

// MARK:- UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].headerTitle
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == sections.count - 1 {
            return "\nPowered by Daniele Boscolo\nFor more: github/damboscolo\n\n"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: MainViewController.simpleCellIdentifier)
        let row = sections[indexPath.section].rows[indexPath.row]
        cell.textLabel?.text = row.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let toast = sections[indexPath.section].rows[indexPath.row].toast
        
        if indexPath.section == 1 {
            present(toast, withCustomSwiftToastView: CustomSwiftToastView(), animated: true)
        } else {
            present(toast, animated: true)
        }
    }
}

// MARK:- SwiftToastDelegate

extension MainViewController: SwiftToastDelegate {
    func swiftToastDidTouchUpInside(_ swiftToast: SwiftToastProtocol) {
        let alert = UIAlertController(title: "Alert", message: "SwiftToastDidTouchUpInside delegate", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
    
    func swiftToast(_ swiftToast: SwiftToastProtocol, presentedWith height: CGFloat) {
        tableView.contentInset = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: height, right: 0.0)
    }
    
    func swiftToastDismissed(_ swiftToast: SwiftToastProtocol) {
        tableView.contentInset = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
}
