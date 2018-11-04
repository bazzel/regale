require 'rails_helper'

RSpec.describe PatternFlyHelper, type: :helper do
  describe '#pf_flash' do
    subject       { helper.pf_flash }
    let(:content) { 'Lorem' }

    context 'success' do
      before { flash[:success] = content }

      it { is_expected.to have_css('div.alert.fade.in.alert-success', text: content) }
      it { is_expected.to have_css('div.alert span.pficon.pficon-ok') }
      it { is_expected.to have_css('div.alert button.close[data-dismiss="alert"] span.pficon.pficon-close') }
    end

    context 'info' do
      before { flash[:info] = content }

      it { is_expected.to have_css('div.alert.fade.in.alert-info', text: content) }
      it { is_expected.to have_css('div.alert span.pficon.pficon-info') }
      it { is_expected.to have_css('div.alert button.close[data-dismiss="alert"] span.pficon.pficon-close') }
    end

    context 'warning' do
      before { flash[:warning] = content }

      it { is_expected.to have_css('div.alert.fade.in.alert-warning', text: content) }
      it { is_expected.to have_css('div.alert span.pficon.pficon-warning-triangle-o') }
      it { is_expected.to have_css('div.alert button.close[data-dismiss="alert"] span.pficon.pficon-close') }
    end

    context 'danger' do
      before { flash[:danger] = content }

      it { is_expected.to have_css('div.alert.fade.in.alert-danger', text: content) }
      it { is_expected.to have_css('div.alert span.pficon.pficon-error-circle-o') }
      it { is_expected.to have_css('div.alert button.close[data-dismiss="alert"] span.pficon.pficon-close') }
    end

    context 'notice' do
      before { flash[:notice] = content }

      it { is_expected.to have_css('div.alert.fade.in.alert-success', text: content) }
      it { is_expected.to have_css('div.alert span.pficon.pficon-ok') }
      it { is_expected.to have_css('div.alert button.close[data-dismiss="alert"] span.pficon.pficon-close') }
    end

    context 'alert' do
      before { flash[:alert] = content }

      it { is_expected.to have_css('div.alert.fade.in.alert-danger', text: content) }
      it { is_expected.to have_css('div.alert span.pficon.pficon-error-circle-o') }
      it { is_expected.to have_css('div.alert button.close[data-dismiss="alert"] span.pficon.pficon-close') }
    end

    context 'error' do
      before { flash[:error] = content }

      it { is_expected.to have_css('div.alert.fade.in.alert-danger', text: content) }
      it { is_expected.to have_css('div.alert span.pficon.pficon-error-circle-o') }
      it { is_expected.to have_css('div.alert button.close[data-dismiss="alert"] span.pficon.pficon-close') }
    end

    context 'others' do
      before { flash[:lorem] = content }

      it { is_expected.to be_empty }
    end

    context 'with options passed' do
      before          { flash[:success] = content }
      subject         { helper.pf_flash options }
      let(:classname) { 'my-classname' }
      let(:options)   { { class: classname } }

      it { is_expected.to have_css('div.alert.fade.in.alert-success.my-classname', text: content) }
      it { is_expected.to have_css('div.alert span.pficon.pficon-ok') }
      it { is_expected.to have_css('div.alert button.close[data-dismiss="alert"] span.pficon.pficon-close') }
    end

    context 'multiple flashes' do
      before         { flash[:success] = content1 }
      before         { flash[:info] = content2 }
      let(:content1) { content }
      let(:content2) { content*2 }

      it { is_expected.to have_css('div.alert.fade.in.alert-success', text: content1) }
      it { is_expected.to have_css('div.alert.fade.in.alert-info', text: content2) }
      it { is_expected.to have_css('div.alert button.close[data-dismiss="alert"] span.pficon.pficon-close', count: 2) }
    end
  end
end
