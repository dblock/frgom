require 'spec_helper'

describe 'Command Line' do
  let(:bin) { File.expand_path(File.join(__FILE__, '../../../bin/frgom')) }
  describe '#help' do
    let(:output) { `"#{bin}" help` }
    it 'displays help' do
      expect(output).to include 'frgom - Reticulate splines.'
    end
  end
  describe '#reticulate' do
    let(:output) { `"#{bin}" --verbose reticulate` }
    it 'reticulates a b-spline' do
      expect(output).to eq "Reticulating a Frgom::Splines::B ...\n"
    end
  end
end
