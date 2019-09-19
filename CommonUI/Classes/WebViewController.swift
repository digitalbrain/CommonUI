//
//  WebViewController.swift
//  CommonUI
//
//  Created by Massimiliano on 23/10/2018.
//

import UIKit
import WebKit

open class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet weak var mainView: UIView?
    @IBOutlet weak var titleLbl: UILabel?
    @IBOutlet weak var closeBtn: UIButton?
    @IBOutlet weak var contentView: UIView?
    @IBOutlet weak var loaderView: LinearLoader?
    var urlObservation: NSKeyValueObservation?
    public var willLoadURLCompletion: ((_ url: URL)->())?
    
    var url: URL?
    
    public static func create(url: URL) -> WebViewController {
        let bundle = Bundle(for: self.self)
        let webVC = UIStoryboard(name: "CommonUI.bundle/CommonUI", bundle: bundle).instantiateViewController(withIdentifier: "WebViewController") as? WebViewController
        webVC?.url = url
        return webVC!
    }
    
    open func show(fromVC: UIViewController) {
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
        fromVC.present(self, animated: true, completion: nil)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.titleLbl?.text = self.url?.absoluteString
        let webView = WKWebView()
        webView.uiDelegate = self
        urlObservation = webView.observe(\.url, changeHandler: { [weak self](webView, change) in
            if let url = webView.url {
                self?.willLoadURLCompletion?(url)
                self?.titleLbl?.text = url.absoluteString
            }
        })
        webView.navigationDelegate = self
        if let url = self.url {
            webView.load(URLRequest(url: url))
            self.loaderView?.startAnimating()
        }
        self.contentView?.add(subview: webView, margin: .zero)
    }
    
    
    open override func viewWillAppear(_ animated: Bool) {
        self.mainView?.transform = CGAffineTransform(translationX: 0, y: self.view.frame.size.height)
        super.viewWillAppear(animated)
        let coordinator = self.transitionCoordinator
        coordinator?.animate(alongsideTransition: { (coordinator) in
            self.mainView?.transform = .identity
        }, completion: nil)
    }
    
    
    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         self.loaderView?.stopAnimating()
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.loaderView?.stopAnimating()
    }
    
    @IBAction override public func closeAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        self.observationInfo = nil
    }
}
