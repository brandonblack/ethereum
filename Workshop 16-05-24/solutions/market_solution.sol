contract Market {
    
    /* Status enum for the 3 possible states */
    enum Status { OFFERED, TAKEN, CONFIRMED}

    event OfferAdded(uint indexed id, string indexed product, uint indexed price);
    event OfferTaken(uint indexed id);
    event OfferConfirmed(uint indexed id);
    
    /* Struct for storing an offer */
    struct Offer {
        string product; /* product name */
        uint price; /* price in wei */
        Status status; /* current status of the offer */
        address creator; /* creator of the offer */
        address taker; /* taker of the offer, is 0 if not yet taken */
    }

    /* Array of offers with autogenerated getter */
    Offer[] public offers;
    
    /// @dev add a new offer
    /// @param product_ product name
    /// @param price_ price in wei
    /// @return id of the new offer
    function addOffer(string product_, uint price_) returns (uint) {
        /* get next id */
        var id = offers.length;
        /* add a new offer to the array */
        offers.push(Offer({
            product: product_,
            price: price_,
            status: Status.OFFERED,
            creator: msg.sender, /* sender is the creator */
            taker: 0 /* set taker 0 for now */
        }));
        OfferAdded(id, product_, price_);
        /* return the id */
        return id;
    }
    
    /// @dev take a offer
    /// @param id id of the offer
    function takeOffer(uint id) {
        /* get the offer from the array */
        var offer = offers[id];
        /* throw if the sent value does not match the offer */
        if(msg.value != offer.price) throw;
        /* throw if the offer has already been taken, OUT OF BOUND ?!? */
        if(offer.status != Status.OFFERED) throw;

        /* set status to taken */
        offer.status = Status.TAKEN;
        /* set taker */
        offer.taker = msg.sender;

        OfferTaken(id);
    }
    
    /// @dev confirm a shipment
    /// @param id id of the offer
    function confirm(uint id) {
        /* get the offer from the array */
        var offer = offers[id];
        /* throw if offer is not taken */
        if(offer.status != Status.TAKEN) throw;
        /* throw if sender is not the taker */
        if(msg.sender != offer.taker) throw;
        
        /* set status to confirmed */
        offer.status = Status.CONFIRMED;
        /* send the ether to the offer creator */
        if(!offer.creator.send(offer.price)) throw;

        OfferConfirmed(id);
    }
    
}