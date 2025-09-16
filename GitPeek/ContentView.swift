//
//  ContentView.swift
//  GitPeek
//
//  Created by Abdullah Nana  on 2025/09/10.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = GitHubUserViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.accentColor.opacity(0.15), Color(.systemBackground)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack(spacing: 28) {
                Text(NSLocalizedString("app_title", comment: ""))
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(Color.accentColor)
                    .shadow(color: Color.accentColor.opacity(0.15), radius: 2, x: 0, y: 2)
                HStack {
                    TextField(NSLocalizedString("username_placeholder", comment: ""), text: $viewModel.username)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.accentColor.opacity(0.2), lineWidth: 1)
                        )
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    Button(action: {
                        Task {
                            await viewModel.fetchUser()
                        }
                    }) {
                        Label(NSLocalizedString("search_button", comment: ""), systemImage: "magnifyingglass")
                            .font(.headline)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(color: Color.accentColor.opacity(0.2), radius: 2, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
                if viewModel.isLoading {
                    ProgressView(NSLocalizedString("loading", comment: ""))
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.accentColor))
                        .scaleEffect(1.2)
                        .padding(.top, 20)
                }
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color(.systemRed).opacity(0.1))
                        .cornerRadius(10)
                        .transition(.opacity)
                }
                if let user = viewModel.user {
                    VStack(spacing: 18) {
                        AsyncImage(url: URL(string: user.avatar_url)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 110, height: 110)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.accentColor, lineWidth: 2))
                        .shadow(color: Color.accentColor.opacity(0.15), radius: 6, x: 0, y: 4)
                        Text(user.name ?? NSLocalizedString("no_name", comment: ""))
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.primary)
                        Text("@\(user.login)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        if let bio = user.bio {
                            Text(bio)
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                        }
                        HStack(spacing: 32) {
                            VStack {
                                Text(NSLocalizedString("repos", comment: ""))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("\(user.public_repos)")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(Color.accentColor)
                            }
                            VStack {
                                Text(NSLocalizedString("followers", comment: ""))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("\(user.followers)")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(Color.accentColor)
                            }
                        }
                        .frame(maxWidth: 220)
                    }
                    .padding(24)
                    .background(BlurView(style: .systemMaterial))
                    .cornerRadius(18)
                    .shadow(color: Color.accentColor.opacity(0.12), radius: 12, x: 0, y: 8)
                    .transition(.scale)
                }
                Spacer()
            }
            .padding(.top, 40)
            .padding(.horizontal)
            .animation(.easeInOut, value: viewModel.user)
        }
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
