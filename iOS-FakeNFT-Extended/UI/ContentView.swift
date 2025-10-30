import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    
    var body: some View {
        TabBarView()
            .task {
                await preloadCartNFTs()
            }
    }
    
    // Тестовая загрузка id для проверки работы корзины
    // ТODO: убрать перед мержем в девелоп
    
    @MainActor
       private func preloadCartNFTs() async {
           do {
               let descriptor = FetchDescriptor<InCartNft>()
               let existing = try context.fetch(descriptor)
               
               if !existing.isEmpty {
                   for nft in existing {
                       context.delete(nft)
                   }
                   try context.save()
               }
               
               let ids = ["e33e18d5-4fc2-466d-b651-028f78d771b8",
                          "d6a02bd1-1255-46cd-815b-656174c1d9c0",
                          "82570704-14ac-4679-9436-050f4a32a8a0"]
               for id in ids {
                   context.insert(InCartNft(id: id))
               }
               
               try context.save()
           } catch {
               print("Ошибка при добавлении InCartNft: \(error)")
           }
       }
}
