import XCTest
@testable import SRTReader

final class SRTReaderTests: XCTestCase {
  private func srtResource(name resourceName: String) throws -> String {
    let path = Bundle.module.path(forResource: resourceName, ofType: "srt")!
    let data = FileManager.default.contents(atPath: path)!
    return String(data: data, encoding: .utf8)!
  }

  func testSRTReader() throws {
    let e01Subs = Subtitles(string: try srtResource(name: "[Erai-raws] Hikikomari Kyuuketsuki no Monmon - 01"))
    XCTAssertEqual(390, e01Subs.entries.count)
    
    let e02Subs = Subtitles(string: try srtResource(name: "[Erai-raws] Hikikomari Kyuuketsuki no Monmon - 02"))
    XCTAssertEqual(381, e02Subs.entries.count)
  }
}
