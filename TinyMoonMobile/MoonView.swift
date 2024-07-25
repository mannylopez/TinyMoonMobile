// Created by manny_lopez on 7/13/24.

import SwiftUI

struct MoonView: View {

  // MARK: Internal

  @State var moon = MoonViewModel().moon
  @Environment(\.colorScheme) var colorScheme
  @State var currentDate = Date()
  @State var showRawValues = false
  @State var isDarkMode = false

  var body: some View {
    Toggle(isOn: $isDarkMode) {
      Image(systemName: isDarkMode ? "moon.fill" : "sun.max")
    }
    .toggleStyle(.button)


    Text(title())
      .font(.title2)
      .padding()

    VStack(alignment: .leading, spacing: 12) {
      Text(moon.emoji)
      Text(moon.name)
      Text(daysTillFullMoon())
      Text(daysTillNewMoon())
      Text(fractionToText(moon.phaseFraction, label: "Phase"))
      Text(fractionToText(moon.illuminatedFraction, label: "Illumination"))
      Text(distance())
      Text(timeElapsed())
        .lineLimit(2)
        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
        .padding(.bottom, 8)

      dateButtons()
    }
    .padding()
    .preferredColorScheme(isDarkMode ? .dark : .light)
  }

  // MARK: Private

  private func timeElapsed() -> String {
    var timeString = ""
    if showRawValues {
      timeString = """
        Days into cycle:\n\(String(moon.daysElapsedInCycle))
        """
    } else {
      timeString = """
        Days into cycle:\n\(ageOfMoon(moon.ageOfMoon))
        """
    }
    return timeString
  }

  @ViewBuilder
  private func dateButtons() -> some View {
    HStack {
      Button("Previous") {
        var dateComponent = DateComponents()
        dateComponent.day = -1
        let calendar = Calendar.current
        let previousDay = calendar.date(byAdding: dateComponent, to: currentDate)
        currentDate = previousDay!
        moon = MoonViewModel(currentDate).moon
      }

      Button("Now") {
        currentDate = Date()
        moon = MoonViewModel(currentDate).moon
      }

      Button("Next") {
        var dateComponent = DateComponents()
        dateComponent.day = 1
        let calendar = Calendar.current
        let nextDay = calendar.date(byAdding: dateComponent, to: currentDate)
        currentDate = nextDay!
        moon = MoonViewModel(currentDate).moon
      }
    }
    .buttonStyle(.borderedProminent)
    .padding(.top, 8)

    Button("RawValues") {
      showRawValues.toggle()
    }
  }

  private func title() -> String {
    if showRawValues {
      julianDay(moon.julianDay)
    } else {
      formatDate(moon.date)
    }
  }

  private func julianDay(_ jd: Double) -> String {
    "Julian day:\n\(jd)"
  }

  private func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .long
    let dateString = formatter.string(from: date)
    let components = dateString.components(separatedBy: " at ")
    return components[0] + "\n" + components[1]
  }

  private func ageOfMoon(_ details: (days: Int, hours: Int, minutes: Int)) -> String {
    "\(details.days) days, \(details.hours) hours, \(details.minutes) minutes"
  }

  private func distance() -> String {
    let numberFormatter = NumberFormatter()
    if showRawValues {
      numberFormatter.maximumFractionDigits = 3
    } else {
      numberFormatter.maximumFractionDigits = 0
    }
    return "Distance: \(numberFormatter.string(from: NSNumber(value: moon.distanceFromCenterOfEarth))!) km"
  }

  private func fractionToText(_ fraction: Double, label: String) -> String {
    let numberFormatter = NumberFormatter()
    if showRawValues {
      numberFormatter.maximumFractionDigits = 6
    } else {
      numberFormatter.numberStyle = .percent
      numberFormatter.maximumFractionDigits = 1
    }
    return "\(label): \(numberFormatter.string(from: NSNumber(value: fraction))!)"
  }

  private func daysTillFullMoon() -> String {
    if moon.daysTillFullMoon == 0 {
      " "
    } else if moon.daysTillFullMoon == 1 {
      "\(fullMoonEmoji()) Full moon in 1 day"
    } else {
      "\(fullMoonEmoji()) Full moon in \(moon.daysTillFullMoon) days"
    }
  }

  private func daysTillNewMoon() -> String {
    if moon.daysTillNewMoon == 0 {
      " "
    } else if moon.daysTillNewMoon == 1 {
      "\(newMoonEmoji()) New moon in 1 day"
    } else {
      "\(newMoonEmoji()) New moon in \(moon.daysTillNewMoon) days"
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
