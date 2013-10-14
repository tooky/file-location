require 'location'
describe Location do
  let(:file) { "foo.feature" }
  let(:line_no)  { 12 }

  let(:other_file) { "bar.feature" }
  let(:other_line_no) { 99 }

  context 'a precise location' do
    let(:location) { Location.new(file, line_no) }
    it 'does not match a different precise location' do
      other = Location.new(other_file, other_line_no)

      expect( location.match?(other) ).to be_false
    end

    it 'does not match a different precise location in the same file' do
      other = Location.new(file, other_line_no)

      expect( location.match?(other) ).to be_false
    end

    it 'matches the same location in the same file' do
      other = Location.new(file, line_no)

      expect( location.match?(other) ).to be_true
    end

    it 'matches a wildcard location in the same file' do
      wildcard = WildcardLocation.new(file)

      expect( location.match?(wildcard) ).to be_true
    end

    it "doesn't match a wildcard location in another file" do
      wildcard = WildcardLocation.new(other_file)

      expect( location.match?(wildcard) ).to be_false
    end
  end

  context 'a wildcard location' do
    let(:wildcard) { WildcardLocation.new(file) }
    it 'matches a precise location in the same file' do
      other = Location.new(file, other_line_no)

      expect( wildcard.match?(other) ).to be_true
    end

    it "doesn't match a precise location in another file" do
      other = Location.new(other_file, other_line_no)

      expect( wildcard.match?(other) ).to be_false
    end

     it "matches a wildcard in the same file" do
       other = WildcardLocation.new(file)

       expect( wildcard.match?(other) ).to be_true
     end

     it "doesn't match a wildcard in another file" do
       other = WildcardLocation.new(other_file)

       expect( wildcard.match?(other) ).to be_false
     end
  end

  context 'displaying as a string' do
    it 'shows "file:line_no" for a precise location' do
      location = Location.new(file, line_no)

      expect( location.to_s ).to eq("foo.feature:12")
    end

    it 'shows "file" for a precise location' do
      wildcard = WildcardLocation.new(file)

      expect( wildcard.to_s ).to eq("foo.feature")
    end
  end
end
