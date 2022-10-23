

import Foundation

extension Schedule: Decodable {
    enum CodingKeys: String, CodingKey {
        case start, end
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let start = try container.decode(String.self, forKey: .start)
        self.start = start.convertToDate()
        let end = try container.decode(String.self, forKey: .end)
        self.end = end.convertToDate()
        
    }
}

