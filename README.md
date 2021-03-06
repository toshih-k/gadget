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

一覧表示用Queryの作成
```sh
rails g gadget:index_query [ModelName]
```

詳細表示用Queryの作成
```sh
rails g gadget:show_query [ModelName]
```

登録用Mutationの作成
```sh
rails g gadget:create_mutation [ModelName]
```

更新用Mutationの作成
```sh
rails g gadget:update_mutation [ModelName]
```

削除用Mutationの作成
```sh
rails g gadget:delete_mutation [ModelName]
```

### ObjectTypeの作成


[ModelName]のObjectTypeを作成
```sh
rails g gadget:type [ModelName]
```

[ModelName]のInputObjectTypeを作成

```sh
rails g gadget:input_type [ModelName]
```

[ModelName]のPaginatedObjectTypeを作成
(後述するkaminariを使用したpagingクエリの結果セット取得に使用)
```sh
rails g gadget:paginated_type [ModelName]
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

### サンプルGQLの作成

```sh
rails g gadget:gql [ModelName]
```
を実行するとtmp/gql以下にcrud用のgql一式を作成します。(index用のものはpaginated前提)

## カスタマイズ

### indexクエリ

オプション

name[String]: クエリ名を変更
paginate[Boolean]: Kaminariベースのページングを行う

app/graphql/types/query_type.rb
```
  index Book, paginate: true, name: 'BooksPaginated'
```
返すObjectTypeが通常のObjectTypeの配列ではなく、[ModelName]PaginatedObjectTypeとなるため、別途generatorでpaginated object typeを作成する必要があります。

### showクエリ

オプション

name[String]: クエリ名を変更

app/graphql/types/query_type.rb
```
  show Book, name: 'AlternativeBookShowQuery'
```

## フィルタ

index/showクエリで絞り込みを行いたい場合などには、モデルクラスで静的メソッド
before_gadget_index_query/before_gadget_show_queryを定義し、ActiveRecordRelationオブジェクトを返すようにします。

## 認証

各処理で認証を行いたい場合は、モデルクラスで静的メソッドgadget_authorizationを定義します。
第1引数には、GraphQL rubyのcontextオブジェクト、第2引数には、mutation/queryの種別(create_mutaion, update_muation, delete_mutation, index_query, show_queryのいずれかの値)が入ります。
帰値は真偽をとり、falseを返すと認証エラーになります。
```ruby
class SomeClass < ApplicationRecord
  ...
  def self.gadget_authorization(context, type)
    # 削除は管理者のみに限定する
    return type != 'delete_mutation' or context[:user].is_admin?
  end
  ...
end
```


## Tips

* カラムに無いフィールドを追加したい場合は、model classでattributeを指定すれば追加されます。

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
