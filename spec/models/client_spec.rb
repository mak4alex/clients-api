require 'rails_helper'

RSpec.describe Client, type: :model do
  let(:client) { build :client }
  subject { client }


  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:id_number) }
  it { should validate_presence_of(:address) }

  it { should allow_value(true).for(:sex) }
  it { should allow_value(false).for(:sex) }

  it { should respond_to(:phone) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }



  it 'is valid with id_number like IDXXXXXXX' do
    %w(ID1234567 ID2314567 ID1252671 ID1514567).each do |id|
      should allow_value(id).for(:id_number)
    end

    %w(ID124567 ID2we4567 I21252671 12345678).each do |id|
      should_not allow_value(id).for(:id_number)
    end
  end

  it 'is valid with phone like +XXX(XX)XXXXXXX' do
    %w(+123(12)1234567 +22(12)1244567 +1(2)1231345 +375(99)1244567).each do |phone|
      should allow_value(phone).for(:phone)
    end

    %w(+1235(12)1234567 +2212()1244567 +1(2)121345678 +375(999)1244567).each do |phone|
      should_not allow_value(phone).for(:phone)
    end
  end


  describe '.create_all' do

    context 'when all clients are valid' do
      before(:each) do
        @clients = []
        3.times { @clients.push( attributes_for :client) }
        @response = Client.create_all(@clients)
      end

      it 'returns array of created clients' do
        expect(@response[:clients]).to have_exactly(@clients.size).items
      end

      it 'not contains any errors' do
        expect(@response[:errors]).to have_exactly(0).items
      end
    end

    context 'when some clients are invalid' do
      before(:each) do
        @clients = []
        @clients.push( attributes_for :client )
        @clients.push( attributes_for :client, phone: '+31412341')
        @clients.push( attributes_for :client, name: '')
        @response = Client.create_all(@clients)
      end

      it 'returns array of created clients' do
        expect(@response[:clients]).to have_exactly(1).items
      end

      it 'returns array of errors of not created clients' do
        expect(@response[:errors]).to have_exactly(2).items
      end
    end

  end

  describe '.update_all' do

    context 'when all clients are valid' do
      before(:each) do
        @created_clients = []
        3.times { @created_clients.push( create :client) }
        @attr_clients = []
        3.times do |n|
          attr_client = attributes_for( :client, id: @created_clients[n].id )
          @attr_clients.push attr_client
        end

        @response = Client.update_all(@attr_clients)
      end

      it 'returns array of updated clients' do
        expect(@response[:clients]).to have_exactly(@attr_clients.size).items
        expect(@response[:clients][0][:name]).to eql @attr_clients[0][:name]
      end

      it 'not contains any errors' do
        expect(@response[:errors]).to have_exactly(0).items
      end
    end

    context 'when some clients are invalid' do
      before(:each) do
        @created_clients = []
        3.times { @created_clients.push( create :client) }
        @attr_clients = []
        @attr_clients.push( attributes_for :client, id: @created_clients[0].id )
        @attr_clients.push( attributes_for :client, phone: '+31412341', id: @created_clients[1].id )
        @attr_clients.push( attributes_for :client, name: '', id: @created_clients[2].id )

        @response = Client.update_all(@attr_clients)
      end

      it 'returns array of created clients' do
        expect(@response[:clients]).to have_exactly(1).items
      end

      it 'returns array of errors of not created clients' do
        expect(@response[:errors]).to have_exactly(2).items
      end
    end

  end


end
