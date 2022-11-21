//
//  LocationRequestView.swift
//  Hiking-Trails
//
//  Created by Nils Streedain on 11/20/22.
//

import SwiftUI

struct LocationRequestView: View {
    var body: some View {
		ZStack {
			Color("AccentColor").ignoresSafeArea()
			VStack {
				Spacer()
				Image(systemName: "figure.hiking")
					.resizable()
					.scaledToFit()
					.frame(width: 200, height: 200)
					.padding(.bottom, 32)
				Text("Would you like to begin tracking your hikes?")
					.font(.system(size: 28, weight: .semibold))
					.multilineTextAlignment(.center)
					.padding()
				
				Text("Share your location to get started!")
					.multilineTextAlignment(.center)
					.padding()
				Spacer()
				VStack {
					Button {
						LocationManager.shared.requestLocation()
					} label: {
						Text("Allow location")
							.padding()
							.font(.headline)
							.foregroundColor(Color("AccentColor"))
					}
					.frame(width: UIScreen.main.bounds.width)
					.padding(.horizontal, -32)
					.background(Color.white)
					.clipShape(Capsule())
					.padding()
				}
			}
			.foregroundColor(.white)
		}
    }
}

struct LocationRequestView_Previews: PreviewProvider {
    static var previews: some View {
		LocationRequestView()
    }
}
