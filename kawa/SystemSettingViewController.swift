//
//  SystemSettingViewController.swift
//  kawa
//
//  Created by utatti on 01/08/2015.
//  Copyright (c) 2015-2017 utatti and project contributors.
//  Licensed under the MIT License.
//

import Cocoa

class SystemSettingViewController: NSViewController {
    @IBOutlet var showMenubarIconCheckbox: NSButton!
    @IBOutlet var launchOnStartupCheckbox: NSButton!
    @IBOutlet weak var showNotificationCheckbox: NSButton!
    @IBOutlet var quitAppButton: NSButton!
    @IBOutlet var projectPageLink: HyperlinkTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        quitAppButton.target = self
        quitAppButton.action = #selector(SystemSettingViewController.quitApp(_:))

        showMenubarIconCheckbox.target = self
        showMenubarIconCheckbox.action = #selector(SystemSettingViewController.setShowMenubarIcon(_:))
        var isOn: Bool = Settings.get(.showMenubarIcon, withDefaultValue: true)
        showMenubarIconCheckbox.state = isOn ? NSOnState : NSOffState

        launchOnStartupCheckbox.target = self
        launchOnStartupCheckbox.action = #selector(SystemSettingViewController.setLaunchOnStartup(_:))
        isOn = Settings.get(.launchOnStartup, withDefaultValue: true)
        launchOnStartupCheckbox.state = isOn ? NSOnState : NSOffState

        isOn = Settings.get(.showNotification, withDefaultValue: false)
        showNotificationCheckbox.state = isOn ? NSOnState : NSOffState

        let urlString = projectPageLink.stringValue
        let url = URL(string: "https://" + urlString)
        projectPageLink.setURL(url!)
    }

    func quitApp(_ sender: AnyObject) {
        NSApplication.shared().terminate(nil)
    }

    func setShowMenubarIcon(_ sender: AnyObject) {
        let isOn: Bool = showMenubarIconCheckbox.state == NSOnState
        Settings.set(.showMenubarIcon, toValue: isOn)

        if isOn {
            StatusBar.createStatusBarItem()
        } else {
            StatusBar.removeStatusBarItem()
        }
    }

    func setLaunchOnStartup(_ sender: AnyObject) {
        let isOn: Bool = launchOnStartupCheckbox.state == NSOnState
        Settings.set(.launchOnStartup, toValue: isOn)
        LaunchOnStartup.setLaunchAtStartup(isOn)
    }

    @IBAction func showNotification(_ sender: NSButton) {
        Settings.set(.showNotification, toValue: sender.state == NSOnState)
    }
}
