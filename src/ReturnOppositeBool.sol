// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnOppositeBool {
    function main(bool _bool) external pure returns (bool) {
        assembly {
            mstore(0x00, iszero(_bool))
            return(0x00, 0x20)
            // return the opposite of `_bool`
        }
    }
}
