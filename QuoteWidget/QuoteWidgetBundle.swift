//
//  QuoteWidgetBundle.swift
//  QuoteWidget
//
//  Created by Дарья Петренко on 30.04.2023.
//

import WidgetKit
import SwiftUI

@main
struct QuoteWidgetBundle: WidgetBundle {
    var body: some Widget {
        QuoteWidget()
        QuoteWidgetLiveActivity()
    }
}
