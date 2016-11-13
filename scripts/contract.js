/*
    Contract Management
 */

// takes a contract source string
// returns a map of contract names and objects
function compile(source) {
  return eth.compile.solidity(source);
}

// takes a single contract object (NOT THE WHOLE MAPPING)
// takes in a user who is deploying the contract
// deploys the contract
// returns the contract instance
// NOTE: EXACTLY ONE CONTRACT CONSTRUCTOR ARGUMENT ALLOWED
function deploy(contract_obj, deploying_user, args) {
  return eth.contract(contract_obj.info.abiDefinition).new(args, {from: deploying_user, data: contract_obj.code, gas: 1000000});
}

// takes a contract address
// returns the corresponding contract instance
function getContract(contract_obj, address) {
  return eth.contract(contract_obj.info.abiDefinition).at(address);
}
