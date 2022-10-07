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
        string voteCount;
    }
    mapping(uint256 => Candidate) public candidates;
    uint256 public candidatesCount;
    event addedCandidate(uint256 id, string name, string voteCount);

    function addCandidate(string memory _name, string memory _voteCount)
        public
    {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(
            candidatesCount,
            _name,
            _voteCount
        );
        emit addedCandidate(candidatesCount, _name, _voteCount);
    }
}
