class User < ApplicationRecord

  include UserAuthentication
  include HasEmail



end
