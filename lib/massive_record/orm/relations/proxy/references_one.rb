module MassiveRecord
  module ORM
    module Relations
      class Proxy
        #
        # Proxy used to reference one other object in another table.
        #
        class ReferencesOne < Proxy

          def proxy_target=(proxy_target)
            set_foreign_key_in_proxy_owner(proxy_target.id) if proxy_target
            super(proxy_target)
          end

          def replace(proxy_target)
            super
            set_foreign_key_in_proxy_owner(nil) if proxy_target.nil?
          end


          private

          def find_proxy_target
            proxy_target_class.find(proxy_owner.send(foreign_key))
          end

          def can_find_proxy_target?
            super || proxy_owner.send(foreign_key).present?
          end

          def set_foreign_key_in_proxy_owner(id)
            proxy_owner.send(foreign_key_setter, id) if proxy_owner.respond_to?(foreign_key_setter)
          end
        end
      end
    end
  end
end
