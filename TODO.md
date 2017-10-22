# Overall
- [ ] test with mysql
- [ ] cleanup DDLs and importing
- [ ] test with capitalized table names

# Tables that look like they differ
`invpositions` and `mapdenormalize` look like they differ from the python
importer. This is due to `-0.0` in y position for `40476325` (`J105934 IV`)
being parsed as `0.0` in python

`invtraits` has different traitids due to insertion order.
`trntranslations` has more translations than
