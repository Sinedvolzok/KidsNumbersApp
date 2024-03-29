//
//  UIView+anchors.swift
//  Kids123
//
//  Created by Denis Kozlov on 12.05.2020.
//  Copyright © 2020 Denis Kozlov. All rights reserved.
//

import UIKit

enum Place {
    case topLeft
    case topRight
    case topCenter
    case bottomLeft
    case bottomRight
    case bottomCenter
    case center
}

extension Date {
    func days(to secondDate: Date, calendar: Calendar = Calendar.current) -> Int {
        return calendar.dateComponents([.day], from: self, to: secondDate).day! // Здесь force unwrap, так как в компонентах указали .day и берем day16092012
    }
}

extension Int {
    
    func cgFloat() -> CGFloat {
        return CGFloat(self)
    }
    
    func minutes() -> TimeInterval {
        return TimeInterval(self*60)
    }
    
    func hours() -> TimeInterval {
        return TimeInterval(self.minutes()*60)
    }
    
    func days() -> TimeInterval {
        return TimeInterval(self.hours()*24)
    }
}

extension Double {
    
    func cgFloat() -> CGFloat {
        return CGFloat(self)
    }
}

extension UIView {
    
    func flipX() {
        transform = CGAffineTransform(scaleX: -transform.a, y: transform.d)
    }

    /// Flip view vertically.
    func flipY() {
        transform = CGAffineTransform(scaleX: transform.a, y: -transform.d)
    }
    
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
    
    func animatePulse(fromValue: CGFloat, toValue: CGFloat, duration: Double) {
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        layer.add(animation, forKey: "pulsing")
    }
    
    func animateMoveJunp(fromValueX: CGFloat, fromValueY: CGFloat, toValueX: CGFloat, toValueY: CGFloat, delay: Double = 0, duration: Double, forKey: String) {
        
        let startPoint = [fromValueX, fromValueY]
        let movePoint = [toValueX, toValueY]
        
        let animation = CABasicAnimation(keyPath: "position")
        
        animation.fromValue = startPoint
        animation.toValue = movePoint
        animation.duration = duration
        animation.beginTime = CACurrentMediaTime() + delay
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        layer.add(animation, forKey: "jumping" + forKey)
    }
    
    func animateMove(fromX: CGFloat = 0, toX: CGFloat = 0, fromY: CGFloat = 0, toY: CGFloat = 0, duration: Double, delay: Double = 0, dumping: CGFloat, key: String = "animation") {
        
        let startPoint = [fromX, fromY]
        let movePoint = [toX, toY]
        
        let basicAnimationMove = CASpringAnimation(keyPath: "position")
        basicAnimationMove.damping = dumping
        basicAnimationMove.isAdditive = true
        basicAnimationMove.fromValue = startPoint
        basicAnimationMove.toValue = movePoint
        basicAnimationMove.duration = duration
        basicAnimationMove.beginTime = CACurrentMediaTime() + delay
        
        // stay opacity after animate
        basicAnimationMove.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        basicAnimationMove.fillMode = CAMediaTimingFillMode.forwards
        basicAnimationMove.isRemovedOnCompletion = false
        
        layer.add(basicAnimationMove, forKey: key)
    }
    
    func animateMoveY(to: CGFloat = 0, duration: Double, delay: Double = 0, dumping: CGFloat, key: String = "animation") {
        
        let basicAnimationMove = CASpringAnimation(keyPath: "transform.translation.y")
        basicAnimationMove.damping = dumping
        basicAnimationMove.isAdditive = true
        basicAnimationMove.toValue = to
        basicAnimationMove.duration = duration
        basicAnimationMove.beginTime = CACurrentMediaTime() + delay
        
        // stay opacity after animate
        basicAnimationMove.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        basicAnimationMove.fillMode = CAMediaTimingFillMode.forwards
        basicAnimationMove.isRemovedOnCompletion = false
        
        layer.add(basicAnimationMove, forKey: key)
    }
    
