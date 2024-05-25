import SwiftUI

struct ContentViewAlt: View {
    @State private var selectedFontName: String = "Times New Roman"
    @State private var isPresented: Bool = true
    
    
    var body: some View {
        
        VStack {
            FontSelectorView(selectedFontName: $selectedFontName)
            
            TabView {
                P73_DynamicTypeSize()
                    .tabItem {
                        Label("One", systemImage: "1.circle")
                    }
                
                FontWeightsPageView_Alt(selectedFontName: $selectedFontName)
                    .tabItem {
                        Label("Two", systemImage: "2.circle")
                    }
                
                FontFamiliesView(selectedFontName: $selectedFontName)
                    .tabItem {
                        Label("Three", systemImage: "3.circle")
                    }
                
                FontCharactersView_Alt2(selectedFontName: $selectedFontName)
                    .tabItem {
                        Label("Four", systemImage: "4.circle")
                    }
                
                TextStylePairingView(selectedFontName: $selectedFontName)
                    .tabItem {
                        Label("Five", systemImage: "5.circle")
                    }
                
                P180_FoldPaper()
                    .tabItem {
                        Label("Six", systemImage: "6.circle")
                    }
                
            }
        }
        .blur(radius: (isPresented) ? 0.75 : 0.0)
        .sheet(isPresented: $isPresented, content: {
            FontFamiliesView(selectedFontName: $selectedFontName)
                .foregroundColor(.primary)
                .shadow(color: .black, radius: 3)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 7))
                .offset(CGSize(width: 10.0, height: 100.0))
        })
    }
}

//
//  P73_DynamicTypeSize.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

#if os(iOS)
public struct P73Alt_DynamicTypeSize: View {
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize: DynamicTypeSize
    @State private var currentTypeSize: DynamicTypeSize = .xSmall
    let types: [DynamicTypeSize] = [.xSmall, .small, .medium, .large, .xLarge, .xxLarge, .xxxLarge, .accessibility1, .accessibility2, .accessibility3, .accessibility4, .accessibility5]
    
    public init() {}
    public var body: some View {

            VStack {
                HStack(alignment: .top, spacing: 8) {
                    VStack(alignment: .center) {
                        DynamicTypeSizeView()
                        Divider().frame(width: 44)
                        Text("Settings\n-> Display & Brightness\n-> Text Size")
                            .font(.caption)
                            .opacity(0.5)
                    }
                    Divider()
                    ScrollView {
                        VStack(alignment: .center) {
                            DynamicTypeSizeView()
                                .environment(\.dynamicTypeSize, currentTypeSize)
                        }
                    }
                }
//            }
                Picker("Dynamic Type Size", selection: $currentTypeSize) {
                    ForEach(types, id:\.self) { type in
                        Text(type.typeName())
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding(.bottom)
            }
    }
}

fileprivate
extension DynamicTypeSize {
    func typeName() -> String {
        switch self {
        case .xSmall: return "xSmall"
        case .small: return "small"
        case .medium: return "medium"
        case .large: return "large"
        case .xLarge: return "xLarge"
        case .xxLarge: return "xxLarge"
        case .xxxLarge: return "xxxLarge"
        case .accessibility1: return "accessibility1"
        case .accessibility2: return "accessibility2"
        case .accessibility3: return "accessibility3"
        case .accessibility4: return "accessibility4"
        case .accessibility5: return "accessibility5"
        default: return ""
        }
    }
}

fileprivate
struct DynamicTypeSizeView: View {
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize: DynamicTypeSize
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("." + dynamicTypeSize.typeName())
                .foregroundColor(Color.primary)
            VStack(alignment: .center, spacing: 8.0) {
                Group {
                    Text("largeTitle")
                        .font(.largeTitle)
                    Text("Title")
                        .font(.title)
                    Text("Title 2")
                        .font(.title2)
                    Text("Title 3")
                        .font(.title3)
                    Text("Headline")
                        .font(.headline)
                    Text("Subheadline")
                        .font(.subheadline)
                    Text("Body")
                        .font(.body)
                    Text("Callout")
                        .font(.callout)
                    Text("Footnote")
                        .font(.footnote)
                    Text("Caption")
                        .font(.caption)
                }
                Text("Caption 2")
                    .font(.caption2)
            }
        }
        .padding()
    }
}

