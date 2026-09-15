import Combine
import SwiftUI

class AuthService: ObservableObject {

    static let instance = AuthService()

    init() {

    }

    var cancellables = Set<AnyCancellable>()

    func loginApi(with credentials: LoginRequest) {
        
        // 1. Strip leading slashes when using appendingPathComponent
        let baseURL = APIConfig.currentEnvironment.baseURL
        let url = baseURL.appendingPathComponent("api/auth/login")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        
        // 2. FIXED: Correct key -> value placement
        request.setValue(
            ContentType.json.rawValue,
            forHTTPHeaderField: HTTPHeaderField.contentType.rawValue
        )
        request.setValue(
            ContentType.json.rawValue,
            forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue
        )
        
        // 3. Fixes ngrok warning pages and simulator socket drop (-1005)
        request.setValue("true", forHTTPHeaderField: "ngrok-skip-browser-warning")
        request.setValue("close", forHTTPHeaderField: "Connection")
        
        do {
            request.httpBody = try JSONEncoder().encode(credentials)
        } catch {
            print("Encoding error: \(error)")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: LoginResponse.self, decoder: JSONDecoder())
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Login API Error: \(error)")
                }
            } receiveValue: { [weak self] responseData in
                guard let data = responseData.data else { return }
                
                UserDefaults.standard.set(true, forKey: StorageKeys.isLoggedIn)
                UserDefaults.standard.set(data.token, forKey: StorageKeys.accessToken)
                UserDefaults.standard.set(data.user?.email, forKey: StorageKeys.email)
                UserDefaults.standard.set(data.user?.name, forKey: StorageKeys.username)
                
                print("Successfully logged in!")
            }
            .store(in: &cancellables)
    }
    /// Implement API using Swift Concurrency (async/await)
    func registerApi(with details: RegisterRequest) async throws
        -> RegisterResponse
    {
        // Construct the full URL using the Environment's baseURL and the Endpoint path
        let baseURL = APIConfig.currentEnvironment.baseURL
        let url = baseURL.appendingPathComponent(Endpoints.register)

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue

        // Use HTTPHeaderField and ContentType constants defined in ApiConstants.swift
        request.setValue(
            ContentType.json.rawValue,
            forHTTPHeaderField: HTTPHeaderField.contentType.rawValue
        )

        // Encode the body using JSONEncoder
        do {
            request.httpBody = try JSONEncoder().encode(details)
        } catch {
            print("Encoding error: \(error)")
            throw error
        }

        // Perform the async request using Swift Concurrency
        let (data, response) = try await URLSession.shared.data(for: request)

        // Validate response status code
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            print("API Error: HTTP Status Code \(httpResponse.statusCode)")
            throw URLError(.init(rawValue: httpResponse.statusCode))
        }

        // Decode and return the response
        return try JSONDecoder().decode(RegisterResponse.self, from: data)
    }

    /////////////////////////////////////////////

    func signup(with details: RegisterRequest) async throws -> RegisterResponse
    {
        let baseURl = APIConfig.currentEnvironment.baseURL
        let url = baseURl.appendingPathComponent(Endpoints.register)
        var request = URLRequest(url: url)
        request.setValue(
            ContentType.json.rawValue,
            forHTTPHeaderField: HTTPHeaderField.contentType.rawValue
        )
        do {
            request.httpBody = try JSONEncoder().encode(details)
        } catch {
            print("Encoding error: \(error)")
            throw error
        }
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            print("API Error: HTTP Status Code \(httpResponse.statusCode)")
            throw URLError(.init(rawValue: httpResponse.statusCode))
        }
        return try JSONDecoder().decode(RegisterResponse.self, from: data)
    }

}
