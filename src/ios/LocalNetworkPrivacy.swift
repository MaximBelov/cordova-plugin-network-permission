// Credit to @iUrii

class LocalNetworkPrivacy : NSObject {
    /// How long the app has to have been active before a pending publish may be read as "declined".
    ///
    /// iOS raises its prompt when the publish starts and takes the app inactive behind it. The answer
    /// ("Allow") brings the app back, and the publish then finishes 0.2-0.35 s later. A 2 s tick that
    /// lands in that gap used to find "publishing, not yet published, app active" and say "declined" about
    /// a right that had just been granted. The tick now only counts time the app has spent
    /// ACTIVE since the publish began or the prompt was answered, and waits for the next one otherwise.
    static let settleAfterActive: TimeInterval = 1.0

    let service: NetService

    var completion: ((Bool) -> Void)?
    var timer: Timer?
    var publishing = false
    var activeSince = Date()
    var finished = false
    var observer: NSObjectProtocol?

    override init() {
        service = .init(domain: "local.", type:"_lnp._tcp.", name: "LocalNetworkPrivacy", port: 1100)
        super.init()
    }

    @objc
    func checkAccessState(completion: @escaping (Bool) -> Void) {
        self.completion = completion

        // The prompt answered: the app is back, and the publish needs its time before it can be judged.
        observer = NotificationCenter.default.addObserver(
            forName: UIApplication.didBecomeActiveNotification, object: nil, queue: .main
        ) { _ in
            self.activeSince = Date()
        }

        // Strong on purpose: LocalNetworkPermission creates this object without keeping it, so the timer's
        // capture is what keeps it alive until `finish` invalidates it and the observer is removed.
        timer = .scheduledTimer(withTimeInterval: 2, repeats: true, block: { timer in
            guard UIApplication.shared.applicationState == .active else {
                return
            }

            if self.publishing {
                // Not yet published after a tick: declined, but only once the app has been active long
                // enough for a publish that was about to succeed to have done so.
                if Date().timeIntervalSince(self.activeSince) < LocalNetworkPrivacy.settleAfterActive {
                    return
                }
                self.finish(false)
            }
            else {
                self.publishing = true
                self.activeSince = Date()
                self.service.delegate = self
                self.service.publish()
            }
        })
    }

    /// Answers once: a late `netServiceDidPublish` after "declined" must not answer a second time.
    func finish(_ granted: Bool) {
        guard !finished else { return }
        finished = true
        timer?.invalidate()
        timer = nil
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
            self.observer = nil
        }
        let completion = self.completion
        self.completion = nil
        service.stop()
        completion?(granted)
    }

    deinit {
        service.stop()
    }
}

extension LocalNetworkPrivacy : NetServiceDelegate {

    func netServiceDidPublish(_ sender: NetService) {
        finish(true)
    }
}