#else
public struct P73_DynamicTypeSize: View {
    
    public init() {}
    public var body: some View {
        EmptyView()
    }
}
#endif

struct FontSizesView_Alt: View {
    @Binding var selectedFontName: String
    
    var body: some View {
        Group {
            List {
#if os(macOS)
                VStack(alignment: .leading) {
                    Text("Extra Large Title 2").font(.custom(selectedFontName, size: UIFont.preferredFont(forTextStyle: .extraLargeTitle2).pointSize))
                }
                
                VStack(alignment: .leading) {
                    Text("Extra Large Title").font(.custom(selectedFontName, size: UIFont.preferredFont(forTextStyle: .extraLargeTitle).pointSize))
                }
#endif
                VStack(alignment: .leading) {
                    Text("Large Title").font(.system(Font.TextStyle.largeTitle, design: Font.Design?.some(Font.Design.default), weight: Font.Weight?.some(Font.Weight.regular)))
                    Text("The size of the large title style.").font(.system(Font.TextStyle.body, design: Font.Design?.some(Font.Design.serif), weight: Font.Weight?.some(Font.Weight.regular)))
                    //                    Text("Large Title").font(.custom(selectedFontName, size: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize))/*.dynamicTypeSize(.accessibility1)*/
                }
                VStack(alignment: .leading) {
                    Text("Title 1").font(.custom(selectedFontName, size: UIFont.preferredFont(forTextStyle: .title1).pointSize))/*.dynamicTypeSize(.accessibility1)*/
                }
                VStack(alignment: .leading) {
                    Text("Title 2").font(.custom(selectedFontName, size: UIFont.preferredFont(forTextStyle: .title2).pointSize))
                    Text("The size of the Title 2 style").font(.custom(selectedFontName, size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                    /*.dynamicTypeSize(.accessibility1)*/
                }
                //                .lineSpacing(UIFont.preferredFont(forTextStyle: .footnote).lineHeight)
                VStack(alignment: .leading) {
                    Text("Title 3").font(.custom(selectedFontName, size: UIFont.preferredFont(forTextStyle: .title3).pointSize))/*.dynamicTypeSize(.accessibility1)*/
                }
                VStack(alignment: .leading) {
                    Text("Headline").font(.custom(selectedFontName, size: UIFont.preferredFont(forTextStyle: .headline).pointSize))/*.dynamicTypeSize(.accessibility1)*/
                }
                VStack(alignment: .leading) {
                    Text("Subheadline").font(.custom(selectedFontName, size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize))/*.dynamicTypeSize(.accessibility1)*/
                }
                Text("Body").font(.custom(selectedFontName, size: UIFont.preferredFont(forTextStyle: .body).pointSize))/*.dynamicTypeSize(.accessibility1)*/
                Text("Callout").font(.custom(selectedFontName, size: UIFont.preferredFont(forTextStyle: .callout).pointSize))/*.dynamicTypeSize(.accessibility1)*/
                Text("Caption 1").font(.custom(selectedFontName, size: UIFont.preferredFont(forTextStyle: .caption1).pointSize))/*.dynamicTypeSize(.accessibility1)*/
                Text("Caption 2").font(.custom(selectedFontName, size: UIFont.preferredFont(forTextStyle: .caption2).pointSize))/*.dynamicTypeSize(.accessibility1)*/
                Text("Footnote").font(.custom(selectedFontName, size: UIFont.preferredFont(forTextStyle: .footnote).pointSize))/*.dynamicTypeSize(.accessibility1)*/
            }
        }
    }
}

struct FontWeightsPageView_Alt: View {
    @Binding var selectedFontName: String
    @State private var currentPage = 0
    
    
    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(Array(UIFont.fontNames(forFamilyName: selectedFontName).enumerated()), id: \.element) { index, fontName in
                VStack(alignment: .leading) {
                    Text("\(fontName)")
                        .font(.custom(fontName, size: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize))
                        .foregroundStyle(.primary)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam.")
                        .font(.custom(fontName, size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                        .foregroundStyle(.secondary)
                }
                //                .dynamicTypeSize(DynamicTypeSize.xSm)
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct FontFamiliesView: View {
    @Binding var selectedFontName: String
    
    var body: some View {
        NavigationView {
            List {
                ForEach(UIFont.familyNames.sorted(), id: \.self) { familyName in
                    Section(header: Text(familyName).font(.headline)) {
                        ForEach(UIFont.fontNames(forFamilyName: familyName), id: \.self) { fontName in
                            Text(fontName)
                                .font(.custom(fontName, size: 16))
                                .onTapGesture {
                                    selectedFontName = fontName
                                }
                        }
                    }
                }
            }
            .navigationTitle("Font Families")
        }
    }
}

struct FontCharactersView_Alt: View {
    @Binding var selectedFontName: String
    @State private var selectedCharacter: Character? = nil
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(allCharacters(for: selectedFontName), id: \.self) { character in
                    Text(String(character))
                        .font(.custom(selectedFontName, size: selectedCharacter == character ? 48 : 24))
                        .frame(width: selectedCharacter == character ? 60 : 40, height: selectedCharacter == character ? 60 : 40)
                        .border(selectedCharacter == character ? Color.primary : Color.secondary)
                        .background(selectedCharacter == character ? .black : .clear)
                        .onTapGesture {
                            if selectedCharacter == character {
                                selectedCharacter = nil
                            } else {
                                selectedCharacter = character
                            }
                        }
                }
            }
            .foregroundStyle(.primary)
            //            .background(characterBackgroundColor)
            .padding()
        }
        .navigationTitle("Characters")
    }
    
    func allCharacters(for fontName: String) -> [Character] {
        var characters = [Character]()
        let font = UIFont(name: fontName, size: 12)!
        if let charSet = font.fontDescriptor.object(forKey: .characterSet) as? CharacterSet {
            for plane in 0...16 {
                let base = plane << 16
                for codePoint in base..<(base + 0xFFFF) {
                    if let scalar = UnicodeScalar(codePoint), charSet.contains(scalar) {
                        characters.append(Character(scalar))
                    }
                }
            }
        }
        return characters
    }
}

struct TextStylePairingView: View {
    @Binding var selectedFontName: String
    
    var body: some View {
        List {
            ForEach(textStylePairs, id: \.0) { headlineStyle, bodyStyle in
                Section/*(header: Text(headlineStyleName(for: headlineStyle)).font(.headline)) */{
                    VStack(alignment: .leading, spacing: 10) {
                        Text("\(headlineStyleName(for: headlineStyle))")
                            .font(.custom(selectedFontName, size: UIFont.preferredFont(forTextStyle: headlineStyle).pointSize)).lineSpacing(UIFont.preferredFont(forTextStyle: .body).lineHeight * 0.1618)
                        Text("\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam.")
                            .font(.custom(selectedFontName, size: UIFont.preferredFont(forTextStyle: .body).pointSize)).foregroundStyle(.secondary)
                        Text("\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam.")
                            .font(.custom(selectedFontName, size: UIFont.preferredFont(forTextStyle: .body).pointSize)).foregroundStyle(.secondary)
                    }
                    
                }
            }
            .navigationTitle("Text Style Pairings")
        }
    }
    
    var textStylePairs: [(UIFont.TextStyle, UIFont.TextStyle)] {
        return [
            //            (.headline, .body),
            (.largeTitle, .body),
            (.title1, .body),
            (.title2, .body),
            (.title3, .body)
        ]
    }
    
    func preferredFontSize(for textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    
    func headlineStyleName(for textStyle: UIFont.TextStyle) -> String {
        switch textStyle {
        case .headline: return "Headline"
        case .largeTitle: return "Large Title"
        case .title1: return "Title 1"
        case .title2: return "Title 2"
        case .title3: return "Title 3"
        default: return "Unknown"
        }
    }
}

struct FontSelectorView_Alt: View {
    @Binding var selectedFontName: String
    
    private let familyNames: [String] = {
        var allFontNames = [String]()
        for family in UIFont.familyNames {
            allFontNames.append(family)
        }
        return allFontNames
    }()
    
    var body: some View {
        Picker("Select Font", selection: $selectedFontName) {
            
            ForEach(Array(UIFont.familyNames.enumerated()), id: \.element) { index_a, familyName in
                Text(familyName).tag(index_a)
                    .font(.custom(familyName, fixedSize: UIFont.preferredFont(forTextStyle: .headline).pointSize))
                //                }
            }
        }
        .pickerStyle(MenuPickerStyle())
        .padding()
    }
}

struct ContentViewAlt_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewAlt()
    }
}