    func animateRotate(rotateAngle: Double, repeatCount: Float, duration: CFTimeInterval, dalay: Double, key: String) {
        
        let angleGradus = rotateAngle
        let angleRadians = CGFloat(angleGradus * Double.pi / 180)
        
        let basicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        basicAnimation.toValue = angleRadians
        basicAnimation.duration = duration
        basicAnimation.beginTime = CACurrentMediaTime() + dalay
        basicAnimation.repeatCount = repeatCount
        
        // stay opacity after animate
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.autoreverses = true
        basicAnimation.isCumulative = true
        
        layer.add(basicAnimation, forKey: key)
    }
    
    func animateOpacity(toValue: Double = 0.0, duration: CFTimeInterval, delay: Double, key: String) {
        
        let basicAnimation = CABasicAnimation(keyPath: "opacity")
        
        basicAnimation.toValue = toValue
        basicAnimation.duration = duration
        basicAnimation.beginTime = CACurrentMediaTime() + delay
        
        // stay opacity after animate
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        layer.add(basicAnimation, forKey: "AnimateOpacity" + key)
    }
    
    func animateDance() {
        
        let angleGradus = 15.0
        let angleRadians = CGFloat(angleGradus * Double.pi / 180)
        
        let moveY = CABasicAnimation(keyPath: "transform.translation.y")
        let rotate = CABasicAnimation(keyPath: "transform.rotation.z")
        
        rotate.beginTime = CACurrentMediaTime()
        rotate.fromValue = 0.0
        rotate.toValue = angleRadians
        rotate.duration = 1.0
        rotate.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        rotate.autoreverses = true
        rotate.repeatCount = Float.infinity
        
        moveY.beginTime = CACurrentMediaTime()
        moveY.fromValue = 0.0
        moveY.toValue = -20.0
        moveY.duration = 0.5
        moveY.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        moveY.autoreverses = true
        moveY.repeatCount = Float.infinity
        
        layer.add(moveY, forKey: "translationY")
        layer.add(rotate, forKey: "rotationZ")
    }
    
    func rotateTo(angle: Double) {
        let angleGradus = angle
        let angleRadians = CGFloat(angleGradus * Double.pi / 180)
        transform = CGAffineTransform(rotationAngle: angleRadians)
    }
    
    func scaleTo(x: CGFloat, y: CGFloat) {
        transform = CGAffineTransform(scaleX: x, y: y)
    }

    func moveTo(x: CGFloat = 0, y: CGFloat = 0) {
        layer.position = CGPoint(x: x, y: y)
    }
    
    func place(to: Place, placeY: CGFloat = 0, placeX: CGFloat = 0, size: CGSize) {
        
        let placeTo: Place = to
        
        var pozX: CGFloat
        var pozY: CGFloat
        
        guard let superviewHeight = superview?.frame.size.height else {return}
        guard let superviewWidth = superview?.frame.size.width else {return}
        
        switch placeTo {
            
        case .topRight:
            pozX = superviewWidth - placeX - size.width/2
            pozY = placeY + size.height/2
            
        case .topCenter:
            pozX = superviewWidth/2 + placeX
            pozY = placeY + size.height/2
            
        case .bottomLeft:
            pozX = placeX + size.width/2
            pozY = superviewHeight - placeY - size.height/2
            
        case .bottomRight:
            pozX = superviewWidth - placeX - size.width/2
            pozY = superviewHeight - placeY - size.height/2
            
        case .bottomCenter:
            pozX = superviewWidth/2 + placeX
            pozY = superviewHeight - placeY - size.height/2
            
        case .center:
            pozX = superviewWidth/2 + placeX
            pozY = superviewHeight/2 + placeY
            
        default:
            pozX = placeX + size.width/2
            pozY = placeY + size.height/2
        }
        
        frame.size = size
        
        layer.position = CGPoint(x: pozX, y: pozY)
        
    }
    
