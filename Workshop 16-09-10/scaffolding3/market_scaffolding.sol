contract Market {
    
    /* Status enum for the 3 possible states */
    enum Status { OFFERED, TAKEN, CONFIRMED}
    
    /* Struct for storing an offer */
    struct Offer {
    }
    
    /// @dev add a new offer
    /// @param product_ product name
    /// @param price_ price in wei
    /// @return id of the new offer
    function addOffer(string product_, uint price_) returns (uint id) {
        
    }
    
    /// @dev take a offer
    /// @param id id of the offer
    function takeOffer(uint id) {
        
    }
    
    /// @dev confirm a shipment
    /// @param id id of the offer
    function confirm(uint id) {
        
    }
    
}