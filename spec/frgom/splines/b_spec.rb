require 'spec_helper'

describe Frgom::Splines::B do
  it 'is not reticulated by default' do
    expect(subject.reticulated?).to be false
  end
  context 'reticulated' do
    before do
      expect(subject.reticulate!).to be true
    end
    it 'is true' do
      expect(subject.reticulated?).to be true
    end
  end
end
