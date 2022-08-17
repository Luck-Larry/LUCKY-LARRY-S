import React, { useState, useEffect } from 'react';
import styled from 'styled-components';
import PropTypes from 'prop-types';
import axios from 'axios';
import FriendsListItem from './FriendsListItem';
import FriendInput from './FriendInput';

function FriendsList({ userID, setCurrentDmRecipient }) {
  const [showingFriendInput, setShowingFriendInput] = useState(false);
  const [friendAddError, setFriendAddError] = useState('');

  const [friends, setFriends] = useState([]);

  const fetchFriends = () => {
    axios({
      url: `/api/users/${userID}/friends`,
      method: 'get',
    })
      .then(({ data }) => {
        const mapped = data.map((user) => ({
          // temporary! needs to be in DB
          // temporary! needs to be in DB
          // temporary! needs to be in DB
          lastOpened: new Date().toISOString(),
          ...user,
        }));
        setFriends(mapped);
      })
      .catch((err) => {
        console.error('failed to fetch friends', err);
      });
  };

  const showFriendAddError = (errorMessage) => {
    setShowingFriendInput(false);
    setFriendAddError(errorMessage);
    setTimeout(() => {
      setFriendAddError('');
    }, 3000);
  };

  useEffect(() => {
    fetchFriends();
  }, []);

  let friendInput = <Spacer />;
  if (friendAddError) {
    friendInput = (
      <ErrorMsg>
        {friendAddError}
      </ErrorMsg>
    );
  }
  if (showingFriendInput) {
    friendInput = (
      <FriendInput
        closeFriendInput={() => setShowingFriendInput(false)}
        showFriendAddError={showFriendAddError}
        userID={userID}
        fetchFriends={fetchFriends}
      />
    );
  }

  return (
    <FriendsListContainer>
      <Header>
        <Title>
          Friends
        </Title>
        <OpenFriendInputIcon
          className="material-symbols-outlined"
          onClick={() => {
            setShowingFriendInput(!showingFriendInput);
            setFriendAddError('');
          }}
        >
          {showingFriendInput ? 'close' : 'person_add'}
        </OpenFriendInputIcon>
      </Header>
      {friendInput}
      <List>
        {friends.map((friend) => (
          <FriendsListItem
            key={friend.id}
            username={friend.username}
            country={friend.country}
            lastOpened={friend.lastOpened}
            openChat={() => setCurrentDmRecipient(friend.id)}
          />
        ))}
      </List>
    </FriendsListContainer>
  );
}

FriendsList.propTypes = {
  userID: PropTypes.number.isRequired,
  setCurrentDmRecipient: PropTypes.func.isRequired,
};

const FriendsListContainer = styled('div')`
  background-color: white;
  width: 317px;
  border: 1px solid #ced4da;
  border-bottom-style: none;
  border-radius: 7px;
`;

const Header = styled('div')`
  width: 100%;
  display: flex;
  position: relative;
  flex-direction: row;
  height: 40px;
  align-items: center;
  justify-content: center;
`;

const Title = styled('div')`
  font-size: x-large;
  color: black;
`;

const Spacer = styled('div')`
  height: 40px;
`;

const ErrorMsg = styled('div')`
  height: 40px;
  color: red;
  display: flex;
  justify-content: center;
  align-items: center;
`;

const List = styled('div')`
  overflow-y: scroll;
  height: 390px;
  width: 99%;
`;

const OpenFriendInputIcon = styled('span')`
  position: absolute;
  top: 0;
  right: 0;
  cursor: pointer;
  user-select: none;
  height: 40px;
  width: 40px;
  display: flex;
  justify-content: center;
  align-items: center;
  font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 48;

  &:Hover {
    font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 48;
  }
`;

export default FriendsList;
