class TradeGecko

  @@gecko_token = nil
  @@gecko = nil

  def self.client
    self.refresh_access_token unless @@gecko
    @@gecko
  end

  def self.access_token
    self.client unless @@gecko_token
    @@gecko_token
  end

  def self.refresh_access_token
    @@gecko = Gecko::Client.new('782a21c900d116964464ad14209825824b7bfb0a11c1790ca8cc473d53212d40', '403d5ad4aac1a7098da317cfe4441aa1b1efee06117794de30bf6e242691f69f')
    @@gecko.access_token = "2826f79444f3bf567ab47855f1cb6d974f4c8b1b67ccbca3866009db2eba5501"
  end
end