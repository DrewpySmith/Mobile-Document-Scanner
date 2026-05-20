// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_document.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetScanDocumentCollection on Isar {
  IsarCollection<ScanDocument> get scanDocuments => this.collection();
}

const ScanDocumentSchema = CollectionSchema(
  name: r'ScanDocument',
  id: 6798300586929135318,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'pageImagePaths': PropertySchema(
      id: 1,
      name: r'pageImagePaths',
      type: IsarType.stringList,
    ),
    r'pdfPath': PropertySchema(
      id: 2,
      name: r'pdfPath',
      type: IsarType.string,
    ),
    r'rawOcrText': PropertySchema(
      id: 3,
      name: r'rawOcrText',
      type: IsarType.string,
    ),
    r'searchText': PropertySchema(
      id: 4,
      name: r'searchText',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 5,
      name: r'title',
      type: IsarType.string,
    ),
    r'translatedLanguage': PropertySchema(
      id: 6,
      name: r'translatedLanguage',
      type: IsarType.string,
    ),
    r'translatedText': PropertySchema(
      id: 7,
      name: r'translatedText',
      type: IsarType.string,
    )
  },
  estimateSize: _scanDocumentEstimateSize,
  serialize: _scanDocumentSerialize,
  deserialize: _scanDocumentDeserialize,
  deserializeProp: _scanDocumentDeserializeProp,
  idName: r'id',
  indexes: {
    r'title': IndexSchema(
      id: -7636685945352118059,
      name: r'title',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'title',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'searchText': IndexSchema(
      id: -8276020959797920665,
      name: r'searchText',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'searchText',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _scanDocumentGetId,
  getLinks: _scanDocumentGetLinks,
  attach: _scanDocumentAttach,
  version: '3.1.0+1',
);

int _scanDocumentEstimateSize(
  ScanDocument object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.pageImagePaths.length * 3;
  {
    for (var i = 0; i < object.pageImagePaths.length; i++) {
      final value = object.pageImagePaths[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.pdfPath.length * 3;
  bytesCount += 3 + object.rawOcrText.length * 3;
  bytesCount += 3 + object.searchText.length * 3;
  bytesCount += 3 + object.title.length * 3;
  {
    final value = object.translatedLanguage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.translatedText;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _scanDocumentSerialize(
  ScanDocument object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeStringList(offsets[1], object.pageImagePaths);
  writer.writeString(offsets[2], object.pdfPath);
  writer.writeString(offsets[3], object.rawOcrText);
  writer.writeString(offsets[4], object.searchText);
  writer.writeString(offsets[5], object.title);
  writer.writeString(offsets[6], object.translatedLanguage);
  writer.writeString(offsets[7], object.translatedText);
}

ScanDocument _scanDocumentDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ScanDocument();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.id = id;
  object.pageImagePaths = reader.readStringList(offsets[1]) ?? [];
  object.pdfPath = reader.readString(offsets[2]);
  object.rawOcrText = reader.readString(offsets[3]);
  object.title = reader.readString(offsets[5]);
  object.translatedLanguage = reader.readStringOrNull(offsets[6]);
  object.translatedText = reader.readStringOrNull(offsets[7]);
  return object;
}

P _scanDocumentDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _scanDocumentGetId(ScanDocument object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _scanDocumentGetLinks(ScanDocument object) {
  return [];
}

void _scanDocumentAttach(
    IsarCollection<dynamic> col, Id id, ScanDocument object) {
  object.id = id;
}

extension ScanDocumentQueryWhereSort
    on QueryBuilder<ScanDocument, ScanDocument, QWhere> {
  QueryBuilder<ScanDocument, ScanDocument, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterWhere> anyTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'title'),
      );
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterWhere> anySearchText() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'searchText'),
      );
    });
  }
}

