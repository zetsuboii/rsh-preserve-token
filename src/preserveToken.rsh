'reach 0.1'; 
// Helper Reach package to preserve a token by halting the application
// Check index.rsh in the repository for an example implementation

/**
 * Interface for the participant preserving the token
 * halt() function doesn't need to be implemented, but it's required 
 * syntatically
 * 
 * Use spread operator to inherit it
 * e.g.
 * const MyParticipant = Participant("MyParticipant", {
 *  ...TokenPreserver,
 *  // Rest of participant interface
 * });
 */
const TokenPreserver = {
  halt: Fun([], Null)
};


/**
 * Halts the execution keeping token alive
 * Use it at the end of the Reach.App callback to preserve the token
 * 
 * @pre preserver extends TokenPreserver interface
 * @pre balance() is 0 when called
 * @pre token is the only token in the contract
 * @post token isn't destroyed, application is halted
 * 
 * @param preserver: Participant to preserve the token
 * @param token: Token to preserve
 * @param supply: Supply of the token
 * 
 * @note You don't need to implement the halt function in your front-end
 */
function preserveToken({ preserver, token })
{
  var [] = [];
  invariant(
    balance() == 0 && 
    balance(token) <= token.supply() && 
    !token.destroyed()
  );
  while(balance(token) < token.supply()) { 
    commit();
    preserver.only(() => { interact.halt() });
    preserver.publish();
    continue;
  }

  token.burn();
  token.destroy();
}


export { preserveToken, TokenPreserver };