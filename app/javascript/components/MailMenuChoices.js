import React from "react"
import PropTypes from "prop-types"
import { Modal, Checkbox, Button } from 'react-bootstrap'
import I18n from 'i18n-js/index.js.erb'
import FormAuthenticityToken from "./FormAuthenticityToken"

class MailMenuChoices extends React.Component {
  constructor(props, context) {
    super(props, context);

    this.state = {
      show: false
    };
  }

  render () {
    const handleShow = () => this.handleShow()
    const handleClose = () => this.handleClose()
    const handleSubmit = () => this.handleSubmit()

    const { mailMenuChoicesPath } = this.props;

    return (
      <React.Fragment>
        <span onClick={handleShow}>Mail Menu Choices...</span>

        <Modal show={this.state.show} onHide={handleClose}>
          <form action={mailMenuChoicesPath} method="post" target="_blank">
            <FormAuthenticityToken />
            <Modal.Header closeButton>
              <Modal.Title>Modal heading</Modal.Title>
            </Modal.Header>
            <Modal.Body>
              <h4>Text in a modal</h4>
              <p>
                Duis mollis, est non commodo luctus, nisi erat porttitor ligula.
              </p>

              {this.Checkboxes}
            </Modal.Body>
            <Modal.Footer>
              <Button onClick={handleClose}>Cancel</Button>
              <Button bsStyle="primary" type="submit" onClick={handleSubmit}>Compose Email</Button>
            </Modal.Footer>
          </form>
        </Modal>

      </React.Fragment>
      );
  }

  get Checkboxes() {
    let { acceptStatusesSummary } = this.props;

    return Object.keys(acceptStatusesSummary).map((key) => <Checkbox value={key} name="accept_status[]">{I18n.t(`activerecord.attributes.guest.accept_status/${key}`)}</Checkbox>);
  }

  handleClose() {
    this.setState({ show: false });
  }

  handleShow() {
    this.setState({ show: true });
  }

  handleSubmit() {
    this.handleClose()
  }
}

export default MailMenuChoices
