import SwiftUI

public struct P180_FoldPaper: View {
    
    @State private var datas = [TreeItem]()
    
    public init() {}
    public var body: some View {
        ZStack {
            FoldPaper(items: $datas)
                .padding()
        }
        .onAppear {
            DispatchQueue.main.async {
                datas = UIFont.familyNames.sorted().map { familyName in
                    TreeItem(
                        title: familyName,
                        depth: 0,
                        font: Font.custom(familyName, size: UIFont.preferredFont(forTextStyle: .body).pointSize),
                        children: UIFont.fontNames(forFamilyName: familyName).map { fontName in
                            TreeItem(title: fontName, depth: 1, font: Font.custom(fontName, size: UIFont.preferredFont(forTextStyle: .body).pointSize), children: nil)
                        }
                    )
                }
            }
        }
    }
}

fileprivate
extension Color {
    init(hex: UInt) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: 1.0
        )
    }
}

fileprivate
struct TreeItem: Hashable, Identifiable {
    var id: Self { self }
    var title: String
    var depth: Int
    var font: Font
    var children: [TreeItem]? = nil
}

fileprivate
struct RowView: View {
    let colors = [Color.init(uiColor: UIColor.quaternarySystemFill), Color.init(uiColor: UIColor.tertiarySystemGroupedBackground)] //[Color(hex: 0xC4321C), Color(hex: 0xEB6E3B), Color(hex: 0xF4A96B), Color(hex: 0xF3D6A9)]
    let item: TreeItem
    let index : Int
    @Binding var isExpanded: Bool
    @Binding var isUnfold: Bool
    @State private var isUnfoldParent: Bool = false
    let rowHeight: CGFloat = 80
    
    var rowContent: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(colors[item.depth])
            HStack {
                VStack {
                    HStack {
                        if item.children != nil {
                            Image(systemName: "chevron.right")
                                .rotationEffect(Angle(degrees: isExpanded ? 90 : 0))
                              
                        }
//                        Image(systemName: item.depth == 0 ? "arrow.turn.left.down" : "arrow.turn.down.right")
                        Text(item.title)
                            .font(item.font)
                          .padding(.leading)
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Text("row description")
                            .font(.caption)
                            .opacity(0.5)
                        Spacer()
                    }
                    .redacted(reason: .placeholder)
                    Spacer()
                }
                .padding(.leading)
                .padding(.top)
                .padding(.leading, CGFloat(item.depth) * 20)
//                Spacer()
//                if item.children != nil {
//                    Image(systemName: "chevron.down")
//                        .rotationEffect(Angle(degrees: isExpanded ? -180 : 0))
//                        .padding(.trailing)
//                    }
            }
        }
        .frame(height: rowHeight)
        .clipped()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            rowContent
                .overlay(
                    LinearGradient(colors: [Color.black.opacity(0.8), Color.black.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .opacity(isUnfold ? 0 : 1)
                )
                .rotation3DEffect(Angle(degrees: -90 * (isUnfold ? 0 : 1)), axis: (x: 1, y: 0, z: 0), anchor: .top)
                .frame(height: isUnfold ? rowHeight * 0.5 : 0, alignment: .top)
                .clipShape(Rectangle())
            
            rowContent
                .overlay(
                    LinearGradient(colors: [Color.black.opacity(0.4), Color.black.opacity(0.3)], startPoint: .bottomTrailing, endPoint: .topLeading)
                        .opacity(isUnfold ? 0 : 1)
                )
                .rotation3DEffect(Angle(degrees: 90 * (isUnfold ? 0 : 1)), axis: (x: 1, y: 0, z: 0), anchor: .bottom)
                .frame(height: isUnfold ? rowHeight * 0.5 : 0, alignment: .bottom)
                .clipShape(Rectangle())
            
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                isExpanded.toggle()
                isUnfoldParent = false
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isUnfold = true
                }
            }
        }
        
        if item.children != nil {
            ZStack {
                if isExpanded {
                    VStack(spacing: 0) {
                        ForEach(Array(item.children!.enumerated()), id: \.offset) { index, item in
                            ItemView(item: item, index: index, isUnfold: $isUnfoldParent)
                        }
                    }
                    .onDisappear {
                        isUnfoldParent = false
                    }
                }
            }
        }
    }
}

fileprivate
struct ItemView: View {
    
    let item: TreeItem
    let index: Int
    @State private var isExpanded: Bool = false
    @Binding var isUnfold: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            RowView(item: item, index: index, isExpanded: $isExpanded, isUnfold: $isUnfold)
        }
    }
}

fileprivate
struct FoldPaper: View {
    
    @Binding var items: [TreeItem]
    @State private var isUnfold: Bool = true
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    ItemView(item: item, index: index, isUnfold: $isUnfold)
                }
            }
            .clipShape(Rectangle())
        }
    }
}

struct P180_FoldPaper_Previews: PreviewProvider {
    static var previews: some View {
        P180_FoldPaper()
    }
}
