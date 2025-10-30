enum CartNavigationDestination: Hashable {
    case payment(cartItems: [CartItem])
    case success
}
