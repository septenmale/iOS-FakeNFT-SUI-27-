//
//  UserNFTCollectionViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/25/25.
//
import SwiftUI
import SwiftData

@Observable class UserNFTCollectionViewModel: UserNFTCollectionViewModelProtocol {
        
    let userCollectionIds: [String]
    
    private let model: UserNFTCollectionModelProtocol
    
    private(set) var fetchedElements: [UserCollectionNFTItem] = []
    private(set) var isLoading: Bool = false
    private(set) var isError: Bool = false
    
    private var context: ModelContext?
    
    init(userCollectionIds: [String], model: UserNFTCollectionModelProtocol? = nil) {
        self.userCollectionIds = userCollectionIds
        self.model = model ?? UserNFTCollectionModelMock()
    }
    
    func fetchUserCollection() async {
        isLoading = true
        do {
            fetchedElements = try await model.fetchUserCollection()
        } catch {
            isError = true
        }
        isLoading = false
    }
    
    func insertModelContext(context: ModelContext) {
        self.context = context
    }
    
    func toggleLikeNFT(id: String, likedNFTs: [LikedNft]) {

        guard let context else { return }
        
        defer {
            do {
                try context.save()
                print("Should be saved!")
            } catch {
                print("Something went wrong!")
            }
        }
        
        let model = likedNFTs.first { $0.id == id }
        
        guard let model else {
            context.insert(LikedNft(id: id))
            return
        }
        context.delete(model)
    }
    
    func toggleAddNFTToCart(id: String, inCartNFTs: [InCartNft]) {
        
        guard let context else { return }
        
        defer {
            do {
                try context.save()
                print("Should be saved!")
            } catch {
                print("Something went wrong!")
            }
        }
        
        let model = inCartNFTs.first { $0.id == id }
        
        guard let model else {
            context.insert(InCartNft(id: id))
            return
        }
        context.delete(model)
    }
}

protocol UserNFTCollectionViewModelProtocol {
    var userCollectionIds: [String] { get }
    var isLoading: Bool { get }
    var isError: Bool { get }
    var fetchedElements: [UserCollectionNFTItem] { get }
    
    func fetchUserCollection() async
    func toggleAddNFTToCart(id: String, inCartNFTs: [InCartNft])
    func toggleLikeNFT(id: String, likedNFTs: [LikedNft])
    func insertModelContext(context: ModelContext)
}
