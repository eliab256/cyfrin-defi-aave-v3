// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {console} from "forge-std/Test.sol";
import {IERC20} from "../interfaces/IERC20.sol";
import {IPool} from "../interfaces/aave-v3/IPool.sol";
import {POOL} from "../Constants.sol";

contract Flash {
    error Flash__NotPool();
    error Flash__ThisContractIsNotTheInitiator();

    IPool public constant pool = IPool(POOL);

    // Task 1 - Initiate flash loan
    function flash(address token, uint256 amount) public {
        pool.flashLoanSimple({
            receiverAddress: address(this),
            asset: token,
            amount: amount,
            params: abi.encode(msg.sender),
            referralCode: 0
        });
    }

    // Task 2 - Repay flash loan
    function executeOperation(
        address asset,
        uint256 amount,
        uint256 fee,
        address initiator,
        bytes calldata params
    ) public returns (bool) {
        // Task 2.1 - Check that msg.sender is the pool contract
        if (msg.sender != address(pool)) {
            revert Flash__NotPool();
        }
        // Task 2.2 - Check that initiator is this contract
        if (initiator != address(this)) {
            revert Flash__ThisContractIsNotTheInitiator();
        }
        // Task 2.3 - Decode caller from params and transfer
        bytes memory callerBytes = params;
        address caller = abi.decode(callerBytes, (address));
        // flash loan fee from this caller
        IERC20(asset).transferFrom(caller, address(this), amount);

        // Task 2.4 - Approve the pool to spend flash loaned amount + fee
        IERC20(asset).approve(address(pool), amount + fee);
        // Task 2.5 - Return true
        return true;
    }
}
