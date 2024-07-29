//
//  FeedRowView.swift
//  EatCook
//
//  Created by 이명진 on 2/17/24.
//

import SwiftUI

struct FeedRowView: View {
    @State private var isExpended: Bool = false
    @EnvironmentObject private var naviPathFinder: NavigationPathFinder
    var cookTalkFeedData: CookTalkFeedResponseList
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let imageUrl = URL(string: "\(Environment.AwsBaseURL)/\(cookTalkFeedData.postImagePath)") {
                ZStack(alignment: .bottomTrailing) {
                    AsyncImage(url: imageUrl) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 196)
//                                .aspectRatio(contentMode: .fit)
                        case .success(let image):
                            image
                                .resizable()
                                .frame(maxWidth: .infinity)
                                .aspectRatio(4/3, contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        case .failure:
                            LoadFailImageView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    HStack(spacing: 4) {
                        Text("\(cookTalkFeedData.likeCount)")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.white)
                        
                        Image(systemName: cookTalkFeedData.followCheck ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .scaledToFit()
                            .foregroundStyle(cookTalkFeedData.followCheck ? Color.red : Color.white)
                    }
                    .padding(.trailing, 12)
                    .padding(.bottom, 12)
                }
                .frame(maxWidth: .infinity)
                
            }
//            RoundedRectangle(cornerRadius: 10)
//                .frame(width: 311, height: 196)
//                .foregroundStyle(.gray4)
            if let imageUrl = URL(string: "\(Environment.AwsBaseURL)/\(cookTalkFeedData.profile ?? "")") {
                HStack(spacing: 8) {
                    AsyncImage(url: imageUrl) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 25, height: 25)
                        case .success(let image):
                            image
                                .resizable()
                                .frame(width: 25, height: 25)
                                .clipShape(Circle())
                        case .failure:
                            EmptyProfileImageView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    Text(cookTalkFeedData.nickName)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.gray9)
                }
            }
            
            HStack(alignment: .top, spacing: 8) {
                Text(cookTalkFeedData.introduction)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.gray8)
                    .lineLimit(isExpended ? nil : 3)
                    .lineSpacing(4)
                    .multilineTextAlignment(.leading)
                
                if !isExpended {
                    Button {
                        isExpended.toggle()
                    } label: {
                        Text("더 보기")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.gray6)
                    }
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 28)
            .padding(.top, -10)
            
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 10, y: 5)
        }
        .onTapGesture {
            naviPathFinder.addPath(.recipeDetail(cookTalkFeedData.postID))
        }
    }
}

#Preview {
    FeedView()
}
