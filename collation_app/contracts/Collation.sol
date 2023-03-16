// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

contract CollationContract {
    struct Collation {
        uint256 id;
        string area;
        string[] candidates;
    }

    uint256 public candidatesCount;*/
    mapping(uint256 => Collation) public candidatess;
    uint256 public candidatesCount;
    Collation[] public collations;
    event addedCollation(uint256 id, string area, string[] candidates);

    //event addedCollation(uint256 id, string name, string voteCount);

    /*function addCollation(string memory _name, string memory _voteCount)
        public
  
        emit addedCollation(candidatesCount, _name, _voteCount);
    }*/
    function addCollation(string memory _area, string[] memory candidates)
        public
    {
        candidatesCount++;
        collations.push(Collation(candidatesCount, _area, candidates));

        emit addedCollation(candidatesCount, _area, candidates);
    }

    function getCollation(uint256 i)
        public
        view
        returns (
            uint256 id,
            string memory,
            string[] memory
        )
    {
        return (collations[i].id, collations[i].area, collations[i].candidates);
    }
}
//CollationContract.deployed().then(function(i){app=i;})
