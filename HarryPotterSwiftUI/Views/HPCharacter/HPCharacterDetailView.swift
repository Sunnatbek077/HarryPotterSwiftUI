//
//  HPCharacterDetailView.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 03/08/25.
//

import SwiftUI

struct HPCharacterDetailView: View {
    let character: HPCharacter
    var body: some View {
        ScrollView(showsIndicators: false) {
            AsyncImage(url: URL(string: character.attributes.image ?? "")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .padding()
                default:
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
            }
            DetailRow(title: "Name", value: character.attributes.name)
            DetailRow(title: "Born", value: character.attributes.born ?? "Unknown")
            DetailRow(title: "Gender", value: character.attributes.gender ?? "Unknown")
            DetailRow(title: "Species", value: character.attributes.species ?? "Unknown")
            DetailRow(title: "Nationality", value: character.attributes.nationality ?? "Unknown")
            DetailRow(title: "Marital Status", value: character.attributes.marital_status ?? "Unknown")
            DetailRow(title: "Blood Status", value: character.attributes.blood_status ?? "Unknown")
            DetailRow(title: "House", value: character.attributes.house ?? "Unknown")
            DetailRow(title: "Eye Color", value: character.attributes.eye_color ?? "Unknown")
            DetailRow(title: "Hair Color", value: character.attributes.hair_color ?? "Unknown")
            DetailRow(title: "Boggart", value: character.attributes.boggart ?? "Unknown")
            DetailRow(title: "Patronus", value: character.attributes.patronus ?? "Unknown")
            DetailArrayRow(title: "Alias Names", values: character.attributes.alias_names ?? []) 
            DetailArrayRow(title: "Family Members", values: character.attributes.family_members ?? [])
            DetailArrayRow(title: "Jobs", values: character.attributes.jobs ?? [])
            DetailArrayRow(title: "Romances", values: character.attributes.romances ?? [])
            DetailArrayRow(title: "Titles", values: character.attributes.titles ?? [])
            DetailArrayRow(title: "Wands", values: character.attributes.wands ?? [])
        }
        
        
    }
}

struct DetailRow: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title + ":")
                .fontWeight(.semibold)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
}

struct DetailArrayRow: View {
    let title: String
    let values: [String]
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(title)
                    .fontWeight(.semibold)
                Spacer()
                if values.count > 1 {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .animation(.spring(response: 0.25, dampingFraction: 0.8), value: isExpanded)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if values.count > 1 {
                    withAnimation(.spring(response: 0.25, dampingFraction: 0.85)) {
                        isExpanded.toggle()
                    }
                }
            }
            
            if values.isEmpty {
                Text("Unknown")
                    .foregroundColor(.secondary)
            } else {
                if values.count == 1 {
                    Text("• \(values.first!)")
                        .foregroundColor(.secondary)
                } else {
                    if isExpanded {
                        ForEach(values, id: \.self) { item in
                            Text("• \(item)")
                                .foregroundColor(.secondary)
                                .transition(.opacity.combined(with: .move(edge: .top)))
                                .animation(.spring(response: 0.3, dampingFraction: 0.85), value: isExpanded)
                        }
                    } else {
                        Text("• \(values.first!) and \(values.count - 1) more")
                            .foregroundColor(.secondary)
                            .transition(.opacity)
                            .animation(.spring(response: 0.25, dampingFraction: 0.8), value: isExpanded)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 4)
        .padding(.horizontal)
    }
}



#Preview {
    HPCharacterDetailView(character: .mockCharacter)
}
