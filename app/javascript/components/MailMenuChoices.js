import React from "react"
import PropTypes from "prop-types"
import { Modal, Button } from 'react-bootstrap'

class MailMenuChoices extends React.Component {
  constructor(props, context) {
    super(props, context);

    this.state = {
      show: false
    };
  }

  handleClose() {
    this.setState({ show: false });
  }

  handleShow() {
    this.setState({ show: true });
  }

  handleSubmit() {
    const { url } = this.props;

    window.open(url)
    this.handleClose()
  }

  render () {
    const handleShow = () => this.handleShow()
    const handleClose = () => this.handleClose()
    const handleSubmit = () => this.handleSubmit()

    const { show } = this.props;

    return (
      <React.Fragment>
        <span onClick={handleShow}>Mail Menu Choices...</span>

        <Modal show={this.state.show} onHide={handleClose}>
          <Modal.Header closeButton>
            <Modal.Title>Modal heading</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <h4>Text in a modal</h4>
            <p>
              Duis mollis, est non commodo luctus, nisi erat porttitor ligula.
            </p>

          </Modal.Body>
          <Modal.Footer>
            <Button onClick={handleClose}>Cancel</Button>
            <Button bsStyle="primary" onClick={handleSubmit}>Compose Email</Button>
          </Modal.Footer>
        </Modal>

      </React.Fragment>
      );
  }
}

export default MailMenuChoices
