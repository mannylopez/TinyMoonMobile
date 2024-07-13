// Created by manny_lopez on 7/13/24.

import Foundation
import TinyMoon

struct MoonViewModel {
  let moon: TinyMoon.Moon

  init(_ date: Date = Date(), timeZone: TimeZone = .current) {
    moon = TinyMoon.calculateMoonPhase(date, timeZone: timeZone)
  }
}
