// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_setting_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserSettingCollectionCollection on Isar {
  IsarCollection<UserSettingCollection> get userSettingCollections =>
      this.collection();
}

const UserSettingCollectionSchema = CollectionSchema(
  name: r'UserSettingCollection',
  id: 6898595761525252289,
  properties: {
    r'settingId': PropertySchema(
      id: 0,
      name: r'settingId',
      type: IsarType.long,
    ),
    r'title': PropertySchema(
      id: 1,
      name: r'title',
      type: IsarType.string,
    ),
    r'value': PropertySchema(
      id: 2,
      name: r'value',
      type: IsarType.string,
    )
  },
  estimateSize: _userSettingCollectionEstimateSize,
  serialize: _userSettingCollectionSerialize,
  deserialize: _userSettingCollectionDeserialize,
  deserializeProp: _userSettingCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'settingId': IndexSchema(
      id: 5388918550220204937,
      name: r'settingId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'settingId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _userSettingCollectionGetId,
  getLinks: _userSettingCollectionGetLinks,
  attach: _userSettingCollectionAttach,
  version: '3.1.0+1',
);

int _userSettingCollectionEstimateSize(
  UserSettingCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.value.length * 3;
  return bytesCount;
}

void _userSettingCollectionSerialize(
  UserSettingCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.settingId);
  writer.writeString(offsets[1], object.title);
  writer.writeString(offsets[2], object.value);
}

UserSettingCollection _userSettingCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserSettingCollection(
    settingId: reader.readLong(offsets[0]),
    title: reader.readString(offsets[1]),
    value: reader.readString(offsets[2]),
  );
  object.id = id;
  return object;
}

P _userSettingCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userSettingCollectionGetId(UserSettingCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userSettingCollectionGetLinks(
    UserSettingCollection object) {
  return [];
}

void _userSettingCollectionAttach(
    IsarCollection<dynamic> col, Id id, UserSettingCollection object) {
  object.id = id;
}

extension UserSettingCollectionByIndex
    on IsarCollection<UserSettingCollection> {
  Future<UserSettingCollection?> getBySettingId(int settingId) {
    return getByIndex(r'settingId', [settingId]);
  }

  UserSettingCollection? getBySettingIdSync(int settingId) {
    return getByIndexSync(r'settingId', [settingId]);
  }

  Future<bool> deleteBySettingId(int settingId) {
    return deleteByIndex(r'settingId', [settingId]);
  }

  bool deleteBySettingIdSync(int settingId) {
    return deleteByIndexSync(r'settingId', [settingId]);
  }

  Future<List<UserSettingCollection?>> getAllBySettingId(
      List<int> settingIdValues) {
    final values = settingIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'settingId', values);
  }

  List<UserSettingCollection?> getAllBySettingIdSync(
      List<int> settingIdValues) {
    final values = settingIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'settingId', values);
  }

  Future<int> deleteAllBySettingId(List<int> settingIdValues) {
    final values = settingIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'settingId', values);
  }

  int deleteAllBySettingIdSync(List<int> settingIdValues) {
    final values = settingIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'settingId', values);
  }

  Future<Id> putBySettingId(UserSettingCollection object) {
    return putByIndex(r'settingId', object);
  }

  Id putBySettingIdSync(UserSettingCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'settingId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySettingId(List<UserSettingCollection> objects) {
    return putAllByIndex(r'settingId', objects);
  }

  List<Id> putAllBySettingIdSync(List<UserSettingCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'settingId', objects, saveLinks: saveLinks);
  }
}

extension UserSettingCollectionQueryWhereSort
    on QueryBuilder<UserSettingCollection, UserSettingCollection, QWhere> {
  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterWhere>
      anySettingId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'settingId'),
      );
    });
  }
}

extension UserSettingCollectionQueryWhere on QueryBuilder<UserSettingCollection,
    UserSettingCollection, QWhereClause> {
  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterWhereClause>
      settingIdEqualTo(int settingId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'settingId',
        value: [settingId],
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterWhereClause>
      settingIdNotEqualTo(int settingId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'settingId',
              lower: [],
              upper: [settingId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'settingId',
              lower: [settingId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'settingId',
              lower: [settingId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'settingId',
              lower: [],
              upper: [settingId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterWhereClause>
      settingIdGreaterThan(
    int settingId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'settingId',
        lower: [settingId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterWhereClause>
      settingIdLessThan(
    int settingId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'settingId',
        lower: [],
        upper: [settingId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterWhereClause>
      settingIdBetween(
    int lowerSettingId,
    int upperSettingId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'settingId',
        lower: [lowerSettingId],
        includeLower: includeLower,
        upper: [upperSettingId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserSettingCollectionQueryFilter on QueryBuilder<
    UserSettingCollection, UserSettingCollection, QFilterCondition> {
  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> settingIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'settingId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> settingIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'settingId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> settingIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'settingId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> settingIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'settingId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
          QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
          QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> valueEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> valueGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> valueLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> valueBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'value',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> valueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> valueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
          QAfterFilterCondition>
      valueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
          QAfterFilterCondition>
      valueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'value',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> valueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection,
      QAfterFilterCondition> valueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'value',
        value: '',
      ));
    });
  }
}

extension UserSettingCollectionQueryObject on QueryBuilder<
    UserSettingCollection, UserSettingCollection, QFilterCondition> {}

extension UserSettingCollectionQueryLinks on QueryBuilder<UserSettingCollection,
    UserSettingCollection, QFilterCondition> {}

extension UserSettingCollectionQuerySortBy
    on QueryBuilder<UserSettingCollection, UserSettingCollection, QSortBy> {
  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterSortBy>
      sortBySettingId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'settingId', Sort.asc);
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterSortBy>
      sortBySettingIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'settingId', Sort.desc);
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterSortBy>
      sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterSortBy>
      sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterSortBy>
      sortByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterSortBy>
      sortByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }
}

extension UserSettingCollectionQuerySortThenBy
    on QueryBuilder<UserSettingCollection, UserSettingCollection, QSortThenBy> {
  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterSortBy>
      thenBySettingId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'settingId', Sort.asc);
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterSortBy>
      thenBySettingIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'settingId', Sort.desc);
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterSortBy>
      thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterSortBy>
      thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterSortBy>
      thenByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QAfterSortBy>
      thenByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }
}

extension UserSettingCollectionQueryWhereDistinct
    on QueryBuilder<UserSettingCollection, UserSettingCollection, QDistinct> {
  QueryBuilder<UserSettingCollection, UserSettingCollection, QDistinct>
      distinctBySettingId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'settingId');
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QDistinct>
      distinctByTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserSettingCollection, UserSettingCollection, QDistinct>
      distinctByValue({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'value', caseSensitive: caseSensitive);
    });
  }
}

extension UserSettingCollectionQueryProperty on QueryBuilder<
    UserSettingCollection, UserSettingCollection, QQueryProperty> {
  QueryBuilder<UserSettingCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserSettingCollection, int, QQueryOperations>
      settingIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'settingId');
    });
  }

  QueryBuilder<UserSettingCollection, String, QQueryOperations>
      titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<UserSettingCollection, String, QQueryOperations>
      valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'value');
    });
  }
}
