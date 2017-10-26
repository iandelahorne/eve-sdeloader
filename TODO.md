# Overall
- [ ] test with mysql
- [x] cleanup DDLs and importing
- [x] test with capitalized table names

# Use pq.CopyIn for select BSD tables
Using `pq.CopyIn` for certain BSD tables will save almost 3 minutes:

- [ ] Use COPY IN for dgmTypeAttributes.yaml (13.5s)
- [ ] Use COPY IN for invItems.yaml (43.9s)
- [ ] Use COPY IN for invNames.yaml (35.2)
- [ ] Use COPY IN for invTypeReactions.yaml (34.7)
- [ ] Use COPY IN for invUniqueNames.yaml (40.2)

