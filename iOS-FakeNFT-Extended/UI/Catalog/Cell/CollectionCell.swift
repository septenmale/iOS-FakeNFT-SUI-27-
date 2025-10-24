import SwiftUI

struct CollectionCell: View {
    let item: CollectionNFT
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                Rectangle()
                    .fill(Color.yaLightGrey)
                
                Image(item.imageNft)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                Button(action: {
                }) {
                    Image("like")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(item.like ? .uniRed : .uniWhite)
                        .padding(-6)
                }
                .padding(4)
            }
            .frame(width: 108, height: 108)
            .cornerRadius(12)
            
            HStack(spacing: 2) {
                ForEach(0..<5, id: \.self) { index in
                    Image("star")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 12, height: 12)
                        .foregroundColor(index < item.rating ? .uniYellow : .yaLightGrey)
                }
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.name)
                        .font(.bold17)
                        .foregroundColor(.yaBlack)
                    
                    Text("\(item.price) ETH")
                        .font(.medium10)
                        .foregroundColor(.yaBlack)
                }
                
                Spacer()
                
                Button(action: {
                }) {
                    Image(item.basket ? "cartOn" : "cartOff")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.yaBlack)
                }
            }
        }
        .frame(width: 108)
    }
}

#Preview {
    CollectionCell(item: CollectionSample.collection[0])
}