    func anchorFillToSuperview(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor, padding: .init(top: top, left: left, bottom: bottom, right: right))
    }
    
    func anchorToTopLeft(top: CGFloat = 0, left: CGFloat = 0, width: CGFloat = 1, height: CGFloat = 1) {
        anchor(top: superview?.topAnchor, left: superview?.leftAnchor, padding: .init(top: top, left: left, bottom: 0, right: 0), size: .init(width: width, height: height))
    }
    
    func anchorToTopLeading(top: CGFloat = 0, left: CGFloat = 0, width: CGFloat = 1, height: CGFloat = 1) {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, padding: .init(top: top, left: left, bottom: 0, right: 0), size: .init(width: width, height: height))
    }
    
    func anchorToTopRight(top: CGFloat = 0, right: CGFloat = 0, width: CGFloat = 1, height: CGFloat = 1) {
        anchor(top: superview?.topAnchor, right: superview?.rightAnchor, padding: .init(top: top, left: 0, bottom: 0, right: right), size: .init(width: width, height: height))
    }
    
    func anchorToTopTrailing(top: CGFloat = 0, right: CGFloat = 0, width: CGFloat = 1, height: CGFloat = 1) {
        anchor(top: superview?.topAnchor, trailing: superview?.trailingAnchor, padding: .init(top: top, left: 0, bottom: 0, right: right), size: .init(width: width, height: height))
    }
    
    func anchorToBottomLeft(bottom: CGFloat = 0, left: CGFloat = 0, width: CGFloat = 1, height: CGFloat = 1) {
        anchor(left: superview?.leftAnchor, bottom: superview?.bottomAnchor, padding: .init(top: 0, left: left, bottom: bottom, right: 0), size: .init(width: width, height: height))
    }
    
    func anchorToBottomLeading(bottom: CGFloat = 0, left: CGFloat = 0, width: CGFloat = 1, height: CGFloat = 1) {
        anchor(leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, padding: .init(top: 0, left: left, bottom: bottom, right: 0), size: .init(width: width, height: height))
    }
    
    func anchorToBottomRight(bottom: CGFloat = 0, right: CGFloat = 0, width: CGFloat = 1, height: CGFloat = 1) {
        anchor(bottom: superview?.bottomAnchor, right: superview?.rightAnchor, padding: .init(top: 0, left: 0, bottom: bottom, right: right), size: .init(width: width, height: height))
    }
    
    func anchorToBottomTrailing(bottom: CGFloat = 0, right: CGFloat = 0, width: CGFloat = 1, height: CGFloat = 1) {
        anchor(bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor, padding: .init(top: 0, left: 0, bottom: bottom, right: right), size: .init(width: width, height: height))
    }
    
    func anchorToTopCenter(top: CGFloat = 0, constantX: CGFloat = 0, width: CGFloat = 1, height: CGFloat = 1) {
        guard let superviewWidth = superview?.frame.size.width else {return}
        anchor(top: superview?.topAnchor, left: superview?.leftAnchor, padding: .init(top: top, left: superviewWidth/2+constantX-width/2, bottom: 0, right: 0), size: .init(width: width, height: height))
    }
    
    func anchorToBottomCenter(bottom: CGFloat = 0, constantX: CGFloat = 0, width: CGFloat = 1, height: CGFloat = 1) {
        guard let superviewWidth = superview?.frame.size.width else {return}
        anchor(left: superview?.leftAnchor, bottom: superview?.bottomAnchor, padding: .init(top: 0, left: superviewWidth/2+constantX-width/2, bottom: bottom, right: 0), size: .init(width: width, height: height))
    }
    
    func anchorToNativeCenter(constantY: CGFloat = 0, constantX: CGFloat = 0, width: CGFloat = 1, height: CGFloat = 1) {
        guard let superviewHeight = superview?.frame.size.height else {return}
        guard let superviewWidth = superview?.frame.size.width else {return}
        let nativeConstY = -superviewHeight*0.045
        anchor(top: superview?.topAnchor, left: superview?.leftAnchor, padding: .init(top: superviewHeight/2+nativeConstY+constantY-height/2, left: superviewWidth/2+constantX-width/2, bottom: 0, right: 0), size: .init(width: width, height: height))
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: padding.left).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -padding.right).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
    
}

extension CAGradientLayer {

