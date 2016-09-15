# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 500

# Don't let testing shortcuts get into master by accident
fail("fdescribe left in tests") if `grep -r fdescribe Tests/ `.length > 1
fail("fit left in tests") if `grep -r fit Tests/ `.length > 1
