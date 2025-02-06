// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFiltersCollection on Isar {
  IsarCollection<Filters> get filters => this.collection();
}

const FiltersSchema = CollectionSchema(
  name: r'Filters',
  id: -1841271570770902873,
  properties: {
    r'categories': PropertySchema(
      id: 0,
      name: r'categories',
      type: IsarType.stringList,
    ),
    r'marks': PropertySchema(
      id: 1,
      name: r'marks',
      type: IsarType.stringList,
    )
  },
  estimateSize: _filtersEstimateSize,
  serialize: _filtersSerialize,
  deserialize: _filtersDeserialize,
  deserializeProp: _filtersDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _filtersGetId,
  getLinks: _filtersGetLinks,
  attach: _filtersAttach,
  version: '3.1.0+1',
);

int _filtersEstimateSize(
  Filters object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.categories;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final list = object.marks;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  return bytesCount;
}

void _filtersSerialize(
  Filters object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.categories);
  writer.writeStringList(offsets[1], object.marks);
}

Filters _filtersDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Filters();
  object.categories = reader.readStringList(offsets[0]);
  object.id = id;
  object.marks = reader.readStringList(offsets[1]);
  return object;
}

P _filtersDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset)) as P;
    case 1:
      return (reader.readStringList(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _filtersGetId(Filters object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _filtersGetLinks(Filters object) {
  return [];
}

void _filtersAttach(IsarCollection<dynamic> col, Id id, Filters object) {
  object.id = id;
}

extension FiltersQueryWhereSort on QueryBuilder<Filters, Filters, QWhere> {
  QueryBuilder<Filters, Filters, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FiltersQueryWhere on QueryBuilder<Filters, Filters, QWhereClause> {
  QueryBuilder<Filters, Filters, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Filters, Filters, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Filters, Filters, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Filters, Filters, QAfterWhereClause> idBetween(
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
}

extension FiltersQueryFilter
    on QueryBuilder<Filters, Filters, QFilterCondition> {
  QueryBuilder<Filters, Filters, QAfterFilterCondition> categoriesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'categories',
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> categoriesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'categories',
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition>
      categoriesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categories',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition>
      categoriesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'categories',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition>
      categoriesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'categories',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition>
      categoriesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'categories',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition>
      categoriesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'categories',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition>
      categoriesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'categories',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition>
      categoriesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'categories',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition>
      categoriesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'categories',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition>
      categoriesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categories',
        value: '',
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition>
      categoriesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'categories',
        value: '',
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> categoriesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categories',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> categoriesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categories',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> categoriesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categories',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition>
      categoriesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categories',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition>
      categoriesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categories',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> categoriesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categories',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Filters, Filters, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Filters, Filters, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Filters, Filters, QAfterFilterCondition> marksIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'marks',
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> marksIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'marks',
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> marksElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'marks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> marksElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'marks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> marksElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'marks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> marksElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'marks',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> marksElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'marks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> marksElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'marks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> marksElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'marks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> marksElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'marks',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> marksElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'marks',
        value: '',
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition>
      marksElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'marks',
        value: '',
      ));
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> marksLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'marks',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> marksIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'marks',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> marksIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'marks',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> marksLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'marks',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> marksLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'marks',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Filters, Filters, QAfterFilterCondition> marksLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'marks',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension FiltersQueryObject
    on QueryBuilder<Filters, Filters, QFilterCondition> {}

extension FiltersQueryLinks
    on QueryBuilder<Filters, Filters, QFilterCondition> {}

extension FiltersQuerySortBy on QueryBuilder<Filters, Filters, QSortBy> {}

extension FiltersQuerySortThenBy
    on QueryBuilder<Filters, Filters, QSortThenBy> {
  QueryBuilder<Filters, Filters, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Filters, Filters, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension FiltersQueryWhereDistinct
    on QueryBuilder<Filters, Filters, QDistinct> {
  QueryBuilder<Filters, Filters, QDistinct> distinctByCategories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categories');
    });
  }

  QueryBuilder<Filters, Filters, QDistinct> distinctByMarks() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'marks');
    });
  }
}

extension FiltersQueryProperty
    on QueryBuilder<Filters, Filters, QQueryProperty> {
  QueryBuilder<Filters, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Filters, List<String>?, QQueryOperations> categoriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categories');
    });
  }

  QueryBuilder<Filters, List<String>?, QQueryOperations> marksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'marks');
    });
  }
}
