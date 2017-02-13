describe 'Chaining services' do

  let(:service_class) do
    Class.new do
      include Waterfall
      def initialize(options = {})
        @options = {
          falsy_check:  true,
          truthy_check: false
        }.merge options
      end

      def call
        when_falsy { @options[:falsy_check] }
          .dam { 'errr1' }
        chain(:foo) { 'foo_value' }
        when_truthy { @options[:truthy_check] }
          .dam { 'errr2' }
        chain(:bar) { 'bar_value' }
      end
    end
  end

  let(:wf) { Wf.new }

  it 'you dont need to call child waterfalls, just pass the instance' do
    service = service_class.new
    expect(service.has_flown?).to be __
    Wf.new.chain { service }
    expect(service.has_flown?).to be __
  end

  context 'child executed without damming' do
    it 'passes data from one outflow to the other' do
      wf
        .chain(local_foo: :foo, local_bar: :bar) { service_class.new }

      expect(wf.outflow.local_foo).to eq __
      expect(wf.outflow.local_bar).to eq __
      expect(wf.dammed?).to be __
      expect(wf.error_pool).to eq __
    end

    it 'passes only required data from one outflow to the other' do
      wf
        .chain(__) { service_class.new }

      expect(wf.outflow.local_foo).to eq 'foo_value'
      expect(wf.outflow.local_bar).to eq nil
    end
  end

  context 'child dams on when_falsy' do
    it 'stops on dam yet passes existing data' do
      wf
        .chain(local_foo: :foo, local_bar: :bar) { service_class.new(falsy_check: false) }

      expect(wf.outflow.local_foo).to eq __
      expect(wf.outflow.local_bar).to eq __
      expect(wf.dammed?).to be __
      expect(wf.error_pool).to eq __
    end
  end

  context 'dammed on when_truthy statement' do
    it 'stops on dam yet passes existing data' do
      wf.chain(local_foo: :foo, local_bar: :bar) { service_class.new(truthy_check: true) }

      expect(wf.outflow.local_foo).to eq __
      expect(wf.outflow.local_bar).to eq __
      expect(wf.dammed?).to be __
      expect(wf.error_pool).to eq __
    end
  end
end
