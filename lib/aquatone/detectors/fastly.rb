module Aquatone
  module Detectors
    class Fastly < Aquatone::Detector
      self.meta = {
        :service         => "Fastly",
        :service_website => "https://www.fastly.com/",
        :author          => "Michael Henriksen (@michenriksen)",
        :description     => "Content delivery network"
      }

      CNAME_VALUE          = ".fastly.net".freeze
      RESPONSE_FINGERPRINT = "Fastly error: unknown domain".freeze

      def run
        return false unless cname_resource?
        if resource_value.end_with?(CNAME_VALUE)
          return get_request("http://#{host}/").body.include?(RESPONSE_FINGERPRINT)
        end
        false
      end
    end
  end
end
