import React from "react"

class FormAuthenticityToken extends React.Component {
  render() {

    return (
      <input name="authenticity_token" type="hidden" value={this.csrfToken}/>
    )
  }

  get csrfToken() {
    const ref = document.querySelector('meta[name="csrf-token"]');

    if (ref !== null) {
      return ref.getAttribute('content');
    }
  }
}

export default FormAuthenticityToken
