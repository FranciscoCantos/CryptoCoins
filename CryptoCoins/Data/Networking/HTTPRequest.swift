import Foundation

struct HTTPRequest {
    let baseURL: String
    let path: String
    let queryParams: [String: Any]?
    let method: HTTPMethod
    
    init(baseURL: String, path: String, method: HTTPMethod, queryParams: [String : Any]? = nil) {
        self.baseURL = baseURL
        self.path = path
        self.queryParams = queryParams
        self.method = method
    }
}
