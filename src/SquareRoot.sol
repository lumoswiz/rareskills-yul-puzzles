// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract SquareRoot {
    function main(uint256 x) external pure returns (uint256) {
        assembly {
            switch x
            case 0 {
                return(0x00, 0x20)
            }
            case 1 {
                mstore(0x00, 0x01)
                return(0x00, 0x20)
            }
            default {
                let g := shr(1, x)
                // prettier-ignore
                for { } 1 { } {
                    let z := div(x, g)
                    let ng := add(and(g, z), shr(1, xor(g, z)))
                    if iszero(lt(ng, g)) { break } // strictly decreasing
                    g := ng
                }
                mstore(0x00, g)
                return(0x00, 0x20)
            }
        }
        // return the square root of x rounded down
        // e.g. root(4) = 2 root(5) = 2 root(6) = 2, ..., root(8) = 2, root(9) = 3
        // hint: https://www.youtube.com/watch?v=CnMBo5nG_zk
        // hint: use x / 2 as initial guess
        // hint: be careful of overflow
        // hint: use a switch statement to handle 0, 1, and the general case
        // hint: use break to exit the loop if the new guess is the same as the old guess
    }
}