    enum Point {
        case topLeft
        case centerLeft
        case bottomLeft
        case topCenter
        case center
        case bottomCenter
        case topRight
        case centerRight
        case bottomRight

        var point: CGPoint {
            switch self {
            case .topLeft:
                return CGPoint(x: 0, y: 0)
            case .centerLeft:
                return CGPoint(x: 0, y: 0.5)
            case .bottomLeft:
                return CGPoint(x: 0, y: 1.0)
            case .topCenter:
                return CGPoint(x: 0.5, y: 0)
            case .center:
                return CGPoint(x: 0.5, y: 0.5)
            case .bottomCenter:
                return CGPoint(x: 0.5, y: 1.0)
            case .topRight:
                return CGPoint(x: 1.0, y: 0.0)
            case .centerRight:
                return CGPoint(x: 1.0, y: 0.5)
            case .bottomRight:
                return CGPoint(x: 1.0, y: 1.0)
            }
        }
    }

    convenience init(start: Point, end: Point, colors: [CGColor], type: CAGradientLayerType) {
        self.init()
        self.startPoint = start.point
        self.endPoint = end.point
        self.colors = colors
        self.locations = (0..<colors.count).map(NSNumber.init)
        self.type = type
    }
}

extension CGPath {
    
    func reversedMutable() -> CGMutablePath {
        let reversedPath = CGMutablePath()
        let pointsReversed = getPathElementsPoints().reversed()
        guard let firstPoint = pointsReversed.first else {return reversedPath}
        reversedPath.move(to: firstPoint)
        pointsReversed.forEach{
            if $0 != firstPoint {
                reversedPath.addLine(to: $0)
            }
        }
        return reversedPath
    }
    
    func forEach( body: @escaping @convention(block) (CGPathElement) -> Void) {
        typealias Body = @convention(block) (CGPathElement) -> Void
        let callback: @convention(c) (UnsafeMutableRawPointer, UnsafePointer<CGPathElement>) -> Void = { (info, element) in
            let body = unsafeBitCast(info, to: Body.self)
            body(element.pointee)
        }
        //print(MemoryLayout.size(ofValue: body))
        let unsafeBody = unsafeBitCast(body, to: UnsafeMutableRawPointer.self)
        self.apply(info: unsafeBody, function: unsafeBitCast(callback, to: CGPathApplierFunction.self))
    }
    func getPathElementsPoints() -> [CGPoint] {
        var arrayPoints : [CGPoint]! = [CGPoint]()
        self.forEach { element in
            switch (element.type) {
            case CGPathElementType.moveToPoint:
                arrayPoints.append(element.points[0])
            case .addLineToPoint:
                arrayPoints.append(element.points[0])
            case .addQuadCurveToPoint:
                arrayPoints.append(element.points[0])
                arrayPoints.append(element.points[1])
            case .addCurveToPoint:
                arrayPoints.append(element.points[0])
                arrayPoints.append(element.points[1])
                arrayPoints.append(element.points[2])
            default: break
            }
        }
        return arrayPoints
    }
    func getPathElementsPointsAndTypes() -> ([CGPoint],[CGPathElementType]) {
        var arrayPoints : [CGPoint]! = [CGPoint]()
        var arrayTypes : [CGPathElementType]! = [CGPathElementType]()
        self.forEach { element in
            switch (element.type) {
            case CGPathElementType.moveToPoint:
                arrayPoints.append(element.points[0])
                arrayTypes.append(element.type)
            case .addLineToPoint:
                arrayPoints.append(element.points[0])
                arrayTypes.append(element.type)
            case .addQuadCurveToPoint:
                arrayPoints.append(element.points[0])
                arrayPoints.append(element.points[1])
                arrayTypes.append(element.type)
                arrayTypes.append(element.type)
            case .addCurveToPoint:
                arrayPoints.append(element.points[0])
                arrayPoints.append(element.points[1])
                arrayPoints.append(element.points[2])
                arrayTypes.append(element.type)
                arrayTypes.append(element.type)
                arrayTypes.append(element.type)
            default: break
            }
        }
        return (arrayPoints,arrayTypes)
    }
}
