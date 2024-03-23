import Foundation

class HTTPRequestBuilder {
    func url(request: HTTPRequest) -> URL? {
        var urlComponents = URLComponents(string: request.baseURL + request.path)
        let urlQueryParams = request.queryParams?.map({
            URLQueryItem(name: $0.key, value: $0.value as? String)
        })
        urlComponents?.queryItems = urlQueryParams
        return urlComponents?.url
    }
}
