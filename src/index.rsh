'reach 0.1'; 

import { TokenPreserver, preserveToken } from
  "@github.com:Zetsuboii/rpkg-preserve-token#v0.1.8:preserveToken.rsh";
/**
 * This is an example program that creates a new Token, transfers the supply to
 * Alice and keeps token alive by calling preserverToken()
 */
export const main = Reach.App(() => {
  const Alice = Participant("Alice", {
    // Inherit the interface here
    ...TokenPreserver,

    tokenParams: Object({
      name: Bytes(32), 
      symbol: Bytes(8), 
      url: Bytes(96), 
      metadata: Bytes(32), 
      supply: UInt, 
      decimals: UInt
    })
  });
  init();
  
  Alice.only(() => {
    const { name, symbol, url, metadata, supply, decimals } = 
      declassify(interact.tokenParams);
  });
  Alice.publish(name, symbol, url, metadata, supply, decimals);

  const token = new Token({ name, symbol, url, metadata, supply, decimals });
  commit();

  // Replace this part with your own token logic
  Alice.publish();
  transfer(supply, token).to(Alice);

  // Call the function at the end
  preserveToken(Alice, token);
  commit();
  exit();
});
