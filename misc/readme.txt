README

Explains the "misc" directory.

Original MARC records: LaborArchivesMARCRecordsBatch.xml
Lookup file (for matching oclc numbers and extracting Archives West URLs, Wikidata identifiers, and 758$a values): table1.xml
Compare input original MARC records (LaborArchivesMARCRecordsBatch.xml) and lookup file (table1.xml): analyzeUnput.xsl
Main XSLT script: inserts2.xsl:
    inserts 758 and 856 fields into original MARC:
    input files: LaborArchivesMARCRecordsBatch.xml; table1.xml
    output file: inserts22.xml.
Sample output of inserts2.xsl: inserts22.xml
Analysis of sample output (i.e. inserts22.xml): checkOutput-annotated-2023-08-24.xml
    Could be useful for cleanng this dataset.
Analyze the ouput of inserts2.xsl: checkOutput.xsl
Sample raw output of checkOutput.xsl: checkOutput.xml
