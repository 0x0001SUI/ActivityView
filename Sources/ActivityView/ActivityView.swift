#if os(iOS)
import SwiftUI


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
    @available(iOS 13, *)
    public func activityView(
        isPresented: Binding<Bool>,
        for items: [Any],
        without excludedTypes: [UIActivity.ActivityType]? = nil)
    -> some View {
        modifier(ActivityView(isPresented: isPresented, items: items, excludedTypes: excludedTypes))
    }
}
#endif
