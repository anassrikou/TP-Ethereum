pragma solidity ^0.5.0;

contract Election {
  struct Candidate {
    uint id;
    string name;
    uint voteCount;
  }
  
  uint candidateCount = 0;

  mapping(uint => Candidate) public candidates;
  mapping(address => bool) public voters;

  event votedEvent (uint indexed _candidateId);

  constructor() public {
    //   create random candidates
    addCandidate(1, "Candidate 1", 0);
    addCandidate(2, "Candidate 2", 0);
    addCandidate(3, "Candidate 3", 0);
    addCandidate(4, "Candidate 4", 0);
    addCandidate(5, "Candidate 5", 0);
  }

  function candidatesCount() public view returns(uint count) {
      return candidateCount;
  }

  function addCandidate(uint id, string memory name, uint voteCount) public {
      candidates[id] = Candidate(id, name, voteCount);
      candidateCount += 1;
  }

  function vote(uint candidateId) public{
    require(!voters[msg.sender], "cant vote twice");
    require(candidateId > 0 && candidateId <= candidateCount, "invalid candidate");
    candidates[candidateId].voteCount += 1;
    voters[msg.sender] = true;
    emit votedEvent(candidateId);
  }
}
