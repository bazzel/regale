require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let!(:event)             { create :event }
  let(:valid_attributes)   { attributes_for(:event) }
  let(:invalid_attributes) { attributes_for(:event).except(:title) }
  let(:current_user)       { create :user, :admin }
  let(:valid_session)      { { user_id: current_user.id } }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    xit 'returns a success response' do
      get :show, params: {id: event.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: {id: event.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    def do_post(attributes)
      post :create, params: {event: attributes}, session: valid_session
    end

    context 'with valid params' do
      it 'creates a new Event' do
        expect {
          do_post(valid_attributes)
        }.to change(Event, :count).by(1)
      end

      it 'redirects to the events list' do
        do_post(valid_attributes)
        expect(response).to redirect_to(events_url)
      end
    end

    context 'with invalid params' do
      it 'returns a success response' do
        do_post(invalid_attributes)
        expect(response).to be_successful
      end

      it 'renders the new template' do
        do_post(invalid_attributes)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    def do_put(attributes)
      put :update, params: {id: event.to_param, event: attributes}, session: valid_session
    end

    context 'with valid params' do
      let(:new_attributes) { { title: 'Fresh title' } }

      it 'updates the requested event' do
        expect do
          do_put(new_attributes)
          event.reload
        end.to change(event, :title)
      end

      it 'redirects to the events list' do
        do_put(new_attributes)
        expect(response).to redirect_to(events_url)
      end
    end

    context 'with invalid params' do
      let(:new_attributes) { { title: '' } }

      it 'returns a success response' do
        do_put(new_attributes)
        expect(response).to be_successful
      end

      it 'renders the edit template' do
        do_put(new_attributes)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    def do_delete
      delete :destroy, params: {id: event.to_param}, session: valid_session
    end

    it 'destroys the requested event' do
      expect {
        do_delete
      }.to change(Event, :count).by(-1)
    end

    it 'redirects to the events list' do
      do_delete
      expect(response).to redirect_to(events_url)
    end
  end
end
