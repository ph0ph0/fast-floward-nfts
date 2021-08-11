// TODO:
// Add imports here, then do steps 1 and 2.
import KittyItems from Project.KittyItems

// This script returns an array of all the NFT IDs in an account's Kitty Items Collection.

pub fun main(address: Address): [UInt64] {

    // 1) Get a public reference to the address' public Kitty Items Collection
    let publicRef = getAccount(address)
        .getCapability(/public/KittyItemsCollection)!
        .borrow<&KittyItems.Collection{KittyItems.KittyItemsCollectionPublic}>()
            ?? panic("Couldn't get collection")
    // 2) Return the Collection's IDs 
    return publicRef.getIDs()
    // Hint: there is already a function to do that

}