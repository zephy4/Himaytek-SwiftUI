import Combine
import SwiftUI

class AuthService: ObservableObject {

    static let instance = AuthService()

    init() {

    }

    var cancellables = Set<AnyCancellable>()

    func loginApi(with credentials: LoginRequest) {

        guard let url = URL(string: "https://dummyjson.com/auth/login")
        else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.setValue(
            Headers.jsonValue,
            forHTTPHeaderField: Headers.contentKeyType
        )
        do {
            request.httpBody = try JSONEncoder().encode(credentials)
        } catch {
            print("Encoding error: \(error)")
            return
        }

        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap {
                (data, response) -> Data
                in
                guard let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300
                else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: LoginResponse.self, decoder: JSONDecoder())
            .sink { (completion) in

                //appStorage

                print("Login API Complete: \(completion)")

            } receiveValue: { [weak self] (data) in

                UserDefaults.standard.set(true, forKey: StorageKeys.isLoggedIn)

                UserDefaults.standard.set(
                    data.accessToken,
                    forKey: StorageKeys.accessToken
                )
                UserDefaults.standard.set(data.email, forKey: StorageKeys.email)

                var fullname: String =
                    (data.firstName ?? "") + (data.lastName ?? "")

                UserDefaults.standard.set(
                    fullname,
                    forKey: StorageKeys.username
                )
                print("Data: \(data)")
            }
            .store(in: &cancellables)

    }
}
