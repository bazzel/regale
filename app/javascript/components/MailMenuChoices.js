import React from "react";
import PropTypes from "prop-types";
import { Modal, Checkbox, Button } from "react-bootstrap";
import I18n from "i18n-js/index.js.erb";
import FormAuthenticityToken from "./FormAuthenticityToken";

class MailMenuChoices extends React.Component {
  constructor(props, context) {
    super(props, context);

    this.state = {
      show: false
    };
  }

  render() {
    const { mailMenuChoicesPath } = this.props;
    const { show } = this.state;

    return (
      <React.Fragment>
        <span onClick={this._handleShow}>
          {`${I18n.t("events.event.mail_menu_choices")}...`}
        </span>

        <Modal show={show} onHide={this._handleClose}>
          <form action={mailMenuChoicesPath} method="post" target="_blank">
            <FormAuthenticityToken />
            <Modal.Header closeButton>
              <Modal.Title>{I18n.t("mail_menu_choices.title")}</Modal.Title>
            </Modal.Header>
            <Modal.Body>
              <p>{I18n.t("mail_menu_choices.body")}</p>
              {this.Checkboxes}
            </Modal.Body>
            <Modal.Footer>
              <Button onClick={this._handleClose}>
                {I18n.t("mail_menu_choices.cancel")}
              </Button>
              <Button
                bsStyle="primary"
                type="submit"
                onClick={this._handleSubmit}
              >
                {I18n.t("mail_menu_choices.submit")}
              </Button>
            </Modal.Footer>
          </form>
        </Modal>
      </React.Fragment>
    );
  }

  get Checkboxes() {
    let { acceptStatusesSummary } = this.props;

    return Object.keys(acceptStatusesSummary).map(key => (
      <Checkbox value={key} key={key} name="accept_status[]">
        {`${I18n.t(`activerecord.attributes.guest.accept_status/${key}`)} (${
          acceptStatusesSummary[key]
        })`}
      </Checkbox>
    ));
  }

  _handleClose = () => {
    this.setState({ show: false });
  };

  _handleShow = () => {
    this.setState({ show: true });
  };

  _handleSubmit = () => {
    this._handleClose();
  };
}

MailMenuChoices.PropTypes = {
  acceptStatusesSummary: PropTypes.objectOf(PropTypes.number).isRequired,
  mailMenuChoicesPath: PropTypes.string.isRequired
};

export default MailMenuChoices;
