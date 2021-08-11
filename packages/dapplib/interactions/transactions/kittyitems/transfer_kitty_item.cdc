// TODO:
// Add imports here, then do steps 1, 2, 3, and 4.
import KittyItems from Project.KittyItems

// This transaction transfers a Kitty Item from one account to another.

transaction(recipient: Address, withdrawID: UInt64) {
    // local variable for a reference to the signer's Kitty Items Collection
    let signerCollectionRef: &KittyItems.Collection

    // local variable for a reference to the receiver's Kitty Items Collection
    let receiverCollectionRef: &{NonFungibleToken.CollectionPublic}

    prepare(signer: AuthAccount) {

        // 1) borrow a reference to the signer's Kitty Items Collection
        let signersCollectionRef = getAccount(signer.address)
            .getCapability(/public/kittyItemsCollection)!
            .borrow<&KittyItems.Collection{KittyItems.KittyItemsCollectionPublic}>()
            ?? panic("Couldn't get collection")
        // 2) borrow a public reference to the recipient's Kitty Items Collection
        let publicCollectionRef = getAccount(recipient.address)
            .getCapability(/public/kittyItemsCollection)!
            .borrow<&KittyItems.Collection{KittyItems.KittyItemsCollectionPublic}>()
            ?? panic("Couldn't get collection")
    }

    execute {

        // 3) withdraw the Kitty Item from the signer's Collection
        let kittyItem <- signersCollectionRef.withdraw(withdrawID: withdrawID)
        // 4) deposit the Kitty Item into the recipient's Collection
       publicCollectionRef.deposit(token: kittyItem)
    }
}