// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

/**
 *  No padding, so function selector does not start at index 0 (starts at index 28 (0x1c))
 */

contract RevertWithSelector {
    error RevertData(); // selector: 0xa3b7e096

    function main() external pure {
        assembly {
            mstore(0x00, 0xa3b7e096)
            revert(0x1c, 0x04)
            // revert with the custom error "RevertData"
            // do the Solidity equivalent of
            // `revert RevertData()`
            // but in assembly
            // hint: https://www.rareskills.io/post/assembly-revert
        }
    }
}
