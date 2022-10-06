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
    uint256 public candidatesCount;
    event addCandidate(uint256 id, string name, uint256 voteCount);

    function addCandidate(string memory _name, uint256 memeory _voteCount) public {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, _voteCount);
        emit addCandidate(candidatesCount, _name, _voteCount);
    }
}
