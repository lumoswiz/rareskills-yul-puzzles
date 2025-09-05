// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract TransferFrom {
    address owner;
    address token;

    constructor(address _token) {
        owner = msg.sender;
        token = _token;
    }

    function main(uint256 amount) external {
        assembly {
            let t := sload(0x01)
            let p := mload(0x40)
            mstore(p, 0x23b872dd)
            mstore(add(p, 0x20), caller())
            mstore(add(p, 0x40), address())
            mstore(add(p, 0x60), amount)
            let success := call(gas(), t, 0x00, add(p, 0x1c), 0x64, 0x00, 0x00)

            // transferFrom "token" to msg.sender "amount"
            // assume that you are already approved to spend "amount"
            // hint: you will need to sload the address of the token
            // hint: transferFrom has function selector 0x23b872dd and signature "transferFrom(address,address,uint256)"
        }
    }
}
