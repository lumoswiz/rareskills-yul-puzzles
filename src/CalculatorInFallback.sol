// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract CalculatorInFallback {
    uint256 public result;

    fallback() external {
        assembly {
            let s := shr(224, calldataload(0x00))
            let a := calldataload(0x04)
            let b := calldataload(0x24)

            let z := xor(
                add(a, b),
                mul(
                    xor(
                        add(a, b),
                        xor(
                            sub(a, b),
                            mul(
                                xor(
                                    sub(a, b),
                                    xor(
                                        mul(a, b),
                                        mul(
                                            xor(
                                                mul(a, b),
                                                xor(
                                                    div(a, b),
                                                    mul(
                                                        xor(mul(a, b), 0x00),
                                                        iszero(
                                                            eq(s, 0xa391c15b)
                                                        )
                                                    )
                                                )
                                            ),
                                            iszero(eq(s, 0xc8a4ac9c))
                                        )
                                    )
                                ),
                                iszero(eq(s, 0xb67d77c5))
                            )
                        )
                    ),
                    iszero(eq(s, 0x771602f7))
                )
            )
            sstore(0x00, z)
        }
        // compare the function selector in the calldata with the any of the selectors below, then
        // execute a logic based on the right function selector and store the result in `result` variable.
        // assumming operations won't overflow
        // add(uint256,uint256) -> 0x771602f7 (add two numbers and store result in storage)
        // sub(uint256,uint256) -> 0xb67d77c5 (sub two numbers and store result in storage)
        // mul(uint256,uint256) -> 0xc8a4ac9c (mul two numbers and store result in storage)
        // div(uint256,uint256) -> 0xa391c15b (div two numbers and store result in storage)
    }
}
