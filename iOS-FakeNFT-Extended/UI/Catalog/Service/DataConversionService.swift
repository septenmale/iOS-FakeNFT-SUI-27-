import Foundation

@MainActor
final class DataConversionService {
    
    private let collectionService: CollectionService
    private let nftService: NftService
    
    init(collectionService: CollectionService, nftService: NftService) {
        self.collectionService = collectionService
        self.nftService = nftService
    }
    
    func loadCatalogData() async throws -> [CatalogNft] {
        let collections = try await collectionService.loadCollections()
        var catalogItems: [CatalogNft] = []
        
        for collection in collections {
            let nftItems = try await loadNFTsForCollection(collection.nfts)
            
            let catalogItem = CatalogNft(
                title: collection.name,
                collection: nftItems,
                catalogImage: collection.cover,
                author: collection.author,
                descriptionNft: collection.description
            )
            
            catalogItems.append(catalogItem)
        }
        
        return catalogItems
    }
    
    private func loadNFTsForCollection(_ nftIds: [String]) async throws -> [CollectionNFT] {
        var nftItems: [CollectionNFT] = []
        
        for nftId in nftIds {
            do {
                let nft = try await nftService.loadNft(id: nftId)
                
                // Первое изображение NFT
                let imageData = await loadImageData(from: nft.images.first)
                
                let collectionNFT = CollectionNFT(
                    id: nft.id,
                    name: "NFT \(nft.id.prefix(8))",
                    like: false,
                    rating: Int.random(in: 1...5),
                    price: Double.random(in: 0.1...10.0),
                    imageNft: imageData,
                    basket: false
                )
                nftItems.append(collectionNFT)
            } catch {
                print("Error loading NFT \(nftId): \(error)")
                //  NFT без изображения в случае ошибки
                let collectionNFT = CollectionNFT(
                    id: nftId,
                    name: "NFT \(nftId.prefix(8))",
                    like: false,
                    rating: Int.random(in: 1...5),
                    price: Double.random(in: 0.1...10.0),
                    imageNft: nil,
                    basket: false
                )
                nftItems.append(collectionNFT)
            }
        }
        
        return nftItems
    }
    
    private func loadImageData(from url: URL?) async -> Data? {
        guard let url = url else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            print("Error loading image from \(url): \(error)")
            return nil
        }
    }
}
