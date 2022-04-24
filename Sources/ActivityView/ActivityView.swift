#if os(iOS)
import SwiftUI


internal extension UIWindow {
    @available(iOS 13, *)
    static var topViewController: UIViewController? {
        guard var topController = keyWindow?.rootViewController else {
            return nil
        }
        
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        
        return topController
    }
    
    @available(iOS 13, *)
    static var keyWindow: UIWindow? {
        if #available(iOS 15, *) {
            guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return nil
            }

            return scene.keyWindow
        } else {
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
                return nil
            }
            
            return window
        }
    }
}


@available(iOS 13, *)
internal struct ActivityView: ViewModifier {
    @Binding var isPresented: Bool
    
    var items: [Any]
    var excludedTypes: [UIActivity.ActivityType]? = nil
    
    func body(content: Content) -> some View {
        content
            .popover(isPresented: $isPresented) {
                Representable(items: items, excludedTypes: excludedTypes)
            }
    }
    
    private struct Representable: UIViewControllerRepresentable {
        var items: [Any]
        var excludedTypes: [UIActivity.ActivityType]? = nil
        
        func makeUIViewController(context: Context) -> UIActivityViewController {
            let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
            return controller
        }
        
        func updateUIViewController(_ controller: UIActivityViewController, context: Context) {
            controller.excludedActivityTypes = excludedTypes
        }
    }
}


extension View {
    /// A popover view that you use to offer standard services from your app.
    @available(swift, deprecated: 1.0.0, obsoleted: 2.0.0, message: "Use @Environment(\\.activityView) instead.")
    public func activityView(
        isPresented: Binding<Bool>,
        for items: [Any],
        without excludedTypes: [UIActivity.ActivityType]? = nil
    )
    -> some View {
        modifier(ActivityView(isPresented: isPresented, items: items, excludedTypes: excludedTypes))
    }
}


private struct ActivityViewKey: EnvironmentKey {
    static let defaultValue: (_ items: [Any], _ excludedTypes: [UIActivity.ActivityType]?) -> Void = { items , excludedTypes in
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        controller.excludedActivityTypes = excludedTypes
        UIWindow.topViewController?.present(controller, animated: true, completion: nil)
    }
}


extension EnvironmentValues {
    public var activityView: (_ items: [Any], _ excludedTypes: [UIActivity.ActivityType]?) -> Void {
        get { self[ActivityViewKey.self] }
        set { self[ActivityViewKey.self] = newValue }
    }
}

#endif
