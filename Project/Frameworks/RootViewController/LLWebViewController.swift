//
//  LLWebViewController.swift
//  Swift_demo
//
//  Created by 徐其威 on 2018/12/7.
//  Copyright © 2018 徐其威. All rights reserved.
//

import UIKit
import WebKit

class LLWebViewController: LLViewController, WKUIDelegate, WKNavigationDelegate {
    
    public var webView : WKWebView!
    public var url = ""
    
    public func loadWeb() {
        if url != "" {
            print("url:", url)
            webView.load(URLRequest.init(url: URL(string: url)!))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let configuration  = WKWebViewConfiguration.init()
        configuration.allowsInlineMediaPlayback = true
        
        webView = WKWebView.init(frame: CGRect.zero, configuration: configuration)
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.bounces = true
        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        webView.sd_layout().spaceToSuperView(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        loadWeb()
    }
    // MARK: - 页面开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        networkActivityIndicator(true)
    }
    // MARK: - 内容开始返回
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    }
    // MARK: - 页面加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        networkActivityIndicator(false)
    }
    // MARK: - 页面加载失败
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        networkActivityIndicator(false)
        print(error)
    }
    
    // MARK: - 接受到服务器跳转请求
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
    }
    // MARK: - 发送请求前，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("1", navigationAction.request.url!.absoluteString)
        // 允许跳转
        decisionHandler(.allow)
        // 不允许跳转
//        decisionHandler(.cancel)
    }
    // MARK: - 收到响应，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("2", navigationResponse.response.url!.absoluteString)
        decisionHandler(.allow)
    }

    
    // MARK: - 页面内点击链接是否跳转新的网页
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if !navigationAction.targetFrame!.isMainFrame {
            webView.load(navigationAction.request)
        }
        return nil
    }
}
