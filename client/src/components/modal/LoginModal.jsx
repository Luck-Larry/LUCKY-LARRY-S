import React, { useState } from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
import Modal from './Modal';

function LoginModal({ setModal }) {
  const [info, setInfo] = useState({});

  function handleChange(e, field) {
    setInfo((prev) => {
      const obj = {
        ...prev,
      };
      obj[field] = e.target.value;
      return obj;
    });
  }

  function handleSubmit() {
    const results = axios.get('/api/user', { params: info }); // CHECK WHAT ROUTE WE ARE USING
    if (info.password === results.password) {
      // valid
    }
    setModal(false);
  }

  return (
    <Modal setModal={setModal}>
      <div className="modal-content">
        <div className="modal-header text-center bg-info">
          <h4 className="modal-title w-100 font-weight-bold">
            Sign in
          </h4>
          <button
            type="button"
            className="close"
            data-dismiss="modal"
            aria-label="Close"
            onClick={() => setModal(false)}
          >
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div className="modal-body mx-3">
          <div className="md-form mb-4">
            <label htmlFor="defaultForm-username">
              Your username
              <input
                type="text"
                id="defaultForm-username"
                className="form-control validate"
                onChange={(e) => handleChange(e, 'username')}
              />
            </label>
          </div>
          <div className="md-form mb-4">
            <label htmlFor="defaultForm-pass">
              Your password
              <input
                type="password"
                id="defaultForm-pass"
                className="form-control validate"
                onChange={(e) => handleChange(e, 'password')}
              />
            </label>
          </div>
        </div>
        <div className="modal-footer d-flex justify-content-center">
          <button
            type="submit"
            className="btn btn-info"
            onClick={() => handleSubmit()}
          >
            Login
          </button>
        </div>
      </div>
    </Modal>
  );
}

LoginModal.propTypes = {
  setModal: PropTypes.func.isRequired,
};

export default LoginModal;