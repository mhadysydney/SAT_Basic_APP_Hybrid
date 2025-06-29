import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set view background to confirm visibility
        view.backgroundColor = .white
        
        // Initialize WKWebView
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = .white
        webView.isOpaque = false
        view.addSubview(webView)
        
        // Ensure WebView is in front
        view.bringSubviewToFront(webView)
        
        // Constraints
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        // Load URL
        let urlString = "https://apple.com" // Replace with your URL
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
            print("Loading URL: \(urlString)")
        } else {
            print("Invalid URL: \(urlString)")
            let alert = UIAlertController(title: "Error", message: "Invalid URL", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
        
        // Loading indicator with timeout
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        // Hide indicator after 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.view.subviews.forEach { if $0 is UIActivityIndicatorView { $0.removeFromSuperview() } }
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Started loading: \(webView.url?.absoluteString ?? "unknown")")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("WebView finished loading: \(webView.url?.absoluteString ?? "unknown")")
        view.subviews.forEach { if $0 is UIActivityIndicatorView { $0.removeFromSuperview() } }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Failed to load: \(error.localizedDescription)")
        let alert = UIAlertController(title: "Error", message: "Failed to load webpage: \(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Navigation failed: \(error.localizedDescription)")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("Navigation action: \(navigationAction.request.url?.absoluteString ?? "unknown")")
        if navigationAction.navigationType == .linkActivated {
            if let url = navigationAction.request.url {
                webView.load(URLRequest(url: url))
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        } else {
            decisionHandler(.allow)
        }
    }
}