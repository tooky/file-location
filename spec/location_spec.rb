require 'location'
describe Location do
  let(:file) { "foo.feature" }
  let(:line_no)  { 12 }
  let(:location) { Location.new(file, line_no) }

  let(:other_file) { "bar.feature" }
  let(:other_line_no) { 99 }

  context 'matching other locations' do
    it 'does not match a different location' do
      other = Location.new(other_file, other_line_no)

      expect( location.match?(other) ).to be_false
    end

    it 'does not match a different location in the same file' do
      other = Location.new(file, other_line_no)

      expect( location.match?(other) ).to be_false
    end

    it 'matches the same location in the same file' do
      other = Location.new(file, line_no)

      expect( location.match?(other) ).to be_true
    end

    context 'a wildcard location' do
      it 'matches a wildcard location in the same file' do
        wildcard = WildcardLocation.new(file)

        expect( location.match?(wildcard) ).to be_true
        expect( wildcard.match?(location) ).to be_true
      end

      it "doesn't match a wildcard location in another file" do
        wildcard = WildcardLocation.new(other_file)

        expect( location.match?(wildcard) ).to be_false
        expect( wildcard.match?(location) ).to be_false
      end
    end
  end

  context 'displaying as a string' do
    it 'shows "file:line_no' do
      expect( location.to_s ).to eq("foo.feature:12")
    end
  end
end
