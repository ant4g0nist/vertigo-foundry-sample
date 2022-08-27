pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/MetaCoin.sol";

contract MetaCoinTest is Test {
    function setUp() public {

    }

    function testShouldCallLinkedLibrary() public {
        MetaCoin metaCoin = new MetaCoin();
        uint metaCoinBalance = metaCoin.getBalance(msg.sender);
        uint metaCoinEthBalance = metaCoin.getBalanceInEth(msg.sender);

        assertEq(2 * metaCoinBalance, metaCoinEthBalance);
    }

    function testShouldSendCoinCorrectly() public {
        MetaCoin metaCoin = new MetaCoin();

        // Setup 2 accounts.
        address accountOne   = msg.sender;
        address accountTwo   = address(2);


        // Get initial balances of first and second account.
        uint accountOneStartingBalance = metaCoin.getBalance(accountOne);
        uint accountTwoStartingBalance = metaCoin.getBalance(accountTwo);

        // Make transaction from first account to second.
        uint amount = 10;
        vm.prank(accountOne);
        metaCoin.sendCoin(accountTwo, amount);

        uint accountOneEndingBalance = metaCoin.getBalance(accountOne);
        uint accountTwoEndingBalance = metaCoin.getBalance(accountTwo);

        assertEq(accountOneEndingBalance, accountOneStartingBalance - amount);
        assertEq(accountTwoEndingBalance, accountTwoStartingBalance + amount);
    }
}
