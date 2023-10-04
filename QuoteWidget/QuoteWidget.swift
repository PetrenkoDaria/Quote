//
//  QuoteWidget.swift
//  QuoteWidget
//
//  Created by Дарья Петренко on 30.04.2023.
//

import WidgetKit
import SwiftUI
import Intents
import CoreData

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        do{
            let quote = try getQuoteData().randomElement()
            return SimpleEntry(date: Date(), configuration: ConfigurationIntent(), content: quote?.content ?? "It is the time you have wasted for your rose that makes your rose so important.", author: quote?.author ?? "Antoine de Saint-Exupéry")
        } catch{
            print(error)
            return SimpleEntry(date: Date(), configuration: ConfigurationIntent(), content: "It is the time you have wasted for your rose that makes your rose so important.", author: "Antoine de Saint-Exupéry")
           
        }
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        
        do{
            let quote = try getQuoteData().randomElement()
            let entry = SimpleEntry(date: Date(), configuration: ConfigurationIntent(), content: quote?.content ?? "It is the time you have wasted for your rose that makes your rose so important.", author: quote?.author ?? "Antoine de Saint-Exupéry")
            completion(entry)
        } catch{
            print(error)
        }
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 6 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            
            do{
                let quote = try getQuoteData().randomElement()
                let entry = SimpleEntry(date: Date(), configuration: ConfigurationIntent(), content: quote?.content ?? "It is the time you have wasted for your rose that makes your rose so important.", author: quote?.author ?? "Antoine de Saint-Exupéry")
                entries.append(entry)
            } catch{
                print(error)
            }
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    
    func getQuoteData() throws -> [FavoriteQuote] {
        let context = PersistenceController.shared.container.viewContext
        let request = FavoriteQuote.fetchRequest()
        let result = try context.fetch(request)
        return result
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let content: String
    let author: String
}

struct QuoteWidgetEntryView : View {
    var entry: Provider.Entry
    var randomNumber = Int.random(in: 1...9)
    
    @Environment(\.widgetFamily) var family
    
    var body: some View {

            switch family {
            case .systemSmall:
                systemSmallView
            case .systemMedium:
                systemMediumView
            default:
                systemMediumView
            }
        }
    //MARK: Small widget
    private var systemSmallView: some View {
            VStack {
               Text(entry.content)
                    .font(.system(.footnote, design: .rounded, weight: .bold))
                    .padding(2)
                
                HStack {
                    Spacer()
                    
                    Text(entry.author)
                        .font(.system(.caption2, design: .rounded, weight: .regular))
                        .italic()
                        .padding(2)
                }
            }.padding()
            .widgetBackground(
                ZStack{
                    Image("\(randomNumber)").resizable()
                    RoundedRectangle(cornerRadius: 2).foregroundStyle(.ultraThinMaterial)
                }
        )
    }
    
    //MARK: Medium widget
    private var systemMediumView: some View {
        VStack {
               Text(entry.content)
                    .font(.system(.body, design: .rounded, weight: .bold))
                    .lineLimit(5)
                    .minimumScaleFactor(0.5)
                    .padding(2)
                HStack {
                    Spacer()
                    
                    Text(entry.author)
                        .font(.system(.footnote, design: .rounded, weight: .regular))
                        .italic()
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .padding(2)
                }
            }
            .padding()
            .widgetBackground(
                ZStack{
                    Image("\(randomNumber)").resizable()
                    RoundedRectangle(cornerRadius: 2).foregroundStyle(.ultraThinMaterial)
                }
            )
    }

}

struct QuoteWidget: Widget {
    let kind: String = "QuoteWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            QuoteWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Quote widget")
        .description("Widget with favorite quotes.")
    }
}

struct QuoteWidget_Previews: PreviewProvider {
    static var previews: some View {
        QuoteWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), content: "It is the time you have wasted for your rose that makes your rose so important.", author: "Antoine de Saint-Exupéry"))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

extension View {
    func widgetBackground(_ backgroundView: some View) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            return containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            return background(backgroundView)
        }
    }
}
