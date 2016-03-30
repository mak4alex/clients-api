class Client < ActiveRecord::Base

  scope :sort, -> (params) { order(params[:sort] ||= 'updated_at desc') }
  scope :pagination, -> (params) { page(params[:page] ||= 1).per(params[:per_page] ||= 25) }
  scope :fetch, -> (params = {}) { sort(params).pagination(params) }

  validates :name,      presence: true, length: { maximum: 255 }
  validates :sex,       inclusion: { in: [true, false],
                                     message: 'True for men, false for women'}
  validates :id_number, presence: true,
            format: { with: /\AID\d{7}\z/,
                      message: 'Invalid format. Must be like ID1234567.'}
  validates :phone,     presence: true,
            format: { with: /\A\+\d{1,3}\(\d{1,2}\)\d{7}\z/,
                      message: 'Invalid format. Must be like +123(12)1234567.'}
  validates :address,   presence: true


  def self.create_all(clients_attr)
    response = {clients: [], errors: []}

    clients_attr.each_with_index do |attr, index|
      attr = attr.permit(:name, :sex, :id_number, :phone, :address) if attr.respond_to? :permit
      client = Client.new(attr)
      if client.save
        response[:clients].push( { index: index, client: client } )
      else
        response[:errors].push( { index: index, message: client.errors } )
      end
    end

    response
  end

  def self.update_all(clients_attr)
    response = {clients: [], errors: []}

    clients_attr.each_with_index do |attr, index|
      client = nil
      begin
        client = Client.find(attr[:id])
        attr = attr.permit(:id, :name, :sex, :id_number, :phone, :address) if attr.respond_to? :permit
        if client.update(attr)
          response[:clients].push( client )
        else
          response[:errors].push( { index: index, message: client.errors } )
        end
      rescue ActiveRecord::RecordNotFound => exception
        response[:errors].push( { index: index, message: exception.to_s } )
      end
    end

    response
  end

  def self.delete_selected(client_ids)
    response = {deleted_clients: [], errors: []}

    client_ids.each_with_index do |id|
      begin
        client = Client.find(id)
        client.destroy
        response[:deleted_clients].push( client )
      rescue ActiveRecord::RecordNotFound
        response[:errors].push( { id: id, message: 'Resource not found' } )
      end
    end

    response
  end

end
