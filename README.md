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

[ModelName]の一覧表示用Queryを作成する場合

事前にObjectTypeを作成(下記参照)

app\graphql\types\query_type.rb
```ruby
module Types
  class QueryType < Types::BaseObject
    ....
    index [ModelName]
    ....
  end
end

```

### 詳細表示用Queryの作成

[ModelName]の詳細表示用Queryを作成する場合

事前にObjectTypeを作成(下記参照)

app\graphql\types\query_type.rb
```ruby
module Types
  class QueryType < Types::BaseObject
    ....
    show [ModelName]
    ....
  end
end
```

### 登録用Mutationの作成

[ModelName]の登録用Mutationを作成する場合

事前にObjectType/InputObjectTypeを作成(下記参照)

app\graphql\mutations\create_[model_name]_mutation.rb
```ruby
module Mutations
  class Create[ModelName]Mutation < BaseMutation
    create_mutation_for [ModelName]
  end
end
```

app\graphql\types\mutation_type.rb
```ruby
module Types
  class MutationType < Types::BaseObject

    ...

    field :create_[model_name], mutation: Mutations::Create[ModelName]Mutation

    ...

  end
end
```

### 更新用Mutationの作成

[ModelName]の更新用Mutationを作成する場合

事前にObjectType/InputObjectTypeを作成(下記参照)

app\graphql\mutations\update_[model_name]_mutation.rb
```ruby
module Mutations
  class Update[ModelName]Mutation < BaseMutation
    update_mutation_for [ModelName]
  end
end
```

app\graphql\types\mutation_type.rb
```ruby
module Types
  class MutationType < Types::BaseObject

    ...

    field :update_[model_name], mutation: Mutations::Update[ModelName]Mutation

    ...

  end
end
```

### 削除用Mutationの作成

[ModelName]の削除用Mutationを作成する場合

事前にObjectType/InputObjectTypeを作成(下記参照)

app\graphql\mutations\delete_[model_name]_mutation.rb
```ruby
module Mutations
  class Delete[ModelName]Mutation < BaseMutation
    delete_mutation_for [ModelName]
  end
end
```

app\graphql\types\mutation_type.rb
```ruby
module Types
  class MutationType < Types::BaseObject

    ...

    field :delete_[model_name], mutation: Mutations::Delete[ModelName]Mutation

    ...

  end
end
```

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

## Tips

カラムに無いフィールドを追加したい場合は、model classでattributeを指定してください。

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
