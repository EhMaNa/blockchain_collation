// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract CollationContract {
    uint256 public count = 0;

    struct Collation {
        uint256 id;
    }

    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }
    mapping(uint256 => Candidate) public candidates;
}
