import SwiftUI

struct ContentView: View {
    let festivalEmojis = ["👻", "🎃", "👻", "🎃", "😈", "😈", "👾", "👾"]
    let carEmojis = ["🚗", "🚗", "🚙", "🚙", "🚖", "🚖", "🚓", "🚓"]
    let professionEmojis = ["👮🏻‍♂️", "👮🏻‍♂️", "👷🏿‍♂️", "👷🏿‍♂️", "🕵🏻‍♀️", "🕵🏻‍♀️", "👩🏼‍🎨", "👩🏼‍🎨"]

    @State var emojis: [String] = ["👻", "🎃", "👻", "🎃", "😈", "😈", "👾", "👾"]

    var body: some View {
        VStack {
            Text("Memorize!!")
                .font(.largeTitle)
            ScrollView{
                cards
            }
            Spacer()
            themeChooser
        }
        .padding()
    }
    
    func themeButton(text: String, cardTheme: String, symbol: String) -> some View {
        Button(action: {
            switch cardTheme {
            case "festivals":
                emojis = festivalEmojis.shuffled()
            case "cars":
                emojis = carEmojis.shuffled()
            case "professions":
                emojis = professionEmojis.shuffled()
            default:
                emojis = []
                
            }
        }, label: {
            VStack {
                Image(systemName: symbol)
                    .imageScale(.large)
                Text(text)
            }
        })
    }
    

    var themeChooser: some View {
        HStack() {
            themeButton(text: "Festivals", cardTheme: "festivals", symbol: "american.football.professional")
            Spacer()
            themeButton(text: "Cars", cardTheme: "cars", symbol: "car")
            Spacer()
            themeButton(text: "Professions", cardTheme: "professions", symbol: "person.crop.circle")
        }
        .padding(.horizontal)
    }

    var cards: some View {
        LazyVGrid(columns:  [GridItem(.adaptive(minimum: 80))]) {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(.red)
    }
    

}

struct CardView: View {
    let content: String
    @State var isFaceUp = true

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
