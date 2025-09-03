// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToDoubleMapping {
    mapping(address user => mapping(address token => uint256 value))
        public balances;

    function main(address user, address token, uint256 value) external {
        assembly {
            mstore(0x00, user)
            let innerHash := keccak256(0x00, 0x40)
            mstore(0x20, innerHash)
            mstore(0x00, token)
            let s := keccak256(0x00, 0x40)
            sstore(s, value)
            // set the `value` for a `user` and a `token`
            // Hint: https://www.rareskills.io/post/solidity-dynamic
        }
    }
}
