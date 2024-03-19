pragma solidity ^0.8.0;

contract VotingSystem {
    mapping(address => bool) public hasVoted;
    mapping(bytes32 => uint256) public voteCount;

    event VoteCast(address indexed voter, bytes32 indexed candidate);

    function vote(bytes32 _candidate) public {
        require(!hasVoted[msg.sender], "Already voted");

        voteCount[_candidate]++;
        hasVoted[msg.sender] = true;

        emit VoteCast(msg.sender, _candidate);
    }

    // Additional function to retrieve vote count for a candidate
    function getVoteCount(bytes32 _candidate) public view returns (uint256) {
        return voteCount[_candidate];
    }
}

