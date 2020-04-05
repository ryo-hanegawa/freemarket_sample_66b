# Freemarket_DataBase_plan

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, unique: true, index: true|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_reading|string|null: false|
|first_name_reading|string|null: false|
|birth_year|integer|null: false, default: 0|
|birth_month|integer|null: false, default: 0|
|birth_day|integer|null: false, default: 0|
|phone_number|integer|null: false|

### Association
- has_one: creditcard, dependent: :destroy
- has_many: items, dependent: :destroy
- has_one: address, dependent: : destroy


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
- belongs_to_active_hash: prefecture


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
|category|references|null: false, foreign_key: true|
|brand|references|null: false, foreign_key: true|
|condition|integer|null: false, default: 0|
|prefecture|integer|null: false, default: 0|
|deliberydate|integer|null: false, default: 0|
|postage|integer|null: false, default: 0|
|buyer|references|foreign_key: true|

### Association
- has_many: images, dependent: :destroy
- belongs_to: category
- belongs_to: user
- belongs_to: brand


## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|text|null: false|
|item|references|null: false, foreign_key: true|

### Association
- belongs_to: item


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|

### Association
- has_many: items
- has_ancestry


## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||

### Association
- has_many: items