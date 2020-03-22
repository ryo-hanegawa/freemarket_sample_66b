# Freemarket_DataBase_plan

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, unique: true, index: true|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birth_year|integer|null: false, default: 0|
|birth_month|integer|null: false, default: 0|
|birth_day|integer|null: false, default: 0|
|phone_number|integer|null: false|

### Association
- has_many: creditcards, dependent: :destroy
- has_many: items, dependent: :destroy
- has_many: buyers, dependent: :destroy
- has_many: items, through: :buyers
- has_many: addresses, dependent: : destroy


## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|postalcode|integer|null: false|
|prefecture|integer|null: false, default: 0|
|municipalities|string|null: false|
|address|string|null: false|
|building_name|string||
|user|references|null: false, foreign_key: true|

### Association
- belongs_to: user
- belongs_to_active_hash :prefecture


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
|size|integer|null: false, default: 0|
|brand|references|null: false, foreign_key: true|
|condition|integer|null: false, default: 0|
|prefecture|integer|null: false, default: 0|
|deliberydate|integer|null: false, default: 0|
|postage|integer|null: false, default: 0|

### Association
- has_many: images, dependent: :destroy
- has_many: buyers, dependent: :destroy
- has_many: users, through: :buyers
- has_many: items_categories, dependent: :destroy
- has_many: categories, through: :items_categories
- belongs_to: user
- belongs_to: brand


## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|text|null: false|
|item|references|null: false, foreign_key: true|

### Association
- belongs_to: item


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
- has_ancestry


## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||

### Association
- has_many: items_brands