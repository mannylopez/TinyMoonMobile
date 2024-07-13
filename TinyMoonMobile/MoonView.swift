// Created by manny_lopez on 7/13/24.

import SwiftUI

struct MoonView: View {

  // MARK: Internal

  @State var moon = MoonViewModel().moon
  @Environment(\.colorScheme) var colorScheme

  var body: some View {
    Text(formatDate(moon.date))

    VStack(alignment: .leading, spacing: 12) {
      Text(moon.emoji)
      Text(moon.name)
      Text(daysTillFullMoon(moon.daysTillFullMoon))
      Text(daysTillNewMoon(moon.daysTillNewMoon))
      Text("phaseFraction: \(moon.phaseFraction * 100)")
      Text(illuminatedPercent(moon.illuminatedFraction))
        .padding(.bottom, 8)

      Text("MoonDetails")
        .font(.title2)
      Text("Julian Day: \(moon.moonDetail.julianDay)")
      Text("daysElapsedInCycle: \(moon.moonDetail.daysElapsedInCycle)")
      Text(ageOfMoon(moon.moonDetail.ageOfMoon))
      Text("distanceFromCenterOfEarth: \(moon.moonDetail.distanceFromCenterOfEarth) km")
      Text("phaseFraction: \(moon.moonDetail.phase)")
      Text("illuminatedFraction: \(moon.moonDetail.illuminatedFraction)")

      Button("Update") {
        moon = MoonViewModel(Date()).moon
      }
      .buttonStyle(.borderedProminent)
      .padding(.top, 8)
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

  private func illuminatedPercent(_ fraction: Double) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .percent
    numberFormatter.maximumFractionDigits = 1
    return "% illuminated: \(numberFormatter.string(from: NSNumber(value: fraction))!)"
  }

  private func daysTillFullMoon(_ daysTillFullMoon: Int) -> String {
    if daysTillFullMoon == 0 {
      ""
    } else if daysTillFullMoon == 1 {
      "\(fullMoonEmoji()) Full moon in 1 day"
    } else {
      "\(fullMoonEmoji()) Full moon in \(daysTillFullMoon) days"
    }
  }

  private func daysTillNewMoon(_ daysTillNewMoon: Int) -> String {
    if daysTillNewMoon == 0 {
      ""
    } else if daysTillNewMoon == 1 {
      "\(newMoonEmoji()) New moon in 1 day"
    } else {
      "\(newMoonEmoji()) New moon in \(daysTillNewMoon) days"
    }
  }

  private func fullMoonEmoji() -> String {
    colorScheme == .light ? "⚪︎" : "⚫︎"
  }

  private func newMoonEmoji() -> String {
    colorScheme == .light ? "⚫︎" : "⚪︎"
  }
}

#Preview {
  MoonView()
}
