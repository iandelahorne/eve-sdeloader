# Overall
- [ ] test with mysql
- [ ] cleanup DDLs and importing
- [ ] Import with NULL values where this makes sense
- [ ] test with capitalized table names
- [ ] test with schemadiff against dump

# Tables that look like they differ
`invpositions` and `mapdenormalize` look like they differ from the python
importer. This is due to `-0.0` in y position for `40476325` (`J105934 IV`)
being parsed as `0.0` in python

# Tables needing fixes
invtraits
invvolumes
mapcelestialstatistics
trntranslations