extension ScanDocumentQueryWhere
    on QueryBuilder<ScanDocument, ScanDocument, QWhereClause> {
  QueryBuilder<ScanDocument, ScanDocument, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<ScanDocument, ScanDocument, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterWhereClause> idBetween(
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

  QueryBuilder<ScanDocument, ScanDocument, QAfterWhereClause> titleEqualTo(
      String title) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'title',
        value: [title],
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterWhereClause> titleNotEqualTo(
      String title) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [],
              upper: [title],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [title],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [title],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [],
              upper: [title],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterWhereClause> titleGreaterThan(
    String title, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'title',
        lower: [title],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterWhereClause> titleLessThan(
    String title, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'title',
        lower: [],
        upper: [title],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterWhereClause> titleBetween(
    String lowerTitle,
    String upperTitle, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'title',
        lower: [lowerTitle],
        includeLower: includeLower,
        upper: [upperTitle],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterWhereClause> titleStartsWith(
      String TitlePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'title',
        lower: [TitlePrefix],
        upper: ['$TitlePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterWhereClause> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'title',
        value: [''],
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterWhereClause>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'title',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'title',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'title',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'title',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterWhereClause> searchTextEqualTo(
      String searchText) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'searchText',
        value: [searchText],
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterWhereClause>
      searchTextNotEqualTo(String searchText) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchText',
              lower: [],
              upper: [searchText],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchText',
              lower: [searchText],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchText',
              lower: [searchText],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchText',
              lower: [],
              upper: [searchText],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterWhereClause>
      searchTextGreaterThan(
    String searchText, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'searchText',
        lower: [searchText],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterWhereClause>
      searchTextLessThan(
    String searchText, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'searchText',
        lower: [],
        upper: [searchText],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterWhereClause> searchTextBetween(
    String lowerSearchText,
    String upperSearchText, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'searchText',
        lower: [lowerSearchText],
        includeLower: includeLower,
        upper: [upperSearchText],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterWhereClause>
      searchTextStartsWith(String SearchTextPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'searchText',
        lower: [SearchTextPrefix],
        upper: ['$SearchTextPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterWhereClause>
      searchTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'searchText',
        value: [''],
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterWhereClause>
      searchTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'searchText',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'searchText',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'searchText',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'searchText',
              upper: [''],
            ));
      }
    });
  }
}

extension ScanDocumentQueryFilter
    on QueryBuilder<ScanDocument, ScanDocument, QFilterCondition> {
  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pageImagePathsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pageImagePaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pageImagePathsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pageImagePaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pageImagePathsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pageImagePaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pageImagePathsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pageImagePaths',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pageImagePathsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pageImagePaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pageImagePathsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pageImagePaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pageImagePathsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pageImagePaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pageImagePathsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pageImagePaths',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pageImagePathsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pageImagePaths',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pageImagePathsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pageImagePaths',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pageImagePathsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pageImagePaths',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pageImagePathsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pageImagePaths',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pageImagePathsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pageImagePaths',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pageImagePathsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pageImagePaths',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pageImagePathsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pageImagePaths',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pageImagePathsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pageImagePaths',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pdfPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pdfPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pdfPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pdfPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pdfPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pdfPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pdfPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pdfPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pdfPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pdfPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pdfPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pdfPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pdfPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pdfPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pdfPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pdfPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pdfPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pdfPath',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      pdfPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pdfPath',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      rawOcrTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rawOcrText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      rawOcrTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rawOcrText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      rawOcrTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rawOcrText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      rawOcrTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rawOcrText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      rawOcrTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rawOcrText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      rawOcrTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rawOcrText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      rawOcrTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rawOcrText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      rawOcrTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rawOcrText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      rawOcrTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rawOcrText',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      rawOcrTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rawOcrText',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      searchTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      searchTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'searchText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      searchTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'searchText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      searchTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'searchText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      searchTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'searchText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      searchTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'searchText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      searchTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'searchText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      searchTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'searchText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      searchTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchText',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      searchTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'searchText',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition> titleEqualTo(
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

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      titleGreaterThan(
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

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition> titleLessThan(
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

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition> titleBetween(
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

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      titleStartsWith(
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

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition> titleEndsWith(
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

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedLanguageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'translatedLanguage',
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedLanguageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'translatedLanguage',
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedLanguageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'translatedLanguage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedLanguageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'translatedLanguage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedLanguageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'translatedLanguage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedLanguageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'translatedLanguage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedLanguageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'translatedLanguage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedLanguageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'translatedLanguage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedLanguageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'translatedLanguage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedLanguageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'translatedLanguage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedLanguageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'translatedLanguage',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedLanguageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'translatedLanguage',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedTextIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'translatedText',
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedTextIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'translatedText',
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedTextEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'translatedText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedTextGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'translatedText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedTextLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'translatedText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedTextBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'translatedText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'translatedText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'translatedText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'translatedText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'translatedText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'translatedText',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterFilterCondition>
      translatedTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'translatedText',
        value: '',
      ));
    });
  }
}

extension ScanDocumentQueryObject
    on QueryBuilder<ScanDocument, ScanDocument, QFilterCondition> {}

extension ScanDocumentQueryLinks
    on QueryBuilder<ScanDocument, ScanDocument, QFilterCondition> {}

extension ScanDocumentQuerySortBy
    on QueryBuilder<ScanDocument, ScanDocument, QSortBy> {
  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy> sortByPdfPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdfPath', Sort.asc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy> sortByPdfPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdfPath', Sort.desc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy> sortByRawOcrText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rawOcrText', Sort.asc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy>
      sortByRawOcrTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rawOcrText', Sort.desc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy> sortBySearchText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchText', Sort.asc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy>
      sortBySearchTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchText', Sort.desc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy>
      sortByTranslatedLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translatedLanguage', Sort.asc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy>
      sortByTranslatedLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translatedLanguage', Sort.desc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy>
      sortByTranslatedText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translatedText', Sort.asc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy>
      sortByTranslatedTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translatedText', Sort.desc);
    });
  }
}

extension ScanDocumentQuerySortThenBy
    on QueryBuilder<ScanDocument, ScanDocument, QSortThenBy> {
  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy> thenByPdfPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdfPath', Sort.asc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy> thenByPdfPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdfPath', Sort.desc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy> thenByRawOcrText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rawOcrText', Sort.asc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy>
      thenByRawOcrTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rawOcrText', Sort.desc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy> thenBySearchText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchText', Sort.asc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy>
      thenBySearchTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchText', Sort.desc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy>
      thenByTranslatedLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translatedLanguage', Sort.asc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy>
      thenByTranslatedLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translatedLanguage', Sort.desc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy>
      thenByTranslatedText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translatedText', Sort.asc);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QAfterSortBy>
      thenByTranslatedTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translatedText', Sort.desc);
    });
  }
}

