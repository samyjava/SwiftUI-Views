//
//  SegmentedControlView.swift
//
//  Created by Sam Javadizadeh on 2/27/21.
//

import SwiftUI

struct SegmentedControlView: View {
    
    let segmentsTitle: [String]
    let selectionColor: Color
    @Binding var selectedIndex: Int
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(segmentsTitle, id: \.self) { title in
                    if let currentIndex = segmentsTitle.firstIndex(of: title) {
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .shadow(radius: 10)
                                .foregroundColor(currentIndex == selectedIndex ? selectionColor : .clear)
                            Text(title)
                                .font(.callout)
                                .foregroundColor(currentIndex == selectedIndex ? ColorPalette.whiteColor : ColorPalette.addIntBody)
                                .onTapGesture {
                                    withAnimation {
                                        selectedIndex = currentIndex
                                    }
                                }
                        }
                        
                        
                        if currentIndex != segmentsTitle.count - 1 {
                            Text("|")
                                .foregroundColor(hasDivider(currentIndex: currentIndex, selectedIndex: selectedIndex) ? ColorPalette.addIntTitle : .clear)
                        }
                    }
                    
                }
            }
        }
        
    }
    func hasDivider(currentIndex: Int, selectedIndex: Int) -> Bool {
        var hasDivider = true
        if selectedIndex == currentIndex || currentIndex + 1 == selectedIndex {
            hasDivider = false
        }
        return hasDivider
    }
}

struct CustomPickerView_Previews: PreviewProvider {
    @State static var selectedIndex: Int = 1
    static var previews: some View {
        Group {
            SegmentedControlView(segmentsTitle: ["Home", "Apply" , "yechizis"], selectionColor: ColorPalette.applyDetailInterview,selectedIndex: $selectedIndex)
                .previewLayout(.sizeThatFits)
                .frame(width: 400, height: 32)
                .padding()
            
            SegmentSelection()
                .previewLayout(.sizeThatFits)
                .frame(width: 100, height: 70)
                .padding()
        }
    }
}

