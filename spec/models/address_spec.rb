require 'rails_helper'

describe Address do
  describe '#create' do
    it "postal_codeが空では登録不可" do
      address = build(:address, postal_code: "")
      address.valid?
      expect(address.errors[:postal_code]).to include("を入力してください")
    end

    it "postal_codeがdate型データXXX-XXXXではない場合登録不可" do
      address = build(:address, postal_code: "1111-1111")
      address.valid?
      expect(address.errors[:postal_code]).to include("は不正な値です")
    end

    it "prefectureが空では登録不可" do
      address = build(:address, prefecture: "")
      address.valid?
      expect(address.errors[:prefecture]).to include("を入力してください")
    end

    it "cityが空では登録不可" do
      address = build(:address, city: "")
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end

    it "streetが空では登録不可" do
      address = build(:address, street: "")
      address.valid?
      expect(address.errors[:street]).to include("を入力してください")
    end

    it "first_nameが空では登録不可" do
      address = build(:address, first_name: "")
      address.valid?
      expect(address.errors[:first_name]).to include("を入力してください")
    end

    it "first_nameが16文字以上だと登録不可" do
      address = build(:address, first_name: "亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜")
      address.valid?
      expect(address.errors[:first_name][0]).to include("は15文字以内で入力してください")
    end

    it "last_nameが空では登録不可" do
      address = build(:address, last_name: "")
      address.valid?
      expect(address.errors[:last_name]).to include("を入力してください")
    end

    it "last_nameが16文字以上だと登録不可" do
      address = build(:address, last_name: "亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜")
      address.valid?
      expect(address.errors[:last_name][0]).to include("は15文字以内で入力してください")
    end

    it "first_name_readingが空では登録不可" do
      address = build(:address, first_name_reading: "")
      address.valid?
      expect(address.errors[:first_name_reading]).to include("を入力してください")
    end

    it "first_name_readingが16文字以上だと登録不可" do
      address = build(:address, first_name_reading: "アアアアアアアアアアアアアアアア")
      address.valid?
      expect(address.errors[:first_name_reading][0]).to include("は15文字以内で入力してください")
    end

    it "last_name_readingが空では登録不可" do
      address = build(:address, last_name_reading: "")
      address.valid?
      expect(address.errors[:last_name_reading]).to include("を入力してください")
    end

    it "last_name_readingが16文字以上だと登録不可" do
      address = build(:address, last_name_reading: "アアアアアアアアアアアアアアアア")
      address.valid?
      expect(address.errors[:last_name_reading][0]).to include("は15文字以内で入力してください")
    end

  end
end