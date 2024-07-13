// Created by manny_lopez on 7/13/24.

import SwiftUI

struct MoonView: View {

  // MARK: Internal

  @State var moon = MoonViewModel().moon

  var body: some View {
    Text(formatDate(moon.date))
    VStack(alignment: .leading, spacing: 8) {
      Text(moon.emoji)
      Text(moon.name)
      Text("Days till full moon: \(moon.daysTillFullMoon)")
      Text("Days till new moon: \(moon.daysTillNewMoon)")
      Text("phaseFraction: \(moon.phaseFraction)")
      Text("illuminatedFraction: \(moon.illuminatedFraction)")

      Text("MoonDetails")
        .font(.title2)
      Text("Julian Day: \(moon.moonDetail.julianDay)")
      Text("daysElapsedInCycle: \(moon.moonDetail.daysElapsedInCycle)")
      Text(ageOfMoon(moon.moonDetail.ageOfMoon))
      Text("distanceFromCenterOfEarth: \(moon.moonDetail.distanceFromCenterOfEarth) km")
      Text("phase: \(moon.moonDetail.phase)")

      Button("Update") {
        moon = MoonViewModel(Date()).moon
      }
      .buttonStyle(.borderedProminent)
    }
    .padding()
  }

  // MARK: Private

  private func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .long
    return formatter.string(from: date)
  }

  private func ageOfMoon(_ details: (days: Int, hours: Int, minutes: Int)) -> String {
    "\(details.days) days, \(details.hours) hours, \(details.minutes) minutes"
  }


}

#Preview {
  MoonView()
}
