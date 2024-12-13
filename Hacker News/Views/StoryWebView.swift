//
//  StoryView.swift
//  News
//
//  Created by Alexandre Fabri on 2021/09/24.
//

import SwiftUI

/// The View that display a WebView loading the story url.
/// A View to display a URL contents.
///
/// The properties are used to get the story url and display a progress bar when loading.
struct StoryWebView: View {
    
    /* Properties
     
        story           - The story received
        doneLoading     - To trigger the ProgressView visibility
        tabBarWidthSize - Our custom top bar size
     
     */
    @Binding var story: StoryModel?
    @State var doneLoading: Bool = false
    @State var topBarWidthSize: CGFloat = UIScreen.main.bounds.width
    @StateObject var browserViewModel = BrowserViewModel()

    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack(spacing: 0) {

                ZStack {
                    // Mocking a top bar to display the story title,
                    // a progress bar activity, and button to launch the story in the device's default browser
                    Color.yellow
                        .frame(width: geometry.size.width, height: 75)
                    
                    HStack {
                        Button(action: {
                            browserViewModel.goBack()
                        }) {
                            Image(systemName: "chevron.backward")
                        }
                        .foregroundColor(.indigo)
                        .disabled(!browserViewModel.canGoBack)

//                        Button(action: {
//                            browserViewModel.goForward()
//                        }) {
//                            Image(systemName: "chevron.forward")
//                        }
//                        .foregroundColor(.indigo)
//                        .disabled(!browserViewModel.canGoForward)

                        if let storyTitle = story?.title {
                            Text(storyTitle).padding(.leading)
                                .foregroundColor(.indigo)
                        }
                        Spacer()
                        Button(action: dismiss.callAsFunction){
                            Image(systemName: "xmark")
                        }
                        .foregroundColor(.indigo)
                                .padding([.leading,.trailing])
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .indigo))
                            .padding(.trailing, 3)
                            .opacity(doneLoading ? 0:1)
                        Button { //launch
                            if let strURL = story?.url, let url = URL(string: strURL)  {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            Image(systemName: "safari")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.indigo)
                        }
                        .padding(.trailing)
                    }
                }
                .frame(maxWidth:.infinity)
                // Custom in-browser view to load the story article
//                WebView(finished: $doneLoading, urlString: story?.url)
//                    .frame(maxWidth:.infinity)
                
                if let urlString = story?.url, let url = URL(string: urlString) {
                    BrowserWebView(url: url,
                                   viewModel: browserViewModel)
                    .edgesIgnoringSafeArea(.all)
                }
            }
            
        }
        .ignoresSafeArea()
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryWebView(story: .constant( StoryModel(id: 0, title: "Test Title", by: "ClawsOnPaws", time: 1000, score: 1632301218, url: "https://arstechnica.com/science/2021/09/braille-display-demo-refreshes-with-miniature-fireballs/")) )
    }
}
