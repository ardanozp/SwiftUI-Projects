//
//  AstronautScrollView.swift
//  Moonshot
//
//  Created by ardano on 21.08.2025.
//

import SwiftUI

struct CrewScrollView: View {
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)

                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.capsule)
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )

                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    let sampleCrew = [
        CrewMember(role: "Commander", astronaut: astronauts["grissom"]!),
        CrewMember(role: "Senior Pilot", astronaut: astronauts["white"]!),
        CrewMember(role: "Pilot", astronaut: astronauts["chaffee"]!)
    ]

    return CrewScrollView(crew: sampleCrew)
        .preferredColorScheme(.dark)
        .background(.darkBackground)
}
