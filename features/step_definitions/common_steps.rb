Given 'I am on the Guinea Pig homepage' do
  @page = visit GuineaPigPage, using_params: {foo: :bar}
end
