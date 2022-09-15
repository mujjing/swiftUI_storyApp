//
//  Home.swift
//

import SwiftUI

struct Home: View {
    
    @State var index: Int = 0
    @State var stories = [
        Story(id: 0, image: "1", offset: 0, title: "이것은 죠르디 이미지 1 입니다"),
        Story(id: 1, image: "2", offset: 0, title: "이것은 죠르디 이미지 2 입니다"),
        Story(id: 2, image: "3", offset: 0, title: "이것은 죠르디 이미지 3 입니다"),
        Story(id: 3, image: "4", offset: 0, title: "이것은 죠르디 이미지 4 입니다")
    ]
    @State var scrolled = 0
    @State var index1 = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                header
                content
                belowHeader
                belowContent
            }
        }
        .background(
            LinearGradient(gradient: .init(colors: [Color.blue, Color.green]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }
    
    func calculateWidth() -> CGFloat {
        // horizontal padding 50
        let screen = UIScreen.main.bounds.width - 50
        
        // going to show first three cards
        // all other will be hidden
        
        // second and third will be moved x axis with 30 value
        let width = screen - (2 * 30)
        
        return width
    }
}

extension Home {
    @ViewBuilder
    private var header: some View {
        HStack {
            Button {
                
            } label: {
                Image(systemName: "menucard")
                    .renderingMode(.template)
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "magnifyingglass")
                    .renderingMode(.template)
                    .foregroundColor(.white)
            }


        }
        .padding()
        
        HStack {
            Text("죠르디 카드")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)
            
            Spacer(minLength: 0)
            
            Button {
                
            } label: {
                Image("dots")
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .rotationEffect(.init(degrees: 90))
            }

        }
        .padding(.horizontal)
        
        HStack {
            Text("Animated")
                .font(.system(size: 15))
                .foregroundColor(index == 0 ? .white : Color.orange.opacity(0.85))
                .fontWeight(.bold)
                .padding(.vertical, 6)
                .padding(.horizontal, 20)
                .background(Color.yellow.opacity(index == 0 ? 1 : 0))
                .clipShape(Capsule())
                .onTapGesture {
                    index = 0
                }
            
            Text("\(stories.count)+ Series")
                .font(.caption)
                .foregroundColor(index == 1 ? .white : Color.orange.opacity(0.85))
                .fontWeight(.bold)
                .padding(.vertical, 6)
                .padding(.horizontal, 20)
                .background(Color.yellow.opacity(index == 1 ? 1 : 0))
                .clipShape(Capsule())
                .onTapGesture {
                    index = 1
                }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
    
    private var content: some View {
        ZStack {
            ForEach(stories.reversed()) { story in
                HStack {
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                        Image(story.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        // dynamic frame
                        // dynamic height
                            .frame(width: calculateWidth(), height: (UIScreen.main.bounds.height / 1.8) - CGFloat(story.id - scrolled) * 50)
                            .cornerRadius(15)
                        
                        CardViewButton(title: story.title, calWidth: calculateWidth())
                    }
                    // based on scrolled changing view size
                    .offset(x: story.id - scrolled <= 2 ? CGFloat(story.id - scrolled) * 30 : 60)
                    Spacer(minLength: 0)
                }
                .contentShape(Rectangle())
                .offset(x: story.offset)
                .gesture(DragGesture().onChanged({ value in
                    withAnimation {
                        //disabled drag for last card
                        if value.translation.width < 0 && story.id != stories.last!.id {
                            stories[story.id].offset = value.translation.width
                        } else {
                            // restoring cards
                            if story.id > 0 {
                                stories[story.id - 1].offset = -(calculateWidth() + 60) + value.translation.width
                            }
                        }
                    }
                }).onEnded({ value in
                    withAnimation {
                        
                        if value.translation.width < 0 {
                            if -value.translation.width > 180 && story.id != stories.last!.id {
                                //moving view away
                                stories[story.id].offset = -(calculateWidth() + 60)
                                
                                scrolled += 1
                                
                            } else {
                                stories[story.id].offset = 0
                            }
                        } else {
                            // restoring card
                            if story.id > 0 {
                                if value.translation.width > 180 {
                                    stories[story.id - 1].offset = 0
                                    scrolled -= 1
                                } else {
                                    stories[story.id - 1].offset = -(calculateWidth() + 60)
                                }
                            }
                        }
                    }
                }))
            }
        }
        // max height
        .frame(height: UIScreen.main.bounds.height / 1.8)
        .padding(.horizontal, 25)
        .padding(.top, 25)
    }
    
    @ViewBuilder
    private var belowHeader: some View {
        HStack {
            Text("맘에드는 카드")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)
            
            Spacer(minLength: 0)
            
            Button {
                
            } label: {
                Image("dots")
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .rotationEffect(.init(degrees: 90))
            }

        }
        .padding(.horizontal)
        .padding(.top, 25)
        
        HStack {
            Text("Latest")
                .font(.system(size: 15))
                .foregroundColor(index1 == 0 ? .white : Color.orange.opacity(0.85))
                .fontWeight(.bold)
                .padding(.vertical, 6)
                .padding(.horizontal, 20)
                .background(Color.yellow.opacity(index1 == 0 ? 1 : 0))
                .clipShape(Capsule())
                .onTapGesture {
                    index1 = 0
                }
            
            Text("1+ Series")
                .font(.caption)
                .foregroundColor(index1 == 1 ? .white : Color.orange.opacity(0.85))
                .fontWeight(.bold)
                .padding(.vertical, 6)
                .padding(.horizontal, 20)
                .background(Color.yellow.opacity(index1 == 1 ? 1 : 0))
                .clipShape(Capsule())
                .onTapGesture {
                    index1 = 1
                }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
    
    private var belowContent: some View {
        HStack {
            Image("1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width - 80, height: 250)
                .cornerRadius(15)
            
            Spacer(minLength: 0)
        }
        .padding(.horizontal)
        .padding(.top, 20)
        .padding(.bottom)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
