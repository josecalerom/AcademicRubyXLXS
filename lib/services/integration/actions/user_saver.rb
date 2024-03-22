# Integration::Actions::UserSaver.new.call(user_data: {}, contacts_data: [])

module Integration
  module Actions
    class UserSaver
      CPF_REGEX = /\A\d{3}\.?\d{3}\.?\d{3}-?\d{2}\z/

      def call(user_data: {}, contacts_data: [])
        raise 'Chave CPF nao é válida' unless user_data[:cpf].match?(CPF_REGEX)

        user = User.find_by(cpf: user_data[:cpf])

        user = if user
          user.update(**user_data.reject { |arg| arg == :cpf })
          user.reload!
          user
        else
          raise "Falha na criaçao do User CPF=#{user_data[:cpf]}" unless User.create(**user_data)

          User.find_by(cpf: user_data[:cpf])
        end

        contacts_data.each do |contact|
          Contact.create(**contact, user_id: = user.id)
        end

        true
      end
    end
  end
end