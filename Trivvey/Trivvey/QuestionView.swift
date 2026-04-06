//
//  QuestionView.swift
//  
//
//  Created by Prathik Nekkanti on 4/5/26.
//

import SwiftUI

struct QuestionView: View {
    let question: TriviaQuestion
    
    @State private var selectedAnswer: String? = nil
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text(question.question)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 20)
                .padding(.horizontal)
            
            VStack(spacing: 16) {
                OptionRow(letter: "A", text: question.A, correctAnswer: question.answer, selectedAnswer: $selectedAnswer)
                OptionRow(letter: "B", text: question.B, correctAnswer: question.answer, selectedAnswer: $selectedAnswer)
                OptionRow(letter: "C", text: question.C, correctAnswer: question.answer, selectedAnswer: $selectedAnswer)
                OptionRow(letter: "D", text: question.D, correctAnswer: question.answer, selectedAnswer: $selectedAnswer)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("Question")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct OptionRow: View {
    let letter: String
    let text: String
    let correctAnswer: String
    @Binding var selectedAnswer: String?
    
    var isCorrect: Bool { letter == correctAnswer }
    var isSelected: Bool { letter == selectedAnswer }
    var hasAnswered: Bool { selectedAnswer != nil }
    
    var body: some View {
        Button {
            if selectedAnswer == nil {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                    selectedAnswer = letter
                }
            }
        } label: {
            HStack(spacing: 16) {
                Text(letter)
                    .font(.headline)
                    .foregroundColor(circleTextColor)
                    .frame(width: 40, height: 40)
                    .background(
                        Circle()
                            .fill(circleBackgroundColor)
                    )
                
                Text(text)
                    .font(.body)
                    .foregroundColor(.primary)
                
                Spacer()
                

                if hasAnswered {
                    if isCorrect {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.title2)
                    } else if isSelected {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                            .font(.title2)
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(borderColor, lineWidth: 1.5)
            )
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(rowBackgroundColor)
            )
        }
        .disabled(hasAnswered)
    }
    
    
    private var circleTextColor: Color {
        if hasAnswered {
            if isCorrect || isSelected { return .white }
            return .gray
        }
        return .blue
    }
    
    private var circleBackgroundColor: Color {
        if hasAnswered {
            if isCorrect { return .green }
            if isSelected { return .red }
            return Color.gray.opacity(0.1)
        }
        return Color.blue.opacity(0.1)
    }
    
    private var borderColor: Color {
        if hasAnswered {
            if isCorrect { return .green }
            if isSelected { return .red }
            return Color.gray.opacity(0.2)
        }
        return Color.gray.opacity(0.2)
    }
    
    private var rowBackgroundColor: Color {
        if hasAnswered {
            if isCorrect { return Color.green.opacity(0.1) }
            if isSelected { return Color.red.opacity(0.1) }
            return Color.clear
        }
        return Color.clear
    }
}

#Preview {
    NavigationStack {
        QuestionView(question: TriviaQuestion(
            question: "A flashing red traffic light signifies that a driver should do what?",
            A: "stop",
            B: "speed up",
            C: "proceed with caution",
            D: "honk the horn",
            answer: "A"
        ))
    }
}
