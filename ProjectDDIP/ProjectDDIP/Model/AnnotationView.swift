//
//  AnnotationView.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/08/24.
//

import MapKit

class AnnotationMarkerView: MKMarkerAnnotationView {

    override var annotation: MKAnnotation? {
        willSet {
            guard let annotationObject = newValue as? AnnotationObject else { return }
                
            accessibilityIdentifier = "annotationMarker"
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)

            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 48, height: 48)))
            mapsButton.setBackgroundImage(#imageLiteral(resourceName: "Map"), for: .normal)
            rightCalloutAccessoryView = mapsButton
            
            markerTintColor = annotationObject.markerTintColor
            if let letter = annotationObject.discipline?.first { glyphText = String(letter) }
        }
    }
}

extension UIButton {
    
    public typealias UIButtonTargetClosure = (UIButton) -> ()
    
    private class UIButtonClosureWrapper: NSObject {
        let closure: UIButtonTargetClosure
        init(_ closure: @escaping UIButtonTargetClosure) {
            self.closure = closure
        }
    }
    
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    private var targetClosure: UIButtonTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIButtonClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set (newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, UIButtonClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }
    
    public func addAction(for event: UIButton.Event, closure: @escaping UIButtonTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(UIButton.closureAction), for: event)
    }
}
