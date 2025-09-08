// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract AbsoluteValue {
    function main(int256 x) external pure returns (uint256) {
        assembly {
            let n := slt(x, 0)
            let a := add(mul(x, iszero(n)), mul(sub(0, x), n))
            mstore(0x00, a)
            return(0x00, 0x20)
            // return the absolute value of x
            // hint: use signed comparisons
            // hint: https://www.rareskills.io/post/signed-int-solidity
        }
    }
}
