import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const pythContractAddress = "0x2880ab155794e7179c9ee2e38200202908c17b43"; 

export default buildModule("PriceConsumerModule", (m) => {

  const priceConsumer = m.contract("PriceConsumer", [pythContractAddress]);

  return { priceConsumer };
});

// 0x91e89aa32224dEd5dA483a83a4de45bF4bE57caA

