import SwiftUI

struct OnboardingView: View {
    let tabs: [OnboardingItem] = [OnboardingItem(image: Image.entriesTab,
                                                 title: "Entries Tab",
                                                 subtitle: "Track and Sort through your trades"),
                                  OnboardingItem(image: Image.statsTab,
                                                 title: "Stats Tab",
                                                 subtitle: "Get information about how you trade"),
                                  OnboardingItem(image: Image.calendarTab,
                                                 title: "Calendar Tab",
                                                 subtitle: "Visualize how you trade historically"),
                                  OnboardingItem(image: Image.moreTab,
                                                 title: "More Tab",
                                                 subtitle: "Everything else is here")]
    @State private var currentTab = 0
    let isOnboarding: Bool
    let onDismiss: () -> ()
    
    init(isOnboarding: Bool = true, onDismiss: @escaping () -> ()) {
        self.isOnboarding = isOnboarding
        self.onDismiss = onDismiss
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            skipSection()
            mainSection()
            nextButton()
        }
        .padding(20)
        .animation(.spring(), value: currentTab)
    }
    
    private func skipSection() -> some View {
        return HStack {
            if currentTab > 0 {
                Button {
                    if currentTab > 0 {
                        currentTab -= 1
                    }
                } label: {
                    Image(systemName: "arrow.backward")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.primary)
                }
            }
            Spacer()
            if currentTab < tabs.count - 1 {
                Button {
                    onDismiss()
                } label: {
                    Text("Skip")
                        .foregroundColor(.blue)
                }
            }
        }
    }
    
    private func nextButton() -> some View {
        return Button {
            if currentTab < tabs.count - 1 {
                currentTab += 1
            } else {
                onDismiss()
            }
        } label: {
            Text(currentTab < tabs.count - 1 ? "Next" : isOnboarding ? "Get Started" : "Done")
                .font(.system(size: 22, weight: .medium))
                .foregroundColor(.white)
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal, 24)
        }
    }
    
    private func mainSection() -> some View {
        return VStack(alignment: .center, spacing: 16) {
            ZStack(alignment: .center) {
                screenshot()
                
                GeometryReader { geoReader in
                    let scale: CGFloat = 2.0
                    let tabWidth: CGFloat = geoReader.size.width / 5
                    let circleSize: CGSize = CGSize(width: tabWidth,
                                                    height: tabWidth)
                    let numToAdd: CGFloat = currentTab > 1 ? 1.05 : 0
                    let currentTabNum: CGFloat = CGFloat(currentTab) + numToAdd
                    let tabOffset: CGFloat = (tabWidth / 1.5 * currentTabNum)
                    let tabX: CGFloat = geoReader.size.width / 2 - tabOffset - tabWidth * 1.15
                    screenshot()
                        .scaleEffect(scale, anchor: .center)
                        .zIndex(1)
                        .position(x: tabX + geoReader.size.width / 2,
                                  y: circleSize.height / 2)
                        .mask(
                            Circle()
                                .frame(width: circleSize.width,
                                       height: circleSize.height)
                                .position(x: geoReader.size.width / 2 - tabX,
                                          y: geoReader.size.height - circleSize.height)
                                .offset(CGSize(width: 0,
                                               height: circleSize.height / 1.5))
                        )
                        .contentShape(Circle().size(circleSize))
                        .shadow(color: Color.primary, radius: 4)
                }
                
            }
            .frame(maxWidth: .infinity)
            
            VStack(alignment: .center, spacing: 16) {
                Text(tabs[currentTab].title)
                    .font(.system(size: 26, weight: .semibold))
                Text(tabs[currentTab].subtitle)
                    .foregroundColor(.secondary)
                    .font(.system(size: 18, weight: .medium))
            }.padding(.vertical, 20)
        }
    }
    
    private func screenshot() -> some View {
        return tabs[currentTab].image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.8), lineWidth: 2)
            )
            .cornerRadius(12)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onDismiss: {})
    }
}
