import Foundation

extension String {
  static let empty = ""
  static let newline = "\n"
  static let timestampDelimiter = " --> "
}

public struct Subtitles: CustomStringConvertible {
  struct Entry: CustomStringConvertible {
    let captions: [String]
    let startTime: TimeInterval
    let stopTime: TimeInterval
    
    var description: String {
      startTime.timestamp.appending(String.timestampDelimiter).appending(stopTime.timestamp).appending(String.newline).appending(
      captions.reduce(into: String.empty) { result, caption in
        result = result.appending("\(caption)\n")
      })
    }
  }

  let entries: [Entry]
  
  public var description: String {
    entries.enumerated().reduce(into: "") { result, entry in
      result = result.appending(String(entry.offset + 1)).appending("\n")
      result = result.appending(entry.element.description).appending("\n")
    }
  }

  public init(string: String) {
    let entryStrings = string.split(separator: "\n\n")
    self.entries = entryStrings.map { entryString in
      let lines = entryString.split(separator: "\n")
      let timestamps = lines[1].split(separator: " --> ").map(String.init)
      let times = timestamps.map(TimeInterval.init(timestamp:))
      return Subtitles.Entry(captions: lines[2..<lines.count].map(String.init), startTime: times[0], stopTime: times[1])
    }
  }
}

extension TimeInterval {
  init(timestamp: String) {
    let timestamp = timestamp.split(separator: ",")
    let hoursMinutesSeconds = timestamp[0].split(separator: ":")
    let hours = Int(hoursMinutesSeconds[0])!
    let minutes = Int(hoursMinutesSeconds[1])! + hours * 60
    let seconds = Int(hoursMinutesSeconds[2])! + minutes * 60
    let milliseconds = Int(timestamp[1])!
    self = Double(seconds) + Double(milliseconds) / 1000.0
  }

  var timestamp: String {
    let ms = Int(((truncatingRemainder(dividingBy: 1.0)) * 1000).rounded())
    let seconds = Int(self) % 60
    let minutes = (Int(self) / 60) % 60
    let hours = (Int(self) / 3600)
    return String(format: "%0.2d:%0.2d:%0.2d,%0.3d", hours, minutes, seconds, ms)
  }
}
