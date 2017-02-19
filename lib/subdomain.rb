class Subdomain
  def self.matches?(request)
    @organization = Organization.find_by(subdomain: request.subdomain)
    !!@organization
  end
end