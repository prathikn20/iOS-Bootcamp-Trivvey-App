import Foundation
import UIKit
import SwiftUI

struct ContentView: View {
		// store questions
    @State private var questions: [TriviaQuestion] = []
    
    
    var body: some View {
        NavigationStack {
            List (questions, id: \.question){ trivia in
                // Add NavigationLink to QuestionView for each question
                NavigationLink(destination: QuestionView(question: trivia)) {
                    Text(trivia.question)
                }
            }
            .listStyle(.insetGrouped)
            // Add navigationTitle
            // Add shuffle button in toolbar
            .navigationTitle("Trivvey")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button() {
                        withAnimation(){
                            shuffle()
                        }
                    } label: {
                        Image(systemName: "shuffle")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.primary)
                            .frame(width: 36, height: 36)
                    }
            }
        }
            .onAppear {
                loadQuestions()
            }
        }
    }
    func loadQuestions() {
            guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else {
                print("Error: Could not find questions.json")
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                questions = try JSONDecoder().decode([TriviaQuestion].self, from: data)
            } catch {
                print("Error loading questions: \(error)")
        }
    }
    
    func shuffle() {
        questions.shuffle()
    }
}
#Preview {
    ContentView()
}
