class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable


    has_many :orders, dependent: :destroy
    has_many :cart_items, dependent: :destroy
    has_many :addresses, dependent: :destroy


    validates :last_name,  presence: true
    validates :first_name, presence: true
    validates :last_name_kana, presence: true
    validates :first_name_kana, presence: true
    validates :birth, presence: true
    validates :postcode, presence: true
    validates :prefecture_code, presence: true
    validates :address_city, presence: true
    validates :address_street, presence: true
    validates :tel_number, presence: true

    
  def customer_name
    last_name + " " + first_name
  end

  def customer_name_kana
    last_name_kana + " " + first_name_kana
  end



  # jpostal.jsで使うメソッド。郵便番号を入力で、住所自動入力
  include JpPrefecture
  jp_prefecture :prefecture_code
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end


    #is_deletedがfalseなら、有効。trueなら退会
  def active_for_authentication?
    super && (is_deleted == false)
  end


  # 個別の住所をまとめて表示させる。
  def join_address
    "#{self.prefecture_name}#{self.address_city}#{self.address_street}"
  end

  #生年月日から、年齢を計算する
  def age
    dob = self.birth # birth カラムの値を取得
    now = Time.current.to_date
    age = now.year - dob.year - (now.strftime("%m%d") < dob.strftime("%m%d") ? 1 : 0)
    return age
  end
  # strftime = rubyのメソッド。日付や時刻を指定されたフォーマットで文字列に変換する。
  # 例: now.strftime("%y/%m/%d")
  # メソッドの最後に return を書くことで、その時点での値を返してメソッドを終了


end
