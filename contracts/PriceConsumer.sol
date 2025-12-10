// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@pythnetwork/pyth-sdk-solidity/IPyth.sol";
import "@pythnetwork/pyth-sdk-solidity/PythStructs.sol";

contract PriceConsumer {
    IPyth public pyth;

    constructor(address pythContract) {
        pyth = IPyth(pythContract);
    }

    function updatePrice(bytes[] calldata priceUpdateData)
        external
        payable
    {
        // Pay the Pyth fee for receiving price updates
        uint fee = pyth.getUpdateFee(priceUpdateData);
        require(msg.value >= fee, "Not enough fee sent");

        // Update the Pyth price state
        pyth.updatePriceFeeds{value: fee}(priceUpdateData);

        // Can fetch the price and use it as well
        //PythStructs.Price memory currentBasePrice = pyth.getPriceNoOlderThan(priceFeedId, 60);
    }

    function getLatestPrice(bytes32 priceFeedId) public view returns (int64, int32) {
        // Read the current price from a price feed if it is less than 60 seconds old.
        // Each price feed (e.g., USD/IDR) is identified by a price feed ID.
        // The complete list of feed IDs is available at https://docs.pyth.network/price-feeds/price-feeds
        PythStructs.Price memory currentBasePrice = pyth.getPriceNoOlderThan(priceFeedId, 60);
        
        // uint256 basePrice = PythUtils.convertToUint(
        //   currentBasePrice.price,
        //   currentBasePrice.expo,
        //   18
        // );
        
        return (currentBasePrice.price, currentBasePrice.expo);
    }
}
 