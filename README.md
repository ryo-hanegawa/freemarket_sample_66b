# Freemarket_DataBase_plan

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, unique: true, index: true|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birth_year|integer|null: false|
|birth_month|integer|null: false|
|birth_day|integer|null: false|
|phone_number|integer|null: false|

### Association
- has_many: creditcards, dependent: :destroy
- has_many: items, dependent: :destroy
- has_many: buyers, dependent: :destroy
- has_many: items, through: :buyers
- has_many: address, dependent: : destroy


## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|postalcode|integer|null: false|
|prefecture|integer|null: false, foreign_key: true|
|municipalities|string|null: false|
|address|string|null: false|
|building_name|string||

### Association
- belongs_to: user
- belongs_to: prefecture


## creditcardsテーブル
|Column|Type|Options|
|------|----|-------|
|customer_id|string|null: false|
|card_id|string|null: false|
|user|references|null: false, foreign_key: true|

### Association
- belongs_to: user


## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|description|text|null: false|
|price|string|null: false|
|user|references|null: false, foreign_key: true|
|prefecture|references|null: false, foreign_key: true|

### Association
- has_many: images, dependent: :destroy
- has_many: buyers, dependent: :destroy
- has_many: users, through: :buyers
- has_many: items_categories, dependent: :destroy
- has_many: categories, through: :items_categories
- has_many: items_postages, dependent: :destroy
- has_many: postages, through: :items_postages
- belongs_to: user
- belongs_to: size
- belongs_to: brand
- belongs_to: condition
- belongs_to: prefecture
- belongs_to: delibery_date


## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|text|null: false|
|item|references|null: false, foreign_key: true|

### Association
- belongs_to: item


## items_postagesテーブル
|Column|Type|Options|
|------|----|-------|
|item|references|null: false, foreign_key: true|
|postage|references|null: false, foreign_key: true|

### Association
- belongs_to: item
- belongs_to: postage


## postagesテーブル
|Column|Type|Options|
|------|----|-------|
|postage|string|null: false|
|ancestry|string|null: false|

### Association
- has_many: items_postages


## buyersテーブル
|Column|Type|Options|
|------|----|-------|
|user|reference|null: false, foreign_key: true|
|item|reference|null: false, foreign_key: true|

### Association
- belongs_to: user
- belongs_to: item


## items_categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|item|reference|null: false, foreign_key: true|
|category|reference|null: false, foreign_key: true|

### Association
- belongs_to: item
- belongs_to: category


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|

### Association
- has_many: items, through: :items_categories
- has_many: items_categories


## sizesテーブル
|Column|Type|Options|
|------|----|-------|
|size|string|null: false|

### Association
- has_many: items


## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||

### Association
- has_many: items_brands


## conditionsテーブル
|Column|Type|Options|
|------|----|-------|
|status|string|null: false|

### Association
- has_many: items


## prefecturesテーブル
|Column|Type|Options|
|------|----|-------|
|prefecture|string|null: false|

### Association
- has_many: items
- has_many: address


## delibery_datesテーブル
|Column|Type|Options|
|------|----|-------|
|delibery_date|string|null: false|

### Association
- has_many: items