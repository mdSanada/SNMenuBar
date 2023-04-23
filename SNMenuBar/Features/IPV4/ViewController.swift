//
//  ViewController.swift
//  SNMenuBar
//
//  Created by Matheus D Sanada on 14/03/23.
//

import Cocoa

enum RequestState {
    case loading(Bool)
    case success(String)
    case error
}

class ViewController: NSViewController {
    @IBOutlet weak var ipAdressLabel: NSTextField!
    @IBOutlet weak var ipAddress: NSTextFieldCell!
    @IBOutlet weak var buttonRetry: NSButton!
    @IBOutlet weak var buttonCopy: NSButton!
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    var myIp: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPublicIPAddress()
        
        
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    private func request(state: RequestState) {
        switch state {
        case .loading(let loading):
            ipAdressLabel.isHidden = loading
            buttonRetry.isHidden = true
            buttonCopy.isHidden = true
            progressIndicator.isHidden = !loading
            if loading {
                progressIndicator.startAnimation(self)
            } else {
                progressIndicator.stopAnimation(self)
            }
        case .success(let string):
            ipAddress.title = string
            buttonRetry.isHidden = true
            buttonCopy.isHidden = false
            myIp = string
        case .error:
            ipAdressLabel.isHidden = true
            buttonRetry.isHidden = false
            buttonCopy.isHidden = true
            myIp = nil
        }
    }
    
    @IBAction func retry(_ sender: Any) {
        getPublicIPAddress()
    }
    
    @IBAction func copy(_ sender: Any) {
        guard let myIp = myIp else { return }
        setToPasteboard(myIp)
    }
    
    func setToPasteboard(_ text: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
        pasteboard.setString(text, forType: NSPasteboard.PasteboardType.string)
    }

}

extension ViewController {
    func getPublicIPAddress() {
        request(state: .loading(true))
        if let url = URL(string: "https://www.bluewindsolution.com/tools/getpublicip.php") {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let data = data, let string = String(data: data, encoding: .utf8) else {
                    self?.request(state: .loading(false))
                    self?.request(state: .error)
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    self?.request(state: .loading(false))
                    self?.request(state: .success(string))
                }
            }.resume()
        }
    }
}

extension ViewController {
    // MARK: Storyboard instantiation
    static func freshController() -> ViewController {
        //1.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        //2.
        let identifier = NSStoryboard.SceneIdentifier("ViewController")
        //3.
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? ViewController else {
            fatalError("Why cant i find QuotesViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}
