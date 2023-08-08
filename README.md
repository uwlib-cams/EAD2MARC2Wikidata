# EAD2MARC2Wikidata
tools and workflows for converting archival metadata from EAD to MARC21 to Wikidata, and interlinking between description sets

## To figure out:
* Get corrected URI's into 856 fields in MARC data:
** MARC data as MARCXML
** OCLC numbers, Wikidata id's, corrected URI's in excel spreadsheet
** Could use XSLT/Python and MARCEdit? Emailed Benjamin/Theo
** Could use OpenRefine start to finish: emailed Thad
* Get Wikidata URI's into MARC data
    * The place to record WD items is 758.  This is an example:
    758 ## ǂi Wikidata item: ǂa Mary Lou Dickerson papers ǂ2 wikidata ǂ4 http://www.wikidata.org/entity/P2888 ǂ0 (wikidata)Q108541067 ǂ1    http://www.wikidata.org/entity/Q108541067

    * In other words:

Record the label from the Wikidata item in $a
The URI in $4 is the property "exact match"
The ID itself goes in $0 preceded by (wikidata)
The concept URI (RWO URI) goes in $1

* Push MARC changes to OCLC
  ** Junghae knows how to do MARCEdit
  ** Emailed Thad about OpenRefine
* Get Wikidata URI's into finding aids
** Conor, Eulie, Elaine

## Bonus points:
* Primo persistent URI's for catalog records into finding aids
* subject headings from catalog records into finding aids
