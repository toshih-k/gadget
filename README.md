Gadget
======

**Graphql / Activerecord Dynamic GEneraTor**

[graphql-ruby](https://github.com/rmosolgo/graphql-ruby)の

* ObjectType
* InputObjectType
* EnumType
* Query
* Mutation

の内容をActiveRecordの定義情報を使用してCRUDなAPIを動的に生成します。

## Usage

### 一覧表示用Queryの作成

incomming...

### 詳細表示用Queryの作成

incomming...

### 登録用Mutationの作成

incomming...

### 更新用Mutationの作成

incomming...

### 削除用Mutationの作成

incomming...

### ObjectTypeの作成

[ModelName]のObjectTypeを作成する場合

app/graphql/types/[model_name]_type.rb
```ruby
module Types
  class [ModelName]Type < Types::BaseObject
    from_active_record [ModelName]
  end
end
```

[ModelName]のInputObjectTypeを作成する場合

app/graphql/types/[model_name]_input_type.rb
```ruby
module Types
  class [ModelName]InputType < Types::BaseInputObject
    from_active_record [ModelName]
  end
end
```

[ModelName]の列挙型[enum_name]のEmumTypeを作成する場合

app/graphql/types/[enum_name]_type.rb
```ruby
module Types
  class [EnumName]Type < Types::BaseEnum
    from_active_record_enum [ModelName], '[enum_name]'
  end
end
```


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'gadget'
```

And then execute:
```bash
$ bundle install
```

Or install it yourself as:
```bash
$ gem install gadget
```

## Contributing
Contribution directions go here.

## License
Gadget is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
