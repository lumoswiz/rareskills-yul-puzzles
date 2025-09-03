// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

/**
 * How it works:
 *
 * Let d = xor(x, y) & f = iszero(condition), g = mul(d, f)
 *
 * condition = 0 => f = 1 => g => d, then:
 * z = x ^ d = x ^ (x ^ y) = y
 *
 * condition = 1 => f = 0 => g = 0
 * z = x ^ 0 = x
 */

contract Tenary {
    uint256 public result;

    function main(uint256 a, uint256 b, uint256 c) external {
        assembly {
            let z := xor(
                0x0a,
                mul(
                    xor(
                        0x0a,
                        xor(0x14, mul(xor(0x14, 0x1E), iszero(gt(b, c))))
                    ),
                    iszero(gt(a, b))
                )
            )
            sstore(0x00, z)
            // store `10` in the storage variable `result` if a > b,
            // else if b > c, store `20`,
            // else, store `30`
        }
    }
}
