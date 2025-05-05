//
//  Font+NY.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 03/05/25.
//

import Foundation
import SwiftUI

public extension SwiftUI.Font {
    
    static func typeWriterFont(size: CGFloat) -> Font {
        custom("TimesNewRomanPSMT", fixedSize: size)
    }
    
    static func typeWriterItalicFont(size: CGFloat) -> Font {
        custom("TimesNewRomanPS-ItalicMT", fixedSize: size)
    }
    
    static func typeWriterBoldFont(size: CGFloat) -> Font {
        custom("TimesNewRomanPS-BoldMT", fixedSize: size)
    }
    
    static func typeWriterBoldItalicFont(size: CGFloat) -> Font {
        custom("TimesNewRomanPS-BoldItalicMT", fixedSize: size)
    }
}
