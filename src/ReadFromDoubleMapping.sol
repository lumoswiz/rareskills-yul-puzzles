// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromDoubleMapping {
    mapping(address user => mapping(address token => uint256)) public balances;

    function setValue(address user, address token, uint256 value) external {
        balances[user][token] = value;
    }

    function main(address user, address token) external view returns (uint256) {
        assembly {
            mstore(0x00, user)
            let innerHash := keccak256(0x00, 0x40)
            mstore(0x20, innerHash)

            mstore(0x00, token)
            let s := keccak256(0x00, 0x40)

            mstore(0x00, sload(s))
            return(0x00, 0x20)
            // read and return the `token` balance of `user` in the double mapping `balances`
            // Hint: https://www.rareskills.io/post/solidity-dynamic
        }
    }
}
