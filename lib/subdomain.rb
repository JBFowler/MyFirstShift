class Subdomain
  def self.matches?(request)
    @organization ||= Organization.find_by(request.subdomain)
    !!@organization
  end
end