// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "eggdrop/EggDropClaim.sol";
import "contracts/TestERC20.sol";

contract DeployEggDropClaimScript is Script {
    address constant YELLOW_TOKEN = 0x236eB848C95b231299B4AA9f56c73D6893462720;

    function run(uint32 deployerIndex, address token, bytes32 merkleRoot, string memory mnemonic) external {
        (address gasProvider, ) = deriveRememberKey(mnemonic, 0);
        vm.startBroadcast(gasProvider);

        (address deployer, ) = deriveRememberKey(mnemonic, deployerIndex);

        payable(deployer).transfer(0.1 ether);

        vm.stopBroadcast();
        vm.startBroadcast(deployer);


        EggDropClaim eggDrop = new EggDropClaim(token);
        eggDrop.addRound(merkleRoot);

        TestERC20(token).mint(address(eggDrop), type(uint128).max);
        vm.stopBroadcast();

        console.log("EggDropClaim deployed at:", address(eggDrop));
        console.log("Token:", token);
        console.log("Round 0 merkle root:", vm.toString(merkleRoot));
    }
}