extension ScanDocumentQueryWhereDistinct
    on QueryBuilder<ScanDocument, ScanDocument, QDistinct> {
  QueryBuilder<ScanDocument, ScanDocument, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QDistinct>
      distinctByPageImagePaths() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pageImagePaths');
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QDistinct> distinctByPdfPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pdfPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QDistinct> distinctByRawOcrText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rawOcrText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QDistinct> distinctBySearchText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'searchText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QDistinct>
      distinctByTranslatedLanguage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'translatedLanguage',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ScanDocument, ScanDocument, QDistinct> distinctByTranslatedText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'translatedText',
          caseSensitive: caseSensitive);
    });
  }
}

extension ScanDocumentQueryProperty
    on QueryBuilder<ScanDocument, ScanDocument, QQueryProperty> {
  QueryBuilder<ScanDocument, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ScanDocument, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<ScanDocument, List<String>, QQueryOperations>
      pageImagePathsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pageImagePaths');
    });
  }

  QueryBuilder<ScanDocument, String, QQueryOperations> pdfPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pdfPath');
    });
  }

  QueryBuilder<ScanDocument, String, QQueryOperations> rawOcrTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rawOcrText');
    });
  }

  QueryBuilder<ScanDocument, String, QQueryOperations> searchTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'searchText');
    });
  }

  QueryBuilder<ScanDocument, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<ScanDocument, String?, QQueryOperations>
      translatedLanguageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'translatedLanguage');
    });
  }

  QueryBuilder<ScanDocument, String?, QQueryOperations>
      translatedTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'translatedText');
    });
  }
}
