class User < ApplicationRecord
    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: { message: 'Password can\'t be blank'} # null 일 경우 error
    validates :password, length: { minimum: 6, allow_nil: true } # password length 6 이하면 error, nil 이어도 error x
    before_validation :ensure_session_token # validation 하기 전에 ensure_ ~ 실행됨

    attr_reader :password

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        # `user&.is_password?(password)` is syntactic sugar for
        # `user && user.is_password?(password)`
        user&.is_password?(password) ? user : nil
        # user 를 찾고, password가 맞으면 user, 아니면 nil
      end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password) # BCrypt password를 암호화 시키는 것
        # 암호화된 password를 self User에 저장함
    end

    def is_password?(password)
        BCrypt::Password.new(password_digest).is_password?(password)
        # 들어온 password와 저장된 password가 같은지 확인 맞으면 true / 틀리면 false
    end

    def reset_session_token!
        self.session_token = generate_unique_session_token # 고유의 식별 생성
        self.save! # 식별번호를 가진 상태 저장
        self.session_token # 식별번호 리턴
    end

    def ensure_session_token
        self.session_token ||= generate_unique_session_token
        # 식별번호가 있으면 그대로 쓰고 ||= 비어있으면 새로 생성
    end

    def generate_unique_session_token
        # `SecureRandom::urlsafe_base64` does not guarantee uniqueness. Wrapping
        # this call in a loop ensures that no other user has the generated token.
        loop do
            session_token = SecureRandom::urlsafe_base64(16) # 사용자를 구분하는 랜덤넘버
            return session_token unless User.exists?(session_token: session_token)
        end
    end

    

end
