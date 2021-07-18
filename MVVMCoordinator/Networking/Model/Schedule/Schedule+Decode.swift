

import Foundation

extension Schedule: Decodable {
    enum CodingKeys: String, CodingKey {
        case start, end
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let start = try container.decode(String.self, forKey: .start)
        self.start = dateFormatter.date(from: start)
        let end = try container.decode(String.self, forKey: .end)
        self.end = dateFormatter.date(from: end)
        
    }
}
