//U-N00B-or-Bot

import Foundation

struct Temp: Decodable {
    var current: Current
}

struct Current: Decodable {
    var temp: Double
}
