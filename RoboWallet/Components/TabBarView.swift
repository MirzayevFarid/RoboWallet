import SwiftUI
import UIKit

struct TabBarView: View {

    @State var selectedTab = "Home"
    @Binding var pages: [TabBarPage]
    init(pages: Binding<[TabBarPage]>) {
        UITabBar.appearance().isHidden = true
        self._pages = pages
    }
    var body: some View {
        ZStack(alignment: .bottom) {

            TabView(selection: $selectedTab) {
                ForEach(pages) { item in
                    AnyView(_fromValue: item.page)
                        .tabItem{
                            EmptyView()
                        }.tag(item.tag)
                }
            }

            HStack {
                ForEach(pages) { item in
                    Button(action: {
                        self.selectedTab = item.tag
                    }) {
                        Image(systemName: item.icon)
                            .foregroundColor(self.selectedTab == item.tag ?  item.color : Color.gray )
                            .imageScale(.large)
                            .padding(7)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(20)
            .padding(.bottom, 5)
            .background(BlurredBackground().blur(radius: 8))
            .cornerRadius(40)


        }.ignoresSafeArea()

    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(pages: .constant([ TabBarPage(page: Home(), icon: "homekit", tag: "Home", color: .white),
                                      TabBarPage(page: Login(), icon: "chart.xyaxis.line", tag: "Analyze", color: .white),
                                      TabBarPage(page: SignUp(), icon: "bitcoinsign.circle", tag: "Profil", color: .white),
                                      TabBarPage(page: Home(), icon: "newspaper", tag: "News", color: .white),
                                      TabBarPage(page: Home(), icon: "person", tag: "Profile", color: .white)]))
            .preferredColorScheme(.dark)
    }
}

struct TabBarPage: Identifiable {
    var id = UUID()
    var page: Any
    var icon: String
    var tag: String
    var color: Color
}
