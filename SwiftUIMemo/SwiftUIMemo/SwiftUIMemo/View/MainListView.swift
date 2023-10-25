//
//  MainListView.swift
//  SwiftUIMemo
//
//  Created by Saemi Park on 2023-10-24.
//

import SwiftUI

struct MainListView: View {
    @EnvironmentObject var store: MemoStore
    
    @State private var showComposer: Bool = false
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.list){ memo in
                    NavigationLink{
                        DetailView(memo: memo)
                    } label : {
                        MemoCell(memo: memo)
                    }
                    
                }
                .onDelete(perform: store.delete)
            
            }
                .navigationTitle("My Memo")
                .toolbar {
                    Button {
                        showComposer = true
                    }label: {
                        Image(systemName: "plus")
                    }
                    
                }
                .sheet(isPresented: $showComposer){
                    ComposeView()
            }
        }
        .navigationViewStyle(.stack)
           
    }
        
        
}

#Preview {
    MainListView()
        .environmentObject(MemoStore())
}
