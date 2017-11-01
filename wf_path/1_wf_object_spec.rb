describe Wf do
  let(:wf) { Wf.new }

  it 'is a waterfall' do
    expect(wf.is_waterfall?).to be __
  end

  it 'flows when called' do
    expect(wf.has_flown?).to be __
  end

  it 'executes code in a chain block' do
    wf.chain { @foo = 1 }
    expect(@foo).to eq __
  end

  it 'executes code in chain block and store it in the outflow upon request' do
    wf.chain(:foo) { __ }
    expect(wf.outflow.foo).to eq 1
  end

  it 'executes code in a chain block and store it in the outflow (guess the name!)' do
    wf.chain(__) { 2 }
    expect(wf.outflow.bar).to eq 2
  end

  it 'is not dammed by default' do
    expect(wf.dammed?).to be __
    expect(wf.error_pool).to eq __
  end

  it 'is dammed if you dam it!' do
    wf.dam('error')
    expect(wf.dammed?).to be __
    expect(wf.error_pool).to eq __
  end

  it 'can be undammed' do
    wf.dam('error').reverse_flow
    expect(wf.dammed?).to be __
    expect(wf.error_pool).to eq __
  end

  it 'can be dammed conditionnaly (falsy)' do
    wf.when_falsy { false }
      .dam { 'error' }
    expect(wf.dammed?).to be __
    expect(wf.error_pool).to eq __
  end

  it 'can be dammed conditionnaly (truthy)' do
    wf.when_truthy { true }
      .dam { 'error' }
    expect(wf.dammed?).to be __
    expect(wf.error_pool).to eq __
  end

  it 'does not execute chain blocks once dammed' do
    expect do
      wf.when_falsy { __ }
        .dam { 'error' }
      .chain { raise 'I should not be executed because of damming before me' }
    end.to_not raise_error
  end

  it 'executes on_dam blocks once dammed' do
    listener = spy 'listener'
    wf.dam('errr')
      .on_dam { listener.failure }

    # expect(listener).to have_received :failure
    # expect(listener).to_not have_received :failure
  end
end
