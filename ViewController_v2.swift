import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    private var webView: WKWebView!
    private var errorView: UIView!
    private var reloadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController viewDidLoad called")
        
        // Setup WebView
        webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        // Setup Error View
        errorView = UIView(frame: view.bounds)
        errorView.backgroundColor = .white
        errorView.isHidden = true
        view.addSubview(errorView)
        
        let errorImage = UIImageView(image: UIImage(named: "sad"))
        errorImage.frame = CGRect(x: (view.bounds.width - 300) / 2, y: 200, width: 300, height: 300)
        errorView.addSubview(errorImage)
        
        let errorLabel = UILabel(frame: CGRect(x: 20, y: 500, width: view.bounds.width - 40, height: 50))
        errorLabel.text = "Failed to load page. Please try again."
        errorLabel.textAlignment = .center
        errorLabel.textColor = .black
        errorLabel.font = .systemFont(ofSize: 20)
        errorView.addSubview(errorLabel)
        
        reloadButton = UIButton(type: .custom)
        reloadButton.frame = CGRect(x: (view.bounds.width - 100) / 2, y: 560, width: 100, height: 50)
        if let reloadImage = UIImage(named: "failed1") {
            reloadButton.setImage(reloadImage, for: .normal)
        } else {
            reloadButton.setTitle("Actualiser", for: .normal) // Fallback
        }
        reloadButton.addTarget(self, action: #selector(reload), for: .touchUpInside)
        errorView.addSubview(reloadButton)
        
        // Load URL
        if let url = URL(string: "https://your-actual-domain.com") {
            print("Loading URL: \(url)")
            webView.load(URLRequest(url: url))
        } else {
            print("Invalid URL")
            errorView.isHidden = false
        }
    }
    
    @objc func reload() {
        print("Reloading...")
        errorView.isHidden = true
        webView.reload()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        errorView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        errorView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Failed to load: \(error.localizedDescription)")
        errorView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("Received server redirect")
    }
}
