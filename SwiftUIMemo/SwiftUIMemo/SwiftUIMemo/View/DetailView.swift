//
//  DetailView.swift
//  SwiftUIMemo
//
//  Created by Saemi Park on 2023-10-24.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var memo: Memo
    
    @EnvironmentObject var store: MemoStore
    
    @State private var showComposer = false
    
    @State private var showDeleteAlert = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ScrollView{
                VStack {
                    HStack {
                        Text(memo.content)
                            .padding()
                        
                        Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                    }
                    
                    Text(memo.insertDate, style: .date)
                        .padding()
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Memo")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar){
                Button{
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                }
                .foregroundColor(.red)
                .alert("Confirm Delete", isPresented: $showDeleteAlert){
                    Button(role: .destructive){
                        store.delete(memo: memo)
                        dismiss()
                    }label: {
                        Text("Delete")
                    }
                } message :{
                    Text("Do you want to delete memo?")
                }
                
                Button{
                    showComposer = true
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showComposer){
            ComposeView(memo: memo)
        }
    }
}

#Preview {
    NavigationView {
        DetailView(memo: Memo(content: "Hello"))
            .environmentObject(MemoStore())
    }
}
